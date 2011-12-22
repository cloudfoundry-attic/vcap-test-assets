// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.vmware.appcloud.testapps.roo.guestbook.web;

import com.vmware.appcloud.testapps.roo.guestbook.domain.Guest;
import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect GuestController_Roo_Controller {
    
    @Autowired
    private GenericConversionService GuestController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String GuestController.create(@Valid Guest guest, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("guest", guest);
            return "guests/create";
        }
        guest.persist();
        return "redirect:/guests/" + encodeUrlPathSegment(guest.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String GuestController.createForm(Model model) {
        model.addAttribute("guest", new Guest());
        return "guests/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String GuestController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("guest", Guest.findGuest(id));
        model.addAttribute("itemId", id);
        return "guests/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String GuestController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("guests", Guest.findGuestEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Guest.countGuests() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("guests", Guest.findAllGuests());
        }
        return "guests/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String GuestController.update(@Valid Guest guest, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("guest", guest);
            return "guests/update";
        }
        guest.merge();
        return "redirect:/guests/" + encodeUrlPathSegment(guest.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String GuestController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("guest", Guest.findGuest(id));
        return "guests/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String GuestController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Guest.findGuest(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/guests?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    Converter<Guest, String> GuestController.getGuestConverter() {
        return new Converter<Guest, String>() {
            public String convert(Guest guest) {
                return new StringBuilder().append(guest.getName()).toString();
            }
        };
    }
    
    @PostConstruct
    void GuestController.registerConverters() {
        conversionService.addConverter(getGuestConverter());
    }
    
    private String GuestController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}