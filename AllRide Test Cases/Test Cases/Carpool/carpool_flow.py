import time
import threading
from websocket import create_connection


class CarpoolRealtimeFlow:

    def __init__(self, driver_url, user_url, driver_id, user_id, trip_id):
        self.driver_url = driver_url
        self.user_url = user_url
        self.driver_id = driver_id
        self.user_id = user_id
        self.trip_id = trip_id

        self.sock_driver = None
        self.sock_user = None

        self.stop_flag = False
        self.error = None

        # reconexión
        self.max_retries = 3
        self.retry_delay = 2  # segundos

        # timeout global
        self.global_timeout = 180  # segundos
        self.start_time = time.time()

    # -----------------------------------------------------
    # TIMEOUT GLOBAL
    # -----------------------------------------------------
    def _check_global_timeout(self):
        if time.time() - self.start_time > self.global_timeout:
            if not self.error:
                self.error = "Global timeout reached"
            self.stop_flag = True
            print("[TIMEOUT] Global timeout reached, stopping flow.")
            return True
        return False

    # -----------------------------------------------------
    # CONNECT / RECONNECT
    # -----------------------------------------------------
    def _connect_socket(self, url, name):
        """Conecta o re-conecta un websocket."""
        for attempt in range(1, self.max_retries + 1):
            if self._check_global_timeout():
                return None

            try:
                ws = create_connection(url, ping_interval=0)
                print(f"[OK] Connected {name} (attempt {attempt})")
                return ws
            except Exception as e:
                print(f"[WARN] Failed to connect {name}: {e} (attempt {attempt})")
                time.sleep(self.retry_delay)

        self.error = f"Could not connect {name} after {self.max_retries} attempts"
        self.stop_flag = True
        return None

    def reconnect_driver(self):
        print("[RECONNECT] Reconnecting driver...")
        self.sock_driver = self._connect_socket(self.driver_url, "driver")

    def reconnect_user(self):
        print("[RECONNECT] Reconnecting user...")
        self.sock_user = self._connect_socket(self.user_url, "user")

    # -----------------------------------------------------
    # SAFE SEND con reconexión
    # -----------------------------------------------------
    def safe_send(self, sock, message, is_driver=True):
        """Envía un mensaje; si falla, reintenta una vez tras reconectar."""
        if self.stop_flag or self._check_global_timeout():
            return False

        try:
            sock.send(message)
            return True
        except Exception as e:
            print(f"[ERROR] Send failed: {e}. Attempting reconnection...")

            if is_driver:
                self.reconnect_driver()
                sock = self.sock_driver
            else:
                self.reconnect_user()
                sock = self.sock_user

            if self.stop_flag or self._check_global_timeout() or not sock:
                if not self.error:
                    self.error = f"Fatal: Could not reconnect {'driver' if is_driver else 'user'}"
                self.stop_flag = True
                return False

            # Reintento de envío
            try:
                sock.send(message)
                print("[OK] Resent message after reconnection")
                return True
            except Exception as e2:
                self.error = f"Send failed after reconnection: {e2}"
                self.stop_flag = True
                return False

    # -----------------------------------------------------
    # SAFE RECV
    # -----------------------------------------------------
    def safe_recv(self, sock, timeout=5):
        if self.stop_flag or self._check_global_timeout():
            return None

        sock.settimeout(timeout)
        try:
            return sock.recv()
        except Exception:
            # Si no llega nada, seguimos; no es crítico
            return None

    # -----------------------------------------------------
    # PING KEEPALIVE
    # -----------------------------------------------------
    def ping_loop(self, name, is_driver=True):
        sock = self.sock_driver if is_driver else self.sock_user

        while not self.stop_flag and not self._check_global_timeout():
            try:
                if sock:
                    sock.ping()
            except Exception as e:
                print(f"[PING ERROR] {name}: {e}, trying to reconnect...")
                if is_driver:
                    self.reconnect_driver()
                    sock = self.sock_driver
                else:
                    self.reconnect_user()
                    sock = self.sock_user

                if not sock:
                    self.error = f"Ping reconnection failed for {name}"
                    self.stop_flag = True
                    return

            time.sleep(3)

    # -----------------------------------------------------
    # MAIN FLOW
    # -----------------------------------------------------
    def run(self):
        self.start_time = time.time()  # reinicia timer por si acaso

        # Conectar ambos sockets
        self.sock_driver = self._connect_socket(self.driver_url, "driver")
        self.sock_user = self._connect_socket(self.user_url, "user")

        if not self.sock_driver or not self.sock_user:
            return f"FAIL: {self.error}"

        # Hilos de ping
        threading.Thread(target=self.ping_loop, args=("driver", True), daemon=True).start()
        threading.Thread(target=self.ping_loop, args=("user", False), daemon=True).start()

        # ---------------------- DRIVER: 40 -> JOIN -> START ----------------------
        driver_seq = [
            ('driver', '40/carpoolRealtime'),
            ('driver', f'42/carpoolRealtime,["join", {{"userId":"{self.driver_id}","tripInstanceId":"{self.trip_id}"}}]'),
            ('driver', f'42/carpoolRealtime,["start", {{"userId":"{self.driver_id}","tripInstanceId":"{self.trip_id}","latitude":-34.4111,"longitude":-70.8537}}]')
        ]

        for target, msg in driver_seq:
            if self.stop_flag or self._check_global_timeout():
                break

            sock = self.sock_driver
            if not self.safe_send(sock, msg, is_driver=True):
                return f"FAIL: {self.error}"
            self.safe_recv(sock)

        if self.stop_flag and self.error:
            return f"FAIL: {self.error}"

        # ---------------------- USER: 40 -> JOIN ----------------------
        user_seq = [
            ('user', '40/carpoolRealtime'),
            ('user', f'42/carpoolRealtime,["join", {{"userId":"{self.user_id}","tripInstanceId":"{self.trip_id}"}}]')
        ]

        for target, msg in user_seq:
            if self.stop_flag or self._check_global_timeout():
                break

            sock = self.sock_user
            if not self.safe_send(sock, msg, is_driver=False):
                return f"FAIL: {self.error}"
            self.safe_recv(sock)

        if self.stop_flag and self.error:
            return f"FAIL: {self.error}"

        # ---------------------- POSITIONS (viaje largo) ----------------------
        for i in range(150):
            if self.stop_flag or self._check_global_timeout():
                break

            # Driver newPosition
            if not self.safe_send(
                self.sock_driver,
                f'42/carpoolRealtime,["newPosition", {{"latitude":-34.4112,"longitude":-70.8536}}]',
                is_driver=True
            ):
                return f"FAIL: {self.error}"

            self.safe_recv(self.sock_driver)

            # User newPosition
            if not self.safe_send(
                self.sock_user,
                f'42/carpoolRealtime,["newPosition", {{"latitude":-34.4113,"longitude":-70.8535}}]',
                is_driver=False
            ):
                return f"FAIL: {self.error}"

            self.safe_recv(self.sock_user)

            time.sleep(1)

        # ---------------------- RESULTADO FINAL ----------------------
        if self.error:
            return f"FAIL: {self.error}"

        return "PASS"


def run_carpool_flow(driver_url, user_url, driver_id, user_id, trip_id):
    flow = CarpoolRealtimeFlow(driver_url, user_url, driver_id, user_id, trip_id)
    return flow.run()
