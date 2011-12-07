package org.cloudfoundry.s2qa;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
}