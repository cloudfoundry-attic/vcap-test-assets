package org.cloudfoundry.s2qa;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

   private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

   @Inject
   private ReferenceDataRepository referenceRepository;

   /**
    * Prepares the Model with some metadata and the list of Items retrieved
    * from the DB. Then, selects the home view to render by returning its name.
    */
   @RequestMapping(value="/", method=RequestMethod.GET)
   public String home(Model model) {
       logger.info("Welcome home!");
       model.addAttribute("dbInfo", referenceRepository.getDbInfo());
       model.addAttribute("items", referenceRepository.findAllTables());
       return "home";
   }

  @RequestMapping(value = "/setuptest", method = RequestMethod.GET)
  public String setuptest(Model model) {
      logger.info("Create initial db table: current_items");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("itemExists", referenceRepository.setupInitTestDBTable());
      model.addAttribute("allTables", referenceRepository.findAllTables());
      return "dbtablelist";
   }

   @RequestMapping(value = "/dbeater", method = RequestMethod.GET)
   public String dbeater(Model model) {
       logger.info("Getting Full!");
       model.addAttribute("dbInfo", referenceRepository.getDbInfo());
       model.addAttribute("previousItemCount", referenceRepository.countItems());
       model.addAttribute("fatterItemCount", referenceRepository.addMoreItems());
       return "dbeater";
   }

   @RequestMapping(value = "/dbslimmer", method = RequestMethod.GET)
   public String dbslimmer(Model model) {
      logger.info("Getting Slimmer!");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("previousItemCount", referenceRepository.countItems());
      model.addAttribute("slimmerItemCount", referenceRepository.removeItems());
      return "dbslimmer";
   }

   @RequestMapping(value = "/dbtally", method = RequestMethod.GET)
   public String dbcount(Model model) {
      logger.info("Getting Count after adding data");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("currentItemCount", referenceRepository.countItems());
      return "dbtally";
   }

   @RequestMapping(value = "/dbdroptable", method = RequestMethod.GET)
   public String dbdroptable(Model model) {
      logger.info("Attempting to drop table current_items");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("itemExists", referenceRepository.dropItemsTable());
      model.addAttribute("allTables", referenceRepository.findAllTables());
      return "dbtablelist";
   }

   @RequestMapping(value = "/newtables", method = RequestMethod.GET)
   public String newtables(Model model) {
      logger.info("Attempting addtion of New Table to db");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("itemExists", referenceRepository.addNewItemCategories());
      model.addAttribute("allTables", referenceRepository.findAllTables());
      return "dbtablelist";
   }

   @RequestMapping(value = "/addtaxtable", method = RequestMethod.GET)
   public String newtaxes(Model model) {
      logger.info("Attempting addtion of new table: item_taxes");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("itemExists", referenceRepository.addTaxTable());
      model.addAttribute("allTables", referenceRepository.findAllTables());
      return "dbtablelist";
   }

   @RequestMapping(value = "/differentview", method = RequestMethod.GET)
   public String newview(Model model) {
      logger.info("Attempting to add a view for table : item_taxes");
      model.addAttribute("dbInfo", referenceRepository.getDbInfo());
      model.addAttribute("newView", referenceRepository.viewThingsDifferently());
      model.addAttribute("taxItems", referenceRepository.findAllTaxes());
      return "taxtally";
   }
}
