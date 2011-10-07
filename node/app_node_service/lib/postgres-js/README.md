# PostgreSQL for Javascript

This library is a implementation of the PostgreSQL backend/frontend protocol in javascript.
It uses the node.js tcp and event libraries.  A javascript md5 library is included for servers that require md5 password hashing (this is default).

This library allows for the correct handling of server-side prepared queries.

Nested DB calls will be executed in the order of definition.

All code is available under the terms of the MIT license

(c) 2010, Tim Caswell, Aurynn Shaw.

Bugs can be reported @ https://public.commandprompt.com/projects/postgresjs

## Example use

    var sys = require("sys");
    var pg = require("postgres-pure");

    var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
    db.query("SELECT * FROM sometable", function (data) {
        console.log(data);
    });
    db.close();

## Example use of Parameterized Queries

    var sys = require("sys");
    var pg = require("postgres-pure");

    var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
    db.query("SELECT * FROM yourtable WHERE id = ?", 1, function (data) {
        console.log(data);
    });
    db.close();

## Example use of Prepared Queries

    var sys = require("sys");
    var pg = require("postgres");

    var db = new pg.connect("pgsql://test:12345@localhost:5432/template1");
    db.prepare("SELECT * FROM yourtable WHERE id = ?", function (stmt) {
        stmt.execute(1, function (rs) {
            console.log(rs[0]);
        });
    });
    db.close();