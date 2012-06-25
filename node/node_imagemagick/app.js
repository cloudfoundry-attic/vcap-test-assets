var easyimg = require('easyimage');
var port = process.env.VCAP_APP_PORT || 3000;
var imagePath = './imagemagick.jpg';


function handleRequest (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  easyimg.info(imagePath, function (err, stdout, stderr) {
    if (err) throw err;
    var origWidth = stdout.width;
    var origHeight = stdout.height;

    easyimg.convert({ src : imagePath, dst : 'converted.png', quality : 10 }, function (err, stdout, stderr) {
      if (err) throw err;
      console.log('Converted JPG to PNG, quality set at 10/100');

      easyimg.info('converted.png', function (err, stdout, stderr) {
        if (err) throw err;
        console.log(stdout);

        easyimg.exec('convert ' + imagePath + ' -rotate 90 rotated.jpg', function (err, stdout, stderr) {
          console.log(stdout);
          easyimg.info('rotated.jpg', function (err, stdout, stderr) {
            if (err) throw err;
            console.log(stdout);
            if (stdout.width == origHeight && stdout.height == origWidth) {
              res.end('hello from imagemagick');
            }
            else {
              res.end('rotation failed');
            }
          });
        });
      });
    });
  });
}

require('http').createServer(handleRequest).listen(port);