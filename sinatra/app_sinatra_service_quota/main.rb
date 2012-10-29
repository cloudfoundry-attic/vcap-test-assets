require 'sinatra'
require 'json'
require 'uri'
require 'pg'
require 'redis'
require 'bunny'
require 'mongo'
require 'mysql2'
require "yajl"
require 'eventmachine'
require 'time'
require 'aws/s3'

get '/env' do
  ENV['VCAP_SERVICES']
end

get '/' do
  'hello from sinatra'
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

not_found do
  'This is nowhere to be found.'
end

post '/service/mysql/querytime/:time' do
  client = load_mysql
  results = client.query("select sleep(#{params[:time]})")
  client.close
  res = 0
  results.each{|rs|
    res = rs.values[0].to_i
  }
  if res == 0
    return "OK"
  elsif res == 1
    return "query interrupted"
  end
end

post '/service/postgresql/querytime/:time' do
  client = load_postgresql
  begin
    client.query("select pg_sleep(#{params[:time]})")
    result = "OK"
  rescue Exception => e
    puts e.message
    result = "query interrupted"
  ensure
    client.close if client
  end
  result
end

post '/service/mysql/txtime/:time' do
  EventMachine.run{
    client = load_mysql
    client.query("drop table if exists a")
    client.query("create table a (id int) engine=innodb")
    client.query("begin")
    client.query("select * from a for update")
    EventMachine.add_timer(params[:time].to_i){
      begin
        client.query("select * from a for update")
        result = "OK"
      rescue Exception => e
        puts e.message
        result = "transaction interrupted"
      ensure
        client.close if client
      end
      return result
    }
  }
end

post '/service/postgresql/txtime/:time' do
  client = load_postgresql
  client.query("drop table if exists a")
  client.query("create table a (id int)")
  client.query("insert into a values (10)")
  client.query("begin")
  begin
    start_time = Time.now.to_i
    cur_time = Time.now.to_i
    while ((cur_time - start_time) < params[:time].to_i) do
      client.query("select * from a")
      cur_time = Time.now.to_i
    end
    result = "OK"
  rescue Exception => e
    puts e.message
    result = "transaction interrupted"
  ensure
    client.close if client
  end
  result
end

get '/service/mongodb/db/storagesize' do
  client = load_mongodb
  size = client.stats()
  return size["storageSize"].to_s
end

post '/service/mongodb/collection' do
  client = load_mongodb
  begin
    col = client[params[:colname]]
    content = prepare_data(1)
    i = 0
    while i < params[:size].to_i do
      i += 1
      col.insert({"content"=>content,"name"=>"mongo#{i}"})
      last_error = client.get_last_error
      puts col.count()
    end
    return last_error['err']
    #if reach quota_files limit, should be "db disk space quota exceeded db"
  rescue Exception => e
    puts e.message
  end
end

get '/service/mongodb/collection' do
  client = load_mongodb
  begin
    col = client[params[:colname]]
    result = col.find({"name"=>"mongo#{params[:index]}"})
    return "OK" unless result.count() == 0
  rescue Exception => e
    puts e.message
  end
  "index not found"
end

delete '/service/mongodb/collection' do
  client = load_mongodb
  begin
    col = client[params[:colname]]
    params[:size].to_i.times do |i|
      col.remove({"name"=>"mongo#{i}"})
    end
    client.close
  rescue Exception => e
    puts e.message
  end
  "DELETE OK"
end

post '/service/mysql/tables/:table' do
  client = load_mysql
  begin
    client.query("create table #{params[:table]} (value mediumtext) ENGINE=MYISAM")
    params[:table]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

get '/service/mysql/tables/:table' do
  client = load_mysql
  begin
    a = client.query("select value from #{params[:table]} limit 1")
    if a.first['value'] != nil && a.first['value'] != ''
      "ok"
    else
      "nil"
    end
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

post '/service/postgresql/tables/:table' do
  client = load_postgresql
  begin
    client.query("create table #{params[:table]} (value text);")
    params[:table]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

get '/service/postgresql/tables/:table' do
  client = load_postgresql
  begin
    a = client.query("select value from #{params[:table]} limit 1")
    if a.first['value'] != nil && a.first['value'] != ''
      "ok"
    else
      "nil"
    end
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

delete '/service/postgresql/:object/:name' do
  client = load_postgresql
  object = params[:object]
  name = params[:name]
  name += "()" if object=="function" # PG 'drop function' docs: "The argument types to the function must be specified"
  client.query("drop #{object} #{name};")
  client.close
  name
end

post '/service/postgresql/functions/:function' do
  client = load_postgresql
  begin
    client.query("create function #{params[:function]}() returns integer as 'select 1234;' language sql;")
    params[:function]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

post '/service/postgresql/sequences/:sequence' do
  client = load_postgresql
  begin
    client.query("create sequence #{params[:sequence]};")
    params[:sequence]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

# delete from table
delete '/service/postgresql/tables/:name/data' do
  client = load_postgresql
  table = params[:name]
  # truncate is preferred and much faster, furthermore, it reclaims disk space immediately
  # see also http://wiki.postgresql.org/wiki/VACUUM_FULL
  #client.query("delete from #{table};")
  #client.query("vacuum full #{table};")
  client.query("truncate table #{table};")
  client.close
  table
end

delete '/service/mysql/tables/:name/data' do
  client = load_mysql
  table = params[:name]
  client.query("truncate table #{table};")
  client.close
  table
end

# get db size of postgresql
get '/service/postgresql/database/size' do
  client = load_postgresql
  db_size = client.query("select pg_database_size('#{db_name}')").first['pg_database_size']
  client.close
  db_size
end

# populate data into postgresql table
post '/service/postgresql/tables/:name/:megabytes' do
  client = load_postgresql
  begin
    content = prepare_data(1)
    client = load_postgresql
    sleep 1
    size = params[:megabytes].to_i
    i = 0
    while i < size do
      client.query("insert into #{params[:name]} (value) values('#{content}');")
      sleep 1 if i % 10 == 0
      i += 1
    end
    'ok'
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

# get db size of mysql
get '/service/mysql/database/size' do
  client = load_mysql
  client.query("use information_schema")
  db_size = client.query("select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data from TABLES")
  db_size.each {|row|
    puts row[0]
  }
  client.close
  db_size.first.to_s
end

# populate data into mysql table
post '/service/mysql/tables/:name/:megabytes' do
  client = load_mysql
  begin
    size = params[:megabytes].to_i
    content = prepare_data(1)
    i = 0
    while i < size do
      client.query("insert into #{params[:name]} (value) values('#{content}');")
      i += 1
    end
    'ok'
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

# max_clients of mysql
post '/service/mysql/clients/:clients' do
  e1 = nil
  threads = []
  clients_number = 0
  Thread.abort_on_exception = true
  params[:clients].to_i.times do
    sleep 0.01
    threads << Thread.new do
      begin
        client = load_mysql
        client.query("show tables")
        sleep 8
        client.close
        clients_number += 1
      rescue => e
        e1 = e
      end
    end
  end
  threads.each { |t| t.join }
  if e1
    "#{clients_number}-#{e1}"
  else
    "ok"
  end
end

# max_clients of postgresql
post '/service/postgresql/clients/:clients' do
  e1 = nil
  threads = []
  clients_number = 0
  Thread.abort_on_exception = true
  params[:clients].to_i.times do
    sleep 0.01
    threads << Thread.new do
      begin
        client = load_postgresql
        client.query("select count(*) from pg_stat_activity")
        sleep 8
        client.close
        clients_number += 1
      rescue => e
        e1 = e
      end
    end
  end
  threads.each { |t| t.join }
  if e1
    "#{clients_number}-#{e1}"
  else
    "ok"
  end
end

# max clients of rabbitmq
post '/service/rabbitmq/clients/:clients' do
  e1 = nil
  threads = []
  clients_number = 0
  Thread.abort_on_exception = false
  params[:clients].to_i.times do
    sleep 0.02
    threads << Thread.new do
      begin
        client = nil
        Timeout::timeout(1) {
          client = load_rabbitmq
          client.start
        }
        q = client.queue("test1")
        e = client.exchange("")
        e.publish("Hello, everybody!", :key => 'test1')
        sleep 8
        clients_number += 1
      rescue Timeout::Error
        e1 = 'connection timeout'
      end
    end
  end
  threads.each { |t| t.join }
  if e1
    "#{clients_number}-#{e1}"
  else
    "ok"
  end
end

# max_clients of mongodb
post '/service/mongodb/clients/:clients' do
  conns = []

  begin
    params[:clients].to_i.times do
      client = load_mongodb
      coll = client['test']
      coll.insert({'a' => 1})
      conns << client
    end
    'ok'
  rescue => e
    "#{conns.size}-#{e}"
  end
end

# max_clients of redis
post '/service/redis/clients/:clients' do
  e1 = nil
  threads = []
  Thread.abort_on_exception = true
  clients_number = 0
  params[:clients].to_i.times do
    sleep 0.01
    threads << Thread.new do
      begin
        client = load_redis
        client.set('abc', 'test')
        sleep 10
        clients_number += 1
      rescue => e
        if e != nil && e != ""
          e1 = e
        end
      end
    end
  end
  threads.each { |t| t.join }
  if e1
    "#{clients_number}-#{e1}"
  else
    "ok"
  end
end

# get memory usage of redis (MB)
get '/service/redis/memory' do
  used_memory = ''
  client = load_redis
  client.info.each {|i|
    if i[0] == 'used_memory'
      used_memory = i[1]
      break
    end
  }
  "#{used_memory.to_f / 1000000.0}"
end

# set data in redis
post '/service/redis/set/:megabytes' do
  client = load_redis
  begin
    content = prepare_data(1)
    for i in 0..params[:megabytes].to_i-1
      client.set(i.to_s, content)
    end
    "ok"
  rescue => e
    "#{e}"
  end
end

# clear data in redis
post '/service/redis/clear/:megabytes' do
  client = load_redis
  begin
    for i in 0..params[:megabytes].to_i-1
      client.set(i.to_s, '-')
    end
    "ok"
  rescue => e
    "#{e}"
  end
end

# get data in redis
get '/service/redis/data' do
  begin
    client = load_redis
    v = client.get("0")
    if v != nil && v != ''
      return "ok"
    end
  rescue => e
    "#{e}"
  end
end

# post data in rabbitmq
post '/service/rabbitmq/publish/:megabytes' do
  e1 = nil
  number = params[:megabytes].to_i
  begin
    client = load_rabbitmq
    client.start
    q = client.queue("test1")
    e = client.exchange("")
    for i in 0..number-1
      data = prepare_data(1)
      e.publish(data, :key => 'test1')
    end
    client.stop
  rescue => e
    e1 = e
  end

  if e1
    "#{e1}"
  else
    "ok"
  end
end

post '/service/vblob/:bucket' do
  e1 = nil
  begin
    load_vblob
    AWS::S3::Bucket.create(params[:bucket])
  rescue => e
    e1 = e
  end

  if e1
    "#{e1}"
  else
    "ok"
  end
end

delete '/service/vblob/:bucket' do
  e1 = nil
  begin
    load_vblob
    AWS::S3::Bucket.delete(params[:bucket])
  rescue => e
    e1 = e
  end

  if e1
    "#{e1}"
  else
    "ok"
  end
end

post '/service/vblob/:bucket/:megabytes' do
  e1 = nil
  begin
    load_vblob
    data = prepare_data(1)
    number = params[:megabytes].to_i
    return "ok" if number == 0
    AWS::S3::S3Object.store("testobject0", data, params[:bucket])
    for i in 1..number-1
      AWS::S3::S3Object.copy("testobject0", "testobject#{i}", params[:bucket])
    end
  rescue Exception => e
    e1 = e
    puts e.backtrace
  end

  if e1
    "#{e1}"
  else
    "ok"
  end
end

post '/service/vblob/obj_limit/:bucket/:megabytes' do
  e1 = nil
  begin
    load_vblob
    number = params[:megabytes].to_i
    AWS::S3::S3Object.store("testobject0", '', params[:bucket])
    for i in 1..number-1
      AWS::S3::S3Object.copy("testobject0", "testobject#{i}", params[:bucket])
    end
  rescue => e
    e1 = e
  end

  if e1
    "#{e1}"
  else
    "ok"
  end
end

delete '/service/vblob/:bucket/:megabytes' do
  e1 = nil
  begin
    load_vblob
    number = params[:megabytes].to_i
    for i in 0..number-1
      AWS::S3::S3Object.delete("testobject#{i}", params[:bucket])
    end
  rescue => e
    e1 = e
  end

  if e1
    "#{e1}"
  else
    "ok"
  end
end

get '/service/vblob/list' do
  load_vblob
  AWS::S3::Service.buckets(:reload).inspect rescue "list failed: #{$!} at #{$@}"
end

get '/service/vblob/:bucket' do
  load_vblob
  AWS::S3::Bucket.find(params[:bucket]).inspect rescue "fetch bucket: #{params[:bucket]} failed: #{$!} at #{$@}"
end

get '/service/vblob/:bucket/size' do
  load_vblob
  AWS::S3::Bucket.find(params[:bucket]).size() rescue "fetch bucket: #{params[:bucket]} failed: #{$!} at #{$@}"
end

# helper methods
helpers do
  def parse_env()
    svcs = ENV['VCAP_SERVICES']
    svcs = Yajl::Parser.parse(svcs)
    svcs.each do |k, v|
      v.each do |svc|
        if svc["name"] =~ /db_quota_apppostgresql/
          opts = svc["credentials"]
          return opts
        end
      end
    end
  end

  def db_name
    opts = parse_env
    opts["name"]
  end

  def prepare_data(size)
    b = size * 1024 * 1024
    c = [('a'..'z'),('A'..'Z')].map{|i| Array(i)}.flatten
    (0..b).map{ c[rand(c.size)] }.join
  end
end

def load_mysql
  mysql_service = load_service('mysql')
  client = Mysql2::Client.new(:host => mysql_service['hostname'], :port => mysql_service['port'],
    :dbname => mysql_service['name'], :username => mysql_service['user'], :password => mysql_service['password'])
  client
end

def load_postgresql
  postgresql_service = load_service('postgresql')
  client = PGconn.open(postgresql_service['host'], postgresql_service['port'], :dbname => postgresql_service['name'], :user => postgresql_service['username'], :password => postgresql_service['password'])
  client
end

def load_redis
  redis_service = load_service('redis')
  client = Redis.new(:host => redis_service['host'], :port => redis_service['port'], :user => redis_service['username'], :password => redis_service['password'])
  client
end

def load_rabbitmq
  rabbitmq_service = load_service('rabbitmq')
  p rabbitmq_service
  client = Bunny.new(rabbitmq_service['url'])
  client
end

def load_mongodb
  mongodb_service = load_service('mongodb')
  conn = Mongo::Connection.new(mongodb_service['hostname'], mongodb_service['port'])
  client = conn[mongodb_service['db']]
  client
end

def load_vblob
  vblob_service = load_service('blob')
  AWS::S3::Base.establish_connection!(
    :access_key_id      => vblob_service['username'],
    :secret_access_key  => vblob_service['password'],
    :port               => vblob_service['port'],
    :server             => vblob_service['host']
  ) unless vblob_service == nil
end

def load_service(service_name)
  services = JSON.parse(ENV['VCAP_SERVICES'])
  service = nil
  services.each do |k, v|
    v.each do |s|
      if k.split('-')[0].downcase == service_name.downcase
        service = s["credentials"]
      end
    end
  end
  service
end
