package org.cloudfoundry.s2qa;

import static org.springframework.data.mongodb.core.query.Criteria.where;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.CollectionCallback;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mongodb.DBCollection;
import com.mongodb.MongoException;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Inject
    private ReferenceDataRepository referenceRepository;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model) {
       logger.info("Welcome home!");
       model.addAttribute("services", referenceRepository.getDbEnv());
       String environmentName = (System.getenv("VCAP_APPLICATION") != null) ? "Cloud" : "Local";
       model.addAttribute("environmentName", environmentName);
       return "home";
    }

   @RequestMapping(value = "/setuptest", method = RequestMethod.GET)
   public String setuptest(Model model) {
      logger.info("Create initial db collection: items");
      model.addAttribute("services", referenceRepository.getDbEnv());
      model.addAttribute("previousItemCount", 0);
      model.addAttribute("itemCount", referenceRepository.setupInitTestDB());
      model.addAttribute("updatedItemCount", referenceRepository.getItemCount());
      return "dbcollectioncount";
   }

  @RequestMapping(value = "/dbeater", method = RequestMethod.GET)
   public String dbeater(Model model) {
       logger.info("Getting Full!");
       model.addAttribute("services", referenceRepository.getDbEnv());
       model.addAttribute("previousItemCount", referenceRepository.getItemCount());
       model.addAttribute("updatedItemCount", referenceRepository.addMoreItems());
       return "dbcollectioncount";
   }

  @RequestMapping(value = "/displaycollection", method = RequestMethod.GET)
   public String displaycollection(Model model) {
       logger.info("Getting Full!");
       model.addAttribute("services", referenceRepository.getDbEnv());
       model.addAttribute("previousItemCount", referenceRepository.getItemCount());
       model.addAttribute("updatedItemCount", referenceRepository.addMoreItems());
       model.addAttribute("itemlist", referenceRepository.displayItems());
       return "dbcollectionlist";
   }

   @RequestMapping(value = "/deleteall", method = RequestMethod.GET)
   public String deletedb(Model model) {
      logger.info("delete the database");
      model.addAttribute("services", referenceRepository.getDbEnv());
      model.addAttribute("previousItemCount", referenceRepository.getItemCount());
      model.addAttribute("itemCount", referenceRepository.deleteAll());
      model.addAttribute("updatedItemCount", referenceRepository.getItemCount());
      return "dbremovedstatus";
   }

   @RequestMapping(value = "/maxconnections", method = RequestMethod.GET)
   public String maxconnections(Model model) {
      logger.info("delete the database");
      model.addAttribute("services", referenceRepository.getDbEnv());
      model.addAttribute("totalConnections", referenceRepository.attemptMaxConnections());
      return "totalconnects";
   }

}
