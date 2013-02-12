// This app uses bcrypt 0.7.2 (see npm-shrinkwrap.json)
// which depends on node-gyp

var bcrypt = require("bcrypt");
var port = process.env.VCAP_APP_PORT || 3000;

require("http").createServer(function(req, res) {
  var salt = bcrypt.genSaltSync(10);
  var hash = bcrypt.hashSync("B4c0/\/", salt);
  if (bcrypt.compareSync("B4c0/\/", hash))
    res.end("hello from node-gyp");
  else
    res.end("");
}).listen(port);