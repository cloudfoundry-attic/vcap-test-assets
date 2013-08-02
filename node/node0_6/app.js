var express = require("express");
var app = express.createServer();

app.get("/node_version", function(req, res){
  res.send(process.version);
});

app.get("/git_module", function(req, res){
  // Tested: git module support
  var semver = require("semver");

  if (semver && semver.valid("1.2.3")) {
    res.send("ok");
  } else {
    res.send("fail");
  }
});

app.get("/native_ext", function(req,res) {
  // Tested: native extensions via node-gyp
  var bcrypt = require("bcrypt");

  var salt = bcrypt.genSaltSync(10);
  var hash = bcrypt.hashSync("B4c0/\/", salt);

  if (bcrypt.compareSync("B4c0/\/", hash)) {
    res.send("ok");
  } else {
    res.send("fail");
  }
});

app.get("/logs", function(req, res){
    console.log("stdout log");
    console.error("stderr log");
    res.send("");
});

app.listen(process.env.VCAP_APP_PORT || 3000);
