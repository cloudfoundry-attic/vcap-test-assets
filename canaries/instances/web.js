var express = require('express');
var http = require("http");

var INDEX = JSON.parse(process.env.VCAP_APPLICATION).instance_index.toString();
var AVIARY = process.env.AVIARY;

var app = express();
app.use(express.logger());

app.get('/', function(request, response) {
  response.send('Hello Canary Tweet Tweet Chirp Chirp!');
});

app.get('/instance-index', function(request, response) {
  response.send(INDEX);
});

if (AVIARY) {
  setInterval(function() {
    console.log("Sending heartbeat to aviary " + AVIARY + " on index " + INDEX);

    http.request({
      hostname: AVIARY,
      port: 80,
      path: "/instances_heartbeats/" + INDEX,
      method: "PUT"
    }).end()
  }, 10 * 1000)
}

var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on " + port);
});
