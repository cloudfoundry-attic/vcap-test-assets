package org.cloudfoundry.s2qa;

import static org.springframework.data.mongodb.core.query.Criteria.where;

import java.util.Iterator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.inject.Inject;

import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.CollectionCallback;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mongodb.DBCollection;
import com.mongodb.MongoException;
import com.mongodb.Mongo;
import com.mongodb.DB;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;

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

   public int attemptMaxConnections() {
     DB db[] = new DB[500];
     Mongo mongo[] = new Mongo[500];
     int numConns = 0;
     String mongoUrl = mongoDbFactory.getDb().getMongo().getAddress().toString();
     String mongoAddress[] = mongoUrl.split("\\:");
     try {
        for (numConns = 0; numConns < 500; numConns++) {
           mongo[numConns] = new Mongo(mongoAddress[0], Integer.parseInt(mongoAddress[1].trim()));
           db[numConns] = mongo[numConns].getDB( "mydb" + Integer.toString(numConns));
        }
     } catch (UnknownHostException e) {
         e.printStackTrace();
     } catch (MongoException e) {
         e.printStackTrace();
     }
     return numConns;
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

   private String genEater(int genLength)
   {
     Random rndm = new Random();
     char[] chars = { 'a', 'b', 'c', 'd', 'e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
     StringBuffer sb = new StringBuffer(genLength);

     for (int i = 0; i < genLength; i++) {
        sb.append(chars[rndm.nextInt(chars.length)]);
     }
     return sb.toString();
  }
}