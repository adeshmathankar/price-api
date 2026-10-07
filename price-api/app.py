import os
import json
import logging
import time

from http.server import HTTPServer, BaseHTTPRequestHandler
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)

API_KEY = os.environ.get("API_KEY")

REQUEST_COUNT = Counter(
    "price_api_requests_total",
    "Total HTTP requests",
    ["method", "path", "status"]
)

REQUEST_LATENCY = Histogram(
    "price_api_request_duration_seconds",
    "HTTP request latency",
    ["method", "path"]
)


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        start = time.time()

        try:
            if self.path == "/healthz":
                self._send(200, {"status": "ok"})

            elif self.path == "/metrics":
                data = generate_latest()
                self.send_response(200)
                self.send_header("Content-Type", CONTENT_TYPE_LATEST)
                self.end_headers()
                self.wfile.write(data)

            elif self.path == "/price":
                if not API_KEY:
                    self._send(500, {"error": "API_KEY not configured"})
                else:
                    self._send(
                        200,
                        {
                            "symbol": "BTCUSDT",
                            "price": 65000.0
                        }
                    )

            else:
                self._send(404, {"error": "not found"})

        finally:
            REQUEST_LATENCY.labels(
                method="GET",
                path=self.path
            ).observe(time.time() - start)

    def _send(self, code, body):
        data = json.dumps(body).encode()

        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(data)

        REQUEST_COUNT.labels(
            method="GET",
            path=self.path,
            status=str(code)
        ).inc()


if __name__ == "__main__":
    logging.info("Starting price-api")

    server = HTTPServer(
        ("0.0.0.0", 5000),
        Handler
    )

    server.serve_forever()