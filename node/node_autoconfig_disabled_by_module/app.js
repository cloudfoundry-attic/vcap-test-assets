var app = require("cf-runtime").CloudApp;
var port = app.port || 3000;

require("http").createServer(function (req, res) {
  var params = require("url").parse(req.url);
  var matches = params.pathname.match(/\/service\/([^\/]*)\/([^\/]*)/);
  if (matches) {
    var serviceName = matches[1];
    var serviceKey = matches[2];
    switch (serviceName) {
    case "redis" :
      if (serviceKey === "connection") {
        try {
          var client = require("redis").createClient(6379, "127.0.0.1");

          client.on("error", function (err) {
            res.end(err.message.replace(/\s/g, "").substr(0, 37));
            client.quit();
          });
        } catch (e) {}
      }
      break;
    }
  }
  else {
    res.end("hello from node");
  }
}).listen(port);
