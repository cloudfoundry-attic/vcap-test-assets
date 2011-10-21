package org.cloudfoundry.spring31;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.http.HttpEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/profiles")
public class ProfileController implements ApplicationContextAware {

	private ConfigurableEnvironment environemnt;

	@RequestMapping
	public HttpEntity<Map<String, String[]>> profiles() {
		Map<String, String[]> body = new HashMap<String, String[]>();
		body.put("active", environemnt.getActiveProfiles());
		body.put("default", environemnt.getDefaultProfiles());
		return new HttpEntity<Map<String, String[]>>(body);
	}

	@RequestMapping("/active")
	public HttpEntity<String[]> activeProfiles() {
		String[] body = environemnt.getActiveProfiles();
		return new HttpEntity<String[]>(body);
	}

	@RequestMapping("/default")
	public HttpEntity<String[]> defaultProfiles() {
		String[] body = environemnt.getDefaultProfiles();
		return new HttpEntity<String[]>(body);
	}

	@RequestMapping("/active/{profile:.*}")
	public HttpEntity<Boolean> activeProfile(@PathVariable String profile) {
		boolean body = environemnt.acceptsProfiles(profile);
		return new HttpEntity<Boolean>(body);
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		environemnt = (ConfigurableEnvironment) applicationContext.getEnvironment();
	}

}
