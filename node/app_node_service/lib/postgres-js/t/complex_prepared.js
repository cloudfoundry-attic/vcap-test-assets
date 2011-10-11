var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");

db.prepare("SELECT ?::int AS foobar", function (sth, tx) {
    sth.execute(1, function (err, rs) {
        console.log(eq(rs[0]['foobar'], 1));
        //console.log(sys.inspect(rs));
    });
    sth.execute(2, function (err, rs) {
        console.log(eq(rs[0]['foobar'], 2));
        // console.log(sys.inspect(rs));

    });
    tx.prepare("SELECT ?::int AS cheese", function (sth) {
        sth.execute(3, function (err, rs) {
            console.log(eq(rs[0]['cheese'], 3));
            // console.log(sys.inspect(rs));
        });
    });
    // db.close();
});
db.close();


function eq (l, r) {
    if (l === r) {
        return "ok"
    }
    return "not ok\n " + l + " != " + r;
}