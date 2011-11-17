MongoMapper.connection = Mongo::Connection.new('127.0.0.1', 7896)
MongoMapper.database = 'testdb'
#MongoMapper.database.authenticate(mongodb_service['username'], mongodb_service['password'])
