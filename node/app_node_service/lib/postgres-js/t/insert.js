var sys = require("sys");
var pg = require("../lib/postgres-pure");
pg.DEBUG=3;

var db = new pg.connect("pgsql://test:12345@localhost:5432/postgresjs");
var tx = db.transaction();
tx.begin();
tx.query("CREATE TABLE testcase (id int)", function (err, rs) {
   tx.query("INSERT INTO testcase VALUES (?)", 1, function(err, rs) {
       console.log("Got to tx.")
   });
   tx.query("DROP TABLE testcase;", function (err, rs) {
       // nothing
   });
   tx.rollback();
});
db.close();



function eq (l, r) {
    if (l === r) {
        return "ok"
    }
    return "not ok\n " + l + " != " + r;
}