import json
import threading
import time
from websocket import create_connection, WebSocketConnectionClosedException, WebSocketException


class CarpoolRealtimeFlow:

    def __init__(self, driver_url, user_url, driver_id, user_id, trip_id):
        self.driver_url = driver_url
        self.user_url = user_url
        self.driver_id = driver_id
        self.user_id = user_id
        self.trip_id = trip_id

        self.sock_driver = None
        self.sock_user = None

        self.stop_threads = False
        self.error = None

    # -------------------------------------------
    # INTERNAL HELPERS
    # -------------------------------------------
    def safe_send(self, sock, msg):
        """Send a WS message and capture connection errors."""
        try:
            sock.send(msg)
        except Exception as e:
            self.error = f"Send failed: {e}"
            self.stop_threads = True

    def safe_recv(self, sock, timeout=10):
        sock.settimeout(timeout)
        try:
            return sock.recv()
        except Exception:
            return None

    # -------------------------------------------
    # PING THREAD
    # -------------------------------------------
    def ping_loop(self, sock):
        while not self.stop_threads:
            try:
                sock.ping()
            except Exception as e:
                self.error = f"Ping failed: {e}"
                self.stop_threads = True
                return
            time.sleep(3)

    # -------------------------------------------
    # MAIN FLOW
    # -------------------------------------------
    def run(self):
        # -----------------------------
        # CONNECT BOTH SOCKETS
        # -----------------------------
        try:
            self.sock_driver = create_connection(self.driver_url, ping_interval=0)
            self.sock_user = create_connection(self.user_url, ping_interval=0)
        except Exception as e:
            return f"FAIL: Could not connect to WebSocket: {e}"

        # Start keepalive threads
        threading.Thread(target=self.ping_loop, args=(self.sock_driver,), daemon=True).start()
        threading.Thread(target=self.ping_loop, args=(self.sock_user,), daemon=True).start()

        # -----------------------------
        # DRIVER 40 -> JOIN -> START
        # -----------------------------
        try:
            self.safe_send(self.sock_driver, "40/carpoolRealtime")
            self.safe_recv(self.sock_driver)

            self.safe_send(
                self.sock_driver,
                f'42/carpoolRealtime,["join", {{"userId":"{self.driver_id}","tripInstanceId":"{self.trip_id}"}}]'
            )
            self.safe_recv(self.sock_driver)

            self.safe_send(
                self.sock_driver,
                f'42/carpoolRealtime,["start", {{"userId":"{self.driver_id}","tripInstanceId":"{self.trip_id}","latitude":-34.4111,"longitude":-70.8537}}]'
            )
            self.safe_recv(self.sock_driver)

        except Exception as e:
            return f"FAIL: Driver start sequence crashed: {e}"

        # -----------------------------
        # USER 40 -> JOIN
        # -----------------------------
        try:
            self.safe_send(self.sock_user, "40/carpoolRealtime")
            self.safe_recv(self.sock_user)

            self.safe_send(
                self.sock_user,
                f'42/carpoolRealtime,["join", {{"userId":"{self.user_id}","tripInstanceId":"{self.trip_id}"}}]'
            )
            self.safe_recv(self.sock_user)

        except Exception as e:
            return f"FAIL: User join sequence crashed: {e}"

        # -----------------------------
        # SEND POSITIONS (Driver + User)
        # -----------------------------
        try:
            for i in range(60):
                if self.stop_threads:
                    break

                # Driver position
                self.safe_send(
                    self.sock_driver,
                    f'42/carpoolRealtime,["newPosition", {{"latitude":-34.4112,"longitude":-70.8536}}]'
                )
                self.safe_recv(self.sock_driver)

                # User position
                self.safe_send(
                    self.sock_user,
                    f'42/carpoolRealtime,["newPosition", {{"latitude":-34.4113,"longitude":-70.8535}}]'
                )
                self.safe_recv(self.sock_user)

                time.sleep(1)

        except Exception as e:
            return f"FAIL: Error sending positions: {e}"

        # -----------------------------
        # FINAL RESULT
        # -----------------------------
        if self.error:
            return f"FAIL: {self.error}"

        return "PASS"


# --------------------------------------------------------
# ROBOT FRAMEWORK ENTRYPOINT
# --------------------------------------------------------
def run_carpool_flow(driver_url, user_url, driver_id, user_id, trip_id):
    flow = CarpoolRealtimeFlow(driver_url, user_url, driver_id, user_id, trip_id)
    return flow.run()
