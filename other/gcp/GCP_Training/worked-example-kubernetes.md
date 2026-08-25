---
title: Worked Example - Kubernetes
---

## 1. 

```python
from http.server import BaseHTTPRequestHandler, HTTPServer

hostName = "localhost"
serverPort = 8080

class MyServer(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(bytes("<html><head><title>MJN</title></head>", "utf-8"))
    self.wfile.write(bytes("<body>", "utf-8"))
    self.wfile.write(bytes("<p>Hello from MJN!</p>", "utf-8"))
    self.wfile.write(bytes("<p>Request: %s</p>" % self.path, "utf-8"))
    self.wfile.write(bytes("</body></html>", "utf-8"))

if __name__ == "__main__":
  webServer = HTTPServer((hostName, serverPort), MyServer)
  print("Server started http://%s:%s" % (hostName, serverPort))

  try:
    webServer.serve_forever()
  except KeyboardInterrupt:
    pass

  webServer.server_close()
  print("Server stopped.")
```

Create a Dockerfile - `dockerfile`:
```
FROM python:3
ADD server.py server.py
EXPOSE 8080
ENTRYPOINT ["python3", "server.py"]
```

```
> podman build -f dockerfile  . -t web-server
```

> podman run web-server:latest --expose=8080 &

didn't work....


