var semver = require("semver");

require("http").createServer(function(req, res) {
  if (semver.satisfies("1.2.3", "1.x || >=2.5.0 || 5.0.0 - 7.2.3")) {
    res.end("hello from git");
  }
  else {
    res.end("something is wrong");
  }
}).listen(3000);