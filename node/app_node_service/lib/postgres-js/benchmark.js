var sys = require("sys");

var iterations = process.argv[2];

var pg = require("./lib/postgres-pure");
var db = new pg.connect("pgsql://test:12345@localhost:5432/insert_test");
db.transaction(function (tx) {
    tx.query("CREATE TABLE insert_test (id serial not null, val text)", function (err, rs) {});
    tx.begin();
    tx.prepare("INSERT INTO insert_test (val) VALUES (?::text) RETURNING id, val",  function (sth) {
        var i = 0;
        for (i = 0; i <= iterations; i++) {
            sth.execute(""+i, function (err, rs) {
                // This is the point where we have executed.
                console.log(rs[0]);
            })
        }
    });
    tx.query("SELECT COUNT(*) FROM insert_test", function (err, rs) {
        console.log(sys.inspect(rs));
    });
    tx.rollback();
    tx.query("DROP TABLE insert_test", function () {});
});
console.log("Done");
db.close();