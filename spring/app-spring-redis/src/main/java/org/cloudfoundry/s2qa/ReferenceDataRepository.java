package org.cloudfoundry.s2qa;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import org.cloudfoundry.runtime.env.AbstractServiceInfo;
import org.cloudfoundry.runtime.env.CloudEnvironment;
import org.cloudfoundry.runtime.env.RedisServiceInfo;
import org.springframework.context.annotation.Bean;

import redis.clients.jedis.Jedis;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class ReferenceDataRepository {

    @Autowired(required = false)
        @Qualifier(value = "serviceProperties")
        Properties serviceProperties;

    protected Jedis jedis;


    public List<String> getDbEnv() {
        List<String> services = new ArrayList<String>();
        RedisServiceInfo service = (RedisServiceInfo) getService(RedisServiceInfo.class);
        if (service != null) {
            jedis = new Jedis(service.getHost(), service.getPort());
            jedis.auth(service.getPassword());
            services.add("Redis: Host" + service.getHost() + " Port:" + service.getPort() + " Password:" + service.getPassword());
        }
        return services;
    }

    public int setupInitTestDB() {
        RedisServiceInfo service = (RedisServiceInfo) getService(RedisServiceInfo.class);
        if (jedis != null) {
            deleteAll();
            jedis.quit();
        }
        jedis = new Jedis(service.getHost(), service.getPort());
        jedis.auth(service.getPassword());
        addMoreItems();
        return getItemCount();
    }

    public int addMoreItems() {
        for (int currentCount = 1 ; currentCount < 20; currentCount++) {
            String itm = "ItemNo-" + System.currentTimeMillis() + Integer.toString(currentCount);
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            jedis.set(itm, genEater(1024));
        }
        return getItemCount();
    }

    public int getItemCount() {
        List<String> items = jedis.keys("ItemNo*");
        return items.size();
    }

    public List<String> displayItems() {
        List<String> items = jedis.keys("ItemNo*");
        return items;
    }

    public long deleteAll() {
        int keysRemoved = 0;
        if (jedis.dbSize() != 0) {
            List<String> items = jedis.keys("ItemNo*");
            Iterator it = items.iterator();
            while(it.hasNext())
            {
                String value=(String)it.next();
                keysRemoved = jedis.del(value);
            }
        }
        return getItemCount();
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