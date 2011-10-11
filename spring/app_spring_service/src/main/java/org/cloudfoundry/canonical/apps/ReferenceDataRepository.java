package org.cloudfoundry.canonical.apps;

import java.io.IOException;
import java.net.UnknownHostException;

import org.cloudfoundry.runtime.env.AbstractServiceInfo;
import org.cloudfoundry.runtime.env.CloudEnvironment;
import org.cloudfoundry.runtime.env.MongoServiceInfo;
import org.cloudfoundry.runtime.env.RedisServiceInfo;
import org.cloudfoundry.runtime.service.messaging.RabbitServiceCreator;
import org.hibernate.SessionFactory;
import org.springframework.amqp.rabbit.connection.Connection;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.orm.hibernate3.HibernateTemplate;

import redis.clients.jedis.Jedis;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.MongoException;
import com.rabbitmq.client.Channel;

public class ReferenceDataRepository {

    private HibernateTemplate hibernateTemplate;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.hibernateTemplate = new HibernateTemplate(sessionFactory);
    }

    public void save(DataValue dataValue) {
        this.hibernateTemplate.saveOrUpdate(dataValue);
    }

    public DataValue find(String id) {
        return (DataValue) hibernateTemplate.find(
                "from DataValue where id='" + id + "'").get(0);
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
        if (db.authenticate(service.getUserName(), service.getPassword()
                .toCharArray())) {
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
        if (db.authenticate(service.getUserName(), service.getPassword()
                .toCharArray())) {
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
}