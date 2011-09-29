package com.vmware.appcloud.testapps.roo.guestbook.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import com.vmware.appcloud.testapps.roo.guestbook.domain.Guest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "guests", formBackingObject = Guest.class)
@RequestMapping("/guests")
@Controller
public class GuestController {
}
