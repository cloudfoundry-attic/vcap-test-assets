package com.vmware.appcloud.testapps.guestbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/guest")
public class GuestController {
    @Autowired private GuestDao guestDao;

    public void setGuestDao(GuestDao guestDao) {
        this.guestDao = guestDao;
    }

    @RequestMapping(method=RequestMethod.POST)
    public String post(@RequestParam String name) {
        if (name != null) {
            guestDao.persist(new Guest(name));
        }
        return "redirect:/";
    }

   @RequestMapping(method=RequestMethod.GET)
   public ModelAndView get() {
       return new ModelAndView("guest", "guests", guestDao.getAllGuests());
   }

}
