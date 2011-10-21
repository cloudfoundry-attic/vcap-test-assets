package org.cloudfoundry.spring31;

import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.stereotype.Controller;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController implements ApplicationContextAware {

	private ConfigurableEnvironment environemnt;

	@RequestMapping("/")
	public String home(Map<String, Object> model) {
		model.put("environmentType", environemnt.getClass().getName());
		model.put("activeProfiles", environemnt.getActiveProfiles());
		model.put("defaultProfiles", environemnt.getDefaultProfiles());
		model.put("systemEnvironment", environemnt.getSystemEnvironment().entrySet());
		model.put("propertySources", ReflectionTestUtils.getField(environemnt.getPropertySources(), "propertySourceList"));
		model.put("systemProperties", environemnt.getSystemProperties().entrySet());
		return "home";
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		environemnt = (ConfigurableEnvironment) applicationContext.getEnvironment();
	}

}

