package org.cloudfoundry.canonical.apps;

import java.io.IOException;
import java.net.UnknownHostException;
import org.cloudfoundry.runtime.env.AbstractServiceInfo;
import org.cloudfoundry.runtime.env.CloudEnvironment;
import org.cloudfoundry.runtime.env.MongoServiceInfo;
import org.cloudfoundry.runtime.env.RedisServiceInfo;
import org.cloudfoundry.runtime.service.messaging.RabbitServiceCreator;
import org.springframework.amqp.rabbit.connection.Connection;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.context.annotation.Bean;

import redis.clients.jedis.Jedis;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.MongoException;
import com.rabbitmq.client.Channel;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.cloudfoundry.runtime.env.MysqlServiceInfo;
import org.cloudfoundry.runtime.env.PostgresqlServiceInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.cloudfoundry.runtime.env.AbstractDataSourceServiceInfo;
import org.cloudfoundry.runtime.service.AbstractServiceCreator;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

@Repository
public class ReferenceDataRepository {

  @Autowired(required=false)
  JdbcTemplate mysqlJdbcTemplate;
  @Autowired(required=false)
  JdbcTemplate postgresqlJdbcTemplate;

  public void write_to_mysql(String key, String value) throws UnknownHostException {
    MysqlServiceInfo service = (MysqlServiceInfo) getService(MysqlServiceInfo.class);
    org.apache.commons.dbcp.BasicDataSource mysqlDataSource = new org.apache.commons.dbcp.BasicDataSource();
    AbstractDataSourceServiceInfo serviceInfo = service;

    if (mysqlDataSource != null) {
      setDataSourceProperties(mysqlDataSource, serviceInfo, "com.mysql.jdbc.Driver");
      mysqlJdbcTemplate = new JdbcTemplate(mysqlDataSource);
      //mysqlJdbcTemplate.update("DROP TABLE IF EXISTS DataValue");
      mysqlJdbcTemplate.update("CREATE TABLE IF NOT EXISTS DataValue ( id varchar(20), data_value varchar(20))");
      mysqlJdbcTemplate.update("insert into DataValue (id, data_value) values (?, ?) ", new Object[] {key, value});
    }
    else
      throw new UnknownHostException("No mysql database found");
  }

  public String read_from_mysql(String key) throws UnknownHostException {
    MysqlServiceInfo service = (MysqlServiceInfo) getService(MysqlServiceInfo.class);
    org.apache.commons.dbcp.BasicDataSource mysqlDataSource = new org.apache.commons.dbcp.BasicDataSource();
    if (mysqlDataSource != null) {
      setDataSourceProperties(mysqlDataSource, service, "com.mysql.jdbc.Driver");
      AbstractDataSourceServiceInfo serviceInfo = service;
      mysqlJdbcTemplate = new JdbcTemplate(mysqlDataSource);
      String sql = "select data_value from DataValue where id='" + key + "'";
      return (String) mysqlJdbcTemplate.queryForObject(sql, String.class);
    }
    else
      throw new UnknownHostException("No mysql database found");
  }

  public void write_to_postgresql(String key, String value) throws UnknownHostException {
    PostgresqlServiceInfo service = (PostgresqlServiceInfo) getService(PostgresqlServiceInfo.class);
    org.apache.commons.dbcp.BasicDataSource postgresqlDataSource = new org.apache.commons.dbcp.BasicDataSource();
    AbstractDataSourceServiceInfo serviceInfo = service;

    if (postgresqlDataSource != null) {
      setDataSourceProperties(postgresqlDataSource, serviceInfo, "org.postgresql.Driver");
      postgresqlJdbcTemplate = new JdbcTemplate(postgresqlDataSource);
      try {
        postgresqlJdbcTemplate.update("create table DataValue ( id varchar(20), data_value varchar(20))");
      }
      catch (org.springframework.jdbc.BadSqlGrammarException e) {
        // cannot use CREATE TABLE IF NOT EXISTS with progresql; ignoring exception when table exists
        e.printStackTrace();
      }
      postgresqlJdbcTemplate.update("insert into DataValue (id, data_value) values (?, ?) ", new Object[] {key, value});
    }
    else
      throw new UnknownHostException("No postgresql database found");

  }

  public String read_from_postgresql(String key) throws UnknownHostException {
    PostgresqlServiceInfo service = (PostgresqlServiceInfo) getService(PostgresqlServiceInfo.class);
    org.apache.commons.dbcp.BasicDataSource postgresqlDataSource = new org.apache.commons.dbcp.BasicDataSource();
    AbstractDataSourceServiceInfo serviceInfo = service;

    if (postgresqlDataSource != null) {
      setDataSourceProperties(postgresqlDataSource, serviceInfo, "org.postgresql.Driver");
      postgresqlJdbcTemplate = new JdbcTemplate(postgresqlDataSource);
      String sql = "select data_value from DataValue where id='" + key + "'";
      return (String) postgresqlJdbcTemplate.queryForObject(sql, String.class);
    }
    else
      throw new UnknownHostException("No postgresql database found");

  }

  public void write_to_rabbitmq(String key, String value) throws IOException {
    ConnectionFactory rabbitConnectionFactory = new RabbitServiceCreator(environment()).createSingletonService().service;
    Connection conn = rabbitConnectionFactory.createConnection();
    Channel channel = conn.createChannel(true);
    channel.exchangeDeclare(key, "direct");
    channel.queueDeclare(key, true, false, false, null);
    RabbitTemplate amq = new RabbitTemplate(
      (ConnectionFactory) rabbitConnectionFactory);
    amq.convertAndSend(key, value);
    channel.close();
    conn.close();
  }

  public String read_from_rabbitmq(String key) throws IOException {
    ConnectionFactory rabbitConnectionFactory = new RabbitServiceCreator(environment()).createSingletonService().service;
    Connection conn = rabbitConnectionFactory.createConnection();
    Channel channel = conn.createChannel(true);
    channel.exchangeDeclare(key, "direct");
    channel.queueDeclare(key, true, false, false, null);
    RabbitTemplate amq = new RabbitTemplate(
      (ConnectionFactory) rabbitConnectionFactory);
    String value = (String) amq.receiveAndConvert(key);
    channel.close();
    conn.close();
    return value;
  }

  public void write_to_mongo(String key, String value) {
    MongoServiceInfo service = (MongoServiceInfo) getService(MongoServiceInfo.class);
    Mongo m = null;
    DBCollection coll = null;
    DB db = null;
    try {
      m = new Mongo(service.getHost(), service.getPort());
    } catch (UnknownHostException e) {
      e.printStackTrace();
    } catch (MongoException e) {
      e.printStackTrace();
    }
    db = m.getDB(service.getDatabase());
    if (db.authenticate(service.getUserName(), service.getPassword().toCharArray())) {
      coll = db.getCollection(service.getServiceName());
    }
    BasicDBObject doc = new BasicDBObject();
    doc.put("key", key);
    doc.put("data_value", value);
    coll.insert(doc);
    m.close();
  }

  public String read_from_mongo(String key) {
    MongoServiceInfo service = (MongoServiceInfo) getService(MongoServiceInfo.class);
    Mongo m = null;
    DBCollection coll = null;
    DB db = null;
    try {
      m = new Mongo(service.getHost(), service.getPort());
    } catch (UnknownHostException e) {
      e.printStackTrace();
    } catch (MongoException e) {
      e.printStackTrace();
    }
    db = m.getDB(service.getDatabase());
    if (db.authenticate(service.getUserName(), service.getPassword().toCharArray())) {
      coll = db.getCollection(service.getServiceName());
    }
    BasicDBObject query = new BasicDBObject();
    query.put("key", key);
    DBCursor cur = coll.find(query);
    String value = "";
    while (cur.hasNext()) {
      value = (String) cur.next().get("data_value");
    }
    cur.close();
    m.close();
    return value;
  }

  public void write_to_redis(String key, String value) {
    RedisServiceInfo service = (RedisServiceInfo) getService(RedisServiceInfo.class);
    Jedis jedis = new Jedis(service.getHost(), service.getPort());
    jedis.auth(service.getPassword());
    jedis.set(key, value);
  }

  public String read_from_redis(String key) {
    RedisServiceInfo service = (RedisServiceInfo) getService(RedisServiceInfo.class);
    Jedis jedis = new Jedis(service.getHost(), service.getPort());
    jedis.auth(service.getPassword());
    return jedis.get(key);
  }

  @Bean
  CloudEnvironment environment() {
    return new CloudEnvironment();
  }

  private <T extends AbstractServiceInfo> AbstractServiceInfo getService(
    Class<T> service) {
      CloudEnvironment env = environment();
      return env.getServiceInfos(service).get(0);
  }

  private void setDataSourceProperties(BasicDataSource basicDataSource, AbstractDataSourceServiceInfo serviceInfo, String driverClass) {
    BeanWrapper target = new BeanWrapperImpl(basicDataSource);
    target.setPropertyValue("driverClassName", driverClass);
    target.setPropertyValue("url", serviceInfo.getUrl());
    target.setPropertyValue("username", serviceInfo.getUserName());
    target.setPropertyValue("password", serviceInfo.getPassword());
  }

}