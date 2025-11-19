from websocket import create_connection


class WebSocketClient:
    """Keywords para manejar WebSocket en Robot Framework."""

    def connect(self, url, timeout=None, **options):
        # Mantén vivo el socket con ping automático
        return create_connection(
            url,
            timeout=timeout,
            ping_interval=10,
            ping_timeout=5,
            **options,
        )

    def send(self, websocket, message):
        return websocket.send(message)

    def recv(self, websocket):
        return websocket.recv()

    def recv_data(self, websocket, control_frame=False):
        return websocket.recv_data(control_frame)

    def ping(self, websocket, payload=""):
        websocket.ping(payload)

    def pong(self, websocket, payload=""):
        websocket.pong(payload)

    def close(self, websocket):
        websocket.close()
