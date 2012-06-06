# cf-runtime

cf-runtime is a Node.js module that provides API to Cloud Foundry platform. It provides easy access to Cloud Foundry application properties and services.

## Installation

```bash
npm install cf-runtime
```

If cloned from github install dependencies:

```bash
npm install -d
```

### Tests

Run basic tests:

```bash
npm test
```

To run integration tests copy services.conf.template to services.conf with specified services connection properties and run:

```bash
TESTS=integration npm test
```

## Usage

```js
var cf = require('cf-runtime')
var app = cf.CloudApp

// Check if application is running on Cloud Foundry

app.runningInCloud

// Get application properties

app.host
app.port

// Get the list of application service names

app.serviceNames

// Obtain connection properties for single service of type Redis

app.serviceProps.redis

// Obtain connection properties for service named 'redis-service-name'

app.serviceProps['redis-service-name']

// Obtain the list of service names of specific type

app.serviceNamesOfType.redis

// Check if service of the given type is available

cf.RedisClient !== undefined

// Connect to a single service of type Redis

var redisClient = cf.RedisClient.create()

// Connect to mysql service named 'redis-service-name'

var redisClient = cf.RedisClient.createFromSvc('redis-service-name')

```

### Service properties

* name
* label (service type)
* version
* host
* port
* username
* password

#### Additional properties

Rabbitmq:

* url
* vhost

MongoDB:

* db
* url

Postgresql, Mysql, Redis:

* database

### Service clients

This is the list of Node.js modules that are used to provide connection to Cloud Foundry services:

#### AMQP client

Node module: [amqp](https://github.com/postwait/node-amqp)

Functions:

* cf.AMQPClient.create([implOptions]) - creates and returns an amqp client instance connected to a single rabbitmq service
* cf.AMQPClient.createFromSvc(name, [implOptions]) - creates and returns an amqp client instance connected to a rabbitmq service with the specified name

Parameters:

implOptions - optional {object} non-connection related implementation options

Returns: AMQP client instance

#### Mongodb client

Node module: [mongodb](https://github.com/christkv/node-mongodb-native)

Functions:

* cf.MongoClient.create([options], callback) - creates a mongodb client instance connected to a single mongodb service and executes provided callback
* cf.MongoClient.createFromSvc(name, [options], callback) - creates a mongodb client instance connected to a mongodb service with the specified name and executes provided callback

Parameters:

options - optional {object} non-connection related options
callback - {function} connection callback

Returns: null

#### Mysql client

Node module: [mysql](https://github.com/felixge/node-mysql)

Functions:

* cf.MysqlClient.create([options]) - creates and returns a mysql client instance connected to a single mysql service
* cf.MysqlClient.createFromSvc(name, [options]) - creates and returns a mysql client instance connected to a mysql service with the specified name

Parameters:

options - optional {object} non-connection related options

Returns: Mysql client instance

#### Postgresql client

Node module: [pg](https://github.com/brianc/node-postgres)

Functions:

* cf.PGClient.create(callback) - creates a postgresql client instance connected to a single postgresql service and executes provided callback
* cf.PGClient.createFromSvc(name, callback) - creates a postgresql client instance connected to a postgresql service with the specified name and executes provided callback

Parameters:

callback - {function} connection callback

Returns: {boolean}

#### Redis client

Node module: [redis](https://github.com/mranney/node_redis)

Functions:

* cf.RedisClient.create([options]) - creates and returns a redis client instance connected to a single redis service
* cf.RedisClient.createFromSvc(name, [options]) - creates and returns a redis client instance connected to a redis service with the specified name

Parameters:

options - optional {object} non-connection related options

Returns: Redis client instance
