package org.cloudfoundry.imagemagick;

import java.lang.ClassLoader;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
    public class HomeController {

    @Inject
	private MagickProcesser magickProcesser;
    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

	ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
	String path = classLoader.getResource("imagemagick.jpg").getPath();

	if (magickProcesser.resize(path, "100x100")) {
	    // Resize was successful
	    String newSize = magickProcesser.getSize(path);

	    if (new String("100x100").equals(newSize)) {
		model.addAttribute("message", "hello from imagemagick");
	    }
	}

	return "home";
    }
}
