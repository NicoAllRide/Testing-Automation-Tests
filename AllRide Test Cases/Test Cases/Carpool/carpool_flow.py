import time
import threading
from websocket import create_connection, WebSocketConnectionClosedException


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

        # reconnection
        self.max_retries = 5
        self.retry_delay = 2  # seconds

    # -----------------------------------------------------
    # CONNECT / RECONNECT
    # -----------------------------------------------------
    def _connect_socket(self, url, name):
        """Connect or reconnect a websocket."""
        for attempt in range(1, self.max_retries + 1):
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
    # SAFE SEND with automatic reconnection
    # -----------------------------------------------------
    def safe_send(self, sock, message, is_driver=True):
        """Send a message; reconnect and retry if pipe is broken."""
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

            if not sock:
                self.error = f"Fatal: Could not reconnect {'driver' if is_driver else 'user'}"
                self.stop_flag = True
                return False

            # retry send
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
    def safe_recv(self, sock, timeout=10):
        sock.settimeout(timeout)
        try:
            return sock.recv()
        except Exception:
            return None

    # -----------------------------------------------------
    # PING KEEPALIVE
    # -----------------------------------------------------
    def ping_loop(self, sock, is_driver=True):
        while not self.stop_flag:
            try:
                sock.ping()
            except Exception:
                print("[PING ERROR] reconnecting due to ping failure")
                if is_driver:
                    self.reconnect_driver()
                    sock = self.sock_driver
                else:
                    self.reconnect_user()
                    sock = self.sock_user

            time.sleep(3)

    # -----------------------------------------------------
    # MAIN FLOW
    # -----------------------------------------------------
    def run(self):
        # connect both sockets
        self.sock_driver = self._connect_socket(self.driver_url, "driver")
        self.sock_user = self._connect_socket(self.user_url, "user")

        if not self.sock_driver or not self.sock_user:
            return f"FAIL: {self.error}"

        # ping threads
        threading.Thread(target=self.ping_loop, args=(self.sock_driver, True), daemon=True).start()
        threading.Thread(target=self.ping_loop, args=(self.sock_user, False), daemon=True).start()

        # ---------------------- DRIVER SEQUENCE ----------------------
        seq = [
            ("driver", '40/carpoolRealtime'),
            ("driver", f'42/carpoolRealtime,["join", {{"userId":"{self.driver_id}","tripInstanceId":"{self.trip_id}"}}]'),
            ("driver", f'42/carpoolRealtime,["start", {{"userId":"{self.driver_id}","tripInstanceId":"{self.trip_id}","latitude":-34.4111,"longitude":-70.8537}}]')
        ]

        for target, msg in seq:
            sock = self.sock_driver if target == "driver" else self.sock_user
            if not self.safe_send(sock, msg, is_driver=(target == "driver")):
                return f"FAIL: {self.error}"
            self.safe_recv(sock)

        # ---------------------- USER SEQUENCE ----------------------
        seq2 = [
            ("user", '40/carpoolRealtime'),
            ("user", f'42/carpoolRealtime,["join", {{"userId":"{self.user_id}","tripInstanceId":"{self.trip_id}"}}]')
        ]

        for target, msg in seq2:
            sock = self.sock_user
            if not self.safe_send(sock, msg, is_driver=False):
                return f"FAIL: {self.error}"
            self.safe_recv(sock)

        # ---------------------- POSITIONS ----------------------
        for i in range(150):  # long journey
            if self.stop_flag:
                break

            # driver
            self.safe_send(
                self.sock_driver,
                f'42/carpoolRealtime,["newPosition", {{"latitude":-34.4112,"longitude":-70.8536}}]',
                is_driver=True
            )
            self.safe_recv(self.sock_driver)

            # user
            self.safe_send(
                self.sock_user,
                f'42/carpoolRealtime,["newPosition", {{"latitude":-34.4113,"longitude":-70.8535}}]',
                is_driver=False
            )
            self.safe_recv(self.sock_user)

            time.sleep(1)

        if self.error:
            return f"FAIL: {self.error}"

        return "PASS"


def run_carpool_flow(driver_url, user_url, driver_id, user_id, trip_id):
    flow = CarpoolRealtimeFlow(driver_url, user_url, driver_id, user_id, trip_id)
    return flow.run()
