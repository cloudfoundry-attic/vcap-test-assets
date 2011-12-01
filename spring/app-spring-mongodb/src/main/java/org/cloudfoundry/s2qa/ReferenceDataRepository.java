package org.cloudfoundry.s2qa;

import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.CollectionCallback;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mongodb.DBCollection;
import com.mongodb.MongoException;
import com.mongodb.Mongo;
import com.mongodb.DB;
import com.mongodb.BasicDBObject;

@Repository
    @Transactional
public class ReferenceDataRepository {

    @Autowired(required = false)
        MongoDbFactory mongoDbFactory;

    @Autowired(required = false)
        MongoTemplate mongoTemplate;

    @Autowired(required = false)
        @Qualifier(value = "serviceProperties")
        Properties serviceProperties;

    public List<String> getDbEnv() {
        List<String> services = new ArrayList<String>();
        if (mongoDbFactory != null) {
            services.add("MongoDB: " + mongoDbFactory.getDb().getMongo().getAddress());
        }
        return services;
    }

    public long setupInitTestDB() {
        if (mongoTemplate.collectionExists(Item.class)) {
            mongoTemplate.dropCollection(Item.class);
        }
        addMoreItems();
        return getItemCount();
    }

    public long deleteAll() {
        if (mongoTemplate.collectionExists(Item.class)) {
            mongoTemplate.dropCollection(Item.class);
        }
        return getItemCount();
    }

    public long addMoreItems() {
        int resultItems;
        for (int i = 1; i < 20; i++) {
            Item itm = new Item("ItemNo-" + Integer.toString(i), genEater(1024));
            mongoTemplate.save(itm);
        }
        return getItemCount();
    }

    public List<Item> displayItems() {
        List<Item> items = mongoTemplate.findAll(Item.class);
        return items;
    }

    public long getItemCount() {
        return mongoTemplate.execute(Item.class,
        new CollectionCallback<Long>() {
            @Override
                public Long doInCollection(DBCollection collection)
            throws MongoException, DataAccessException {
                return collection.count();
            }
        });
    }

    private List<String> getServicePropertiesAsList() {
        List<String> propList = new ArrayList<String>();
        if (serviceProperties != null) {
            for (Object key : serviceProperties.keySet()) {
                propList.add(key + ": " + serviceProperties.get(key));
            }
        }
        return propList;
    }

    private String genEater(int genLength) {
        Random rndm = new Random();
        char[] chars = { 'a', 'b', 'c', 'd', 'e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        StringBuffer sb = new StringBuffer(genLength);

        for (int i = 0; i < genLength; i++) {
            sb.append(chars[rndm.nextInt(chars.length)]);
        }
        return sb.toString();
    }
}