var easyimg = require('easyimage');
var port = process.env.VCAP_APP_PORT || 3000;
var imagePath = './imagemagick.jpg';


function handleRequest (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  easyimg.info(imagePath, function (err, stdout, stderr) {
    if (err) throw err;

    easyimg.convert({ src : imagePath, dst : 'converted.png', quality : 10 }, function (err, stdout, stderr) {
      if (err) throw err;
      console.log('Converted JPG to PNG, quality set at 10/100');

      easyimg.info('converted.png', function (err, stdout, stderr) {
        if (err) throw err;
        console.log(stdout);

        easyimg.exec('convert ' + imagePath + ' -flip flipped.jpeg', function (err, stdout, stderr) {
          console.log(stdout);
          easyimg.info('flipped.jpeg', function (err, stdout, stderr) {
            if (err) throw err;
            console.log(stdout);
            res.end('hello from imagemagick');
          });
        });
      });
    });
  });
}

require('http').createServer(handleRequest).listen(port);
