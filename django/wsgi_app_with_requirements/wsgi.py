import bottle

def application(environ, start_response):
    data = "Hello from VCAP"
    start_response("200 OK", [
        ("Content-Type", "text/plain"),
        ("Content-Length", str(len(data)))
    ])
    return iter([data])
