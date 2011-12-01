package org.cloudfoundry.s2qa;

import java.util.Iterator;
import java.util.Random;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.inject.Inject;
import javax.sql.DataSource;


import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;


@Repository
@Transactional
public class ReferenceDataRepository {

    private JdbcTemplate jdbcTemplate;

    @Inject
    public void init(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public String getDbInfo() {
    DataSource dataSource = jdbcTemplate.getDataSource();
        if (dataSource instanceof BasicDataSource) {
            return ((BasicDataSource) dataSource).getUrl() + ", username: " + ((BasicDataSource) dataSource).getUsername() + ", password: " + ((BasicDataSource) dataSource).getPassword();
        }
        else if (dataSource instanceof SimpleDriverDataSource) {
            return ((SimpleDriverDataSource) dataSource).getUrl();
        }
        return dataSource.toString();
    }

    public boolean setupInitTestDBTable() {
        boolean initTableExists = false;
        String newItem = genEater(8);
        String vendor = getDBVendor();
        //make sure we are starting from scratch...
        this.jdbcTemplate.execute("drop table if exists current_items");

        if (vendor.equalsIgnoreCase("mysql")) {
            this.jdbcTemplate.execute("create table current_items (id INT(3) PRIMARY KEY AUTO_INCREMENT, item_code char(2), name varchar(1024))");
        }
        else if (vendor.equalsIgnoreCase("postgresql")) {
            this.jdbcTemplate.execute("create table current_items (id SERIAL PRIMARY KEY, item_code char(2), name varchar(1024))");
        }
        else
            return initTableExists;
        addMoreItems();
        return dbTableExists(initTableExists, "current_items");
    }

    public int addMoreItems() {
        int resultItems;
        for (int i = 5; i < 5000; i++) {
            this.jdbcTemplate.update("INSERT INTO current_items (item_code, name) VALUES (" + "\'QA\'" + ",\'" + genEater(1024) + "\')");
        }
        return resultItems = this.jdbcTemplate.queryForInt("select count(*) from current_items");
    }

    public boolean addTaxTable() {
        boolean tableExists = false;
        String newItemQualifier = genEater(8);
        String vendor = getDBVendor();
        if (vendor.equalsIgnoreCase("mysql")) {
            this.jdbcTemplate.execute("create table item_taxes (id INT(3) PRIMARY KEY AUTO_INCREMENT, tax_rate float,  cost float, itemcategory varchar(25))");
        }
        else if  (vendor.equalsIgnoreCase("postgresql")) {
            this.jdbcTemplate.execute("create table item_taxes (id SERIAL PRIMARY KEY, tax_rate float,  cost float, itemcategory varchar(25))");
        } else
            return tableExists;

        for (int i = 5; i < 500; i++) {
           this.jdbcTemplate.update("INSERT INTO item_taxes (tax_rate, cost, itemcategory) VALUES (0.05," + genCost(i)  + ",\'cftest\')");
        }
        this.jdbcTemplate.update("INSERT INTO item_taxes (tax_rate, cost, itemcategory) VALUES (0.05," + genCost(30) + ",\'notcftest\')");
        return dbTableExists(tableExists, "item_taxes");
    }

    public int viewThingsDifferently() {
        this.jdbcTemplate.execute("CREATE VIEW tax_revenue AS SELECT id, cost, tax_rate, cost*tax_rate AS total_tax FROM item_taxes WHERE itemcategory = \'notcftest\'");
        return this.jdbcTemplate.queryForInt("select count(*) from tax_revenue");
    }

    public List<Tax> findAllTaxes() {
        return this.jdbcTemplate.query("select * from tax_revenue", new RowMapper<Tax>() {
           public Tax mapRow(ResultSet rs, int rowNum) throws SQLException {
              Tax tax = new Tax();
              tax.setId(rs.getLong("id"));
              tax.setTaxCost(rs.getFloat("cost"));
              tax.setTaxRate(rs.getFloat("tax_rate"));
              tax.setTaxTotal(rs.getFloat("total_tax"));
              return tax;
           }
        });
    }

    public boolean dropItemsTable() {
        boolean currentItemTableExists = true;
        this.jdbcTemplate.update("drop table current_items");
        return dbTableExists(currentItemTableExists, "current_items");
    }

    public int removeItems() {
        this.jdbcTemplate.update("delete from current_items where id > 10000");
        int slimmerRowCount = this.jdbcTemplate.queryForInt("select count(*) from current_items");
        return slimmerRowCount;
    }

    public int countItems() {
        return this.jdbcTemplate.queryForInt("select count(*) from current_items");
    }

    public boolean addNewItemCategories() {
        boolean tableExists = false;
        String newItemQualifier = genEater(8);
        this.jdbcTemplate.execute("create table other_categories_"+ newItemQualifier + " (id integer, country_name varchar(100))");
        return dbTableExists(tableExists, "other_categories_"+newItemQualifier);
    }

    public List<String> findAllTables() {
        String vendor = getDBVendor();
        if (vendor.equalsIgnoreCase("postgresql")) {
            return this.jdbcTemplate.queryForList("SELECT table_name FROM information_schema.tables WHERE table_schema = \'public\'", String.class);
        }
        else if (vendor.equalsIgnoreCase("mysql")) {
            return this.jdbcTemplate.queryForList("show tables", String.class);
        }
        else {
            String[] vendorTables = {"no tables found"};
            return new ArrayList<String>(vendorTables.length);
        }
    }

    public List<Item> findAll() {
        return this.jdbcTemplate.query("select * from current_items", new RowMapper<Item>() {
            public Item mapRow(ResultSet rs, int rowNum) throws SQLException {
                Item itm = new Item();
                itm.setId(rs.getLong("id"));
                itm.setItemCode(rs.getString("item_code"));
                itm.setName(rs.getString("name"));
                return itm;
            }
        });
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

    private String getDBVendor() {
        String vendorUrl = new String();
        DataSource dataSource = jdbcTemplate.getDataSource();
        if (dataSource instanceof BasicDataSource) {
            vendorUrl =  ((BasicDataSource) dataSource).getUrl().toString();
        }
        else if (dataSource instanceof SimpleDriverDataSource) {
            vendorUrl = ((SimpleDriverDataSource) dataSource).getUrl().toString();
        }
        if (vendorUrl.contains("postgresql")) {
            return new String("postgresql");
        }
        else if (vendorUrl.contains("mysql")) {
            return new String("mysql");
        }
        return new String("novendor");
    }

    private boolean dbTableExists(boolean initialTableExistsState, String dbTableName) {
        List<String> allDBTables;
        String vendor = getDBVendor();
        boolean endingTableExistsState = initialTableExistsState;
        if (vendor.equalsIgnoreCase("mysql")) {
            allDBTables = this.jdbcTemplate.queryForList("show tables", String.class);
        }
        else if (vendor.equalsIgnoreCase("postgresql")) {
            allDBTables = this.jdbcTemplate.queryForList("SELECT table_name FROM information_schema.tables WHERE table_schema = \'public\'", String.class);
        }
        else
            return endingTableExistsState;

        Iterator<String> it = allDBTables.iterator();
        while ( it.hasNext() ) {
            if (it.next().indexOf(dbTableName) != -1) {
                endingTableExistsState = true;
            }
        }
        return endingTableExistsState;
    }

    private float genCost(int level) {
        Random rndm = new Random();
        return rndm.nextFloat() * level * 1000;
    }

}