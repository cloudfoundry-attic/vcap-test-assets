/* Tests whether the error object is being correctly passed to the query
callback function */
var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=0;

var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
db.on("connection", function () {
    db.query("SELECT 1::int", function (err, rs, tx) {
        // verify that the error is null, and everything is okay.
        console.log(eq(err, null));
        // Test if the returned value is what we think it is.
        console.log(eq(rs[0]['int4'], 1));
    });
    db.close();
});


function not_eq (l, r) {
    if (l !== r) {
        return "ok"
    }
    return "not ok  " + l + " != " + r;
}

function eq (l, r) {
    if (l === r) {
        return "ok"
    }
    return "not ok   " + l + " != " + r;
}