var express = require('express');
var app = express();
app.use(express.logger());

app.get('/', function(request, response) {
  response.send('Hello Canary Tweet Tweet Chirp Chirp!');
});

app.get('/instance-index', function(request, response) {
  response.send(JSON.parse(process.env.VCAP_APPLICATION).instance_index.toString());
});

var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on " + port);
});
