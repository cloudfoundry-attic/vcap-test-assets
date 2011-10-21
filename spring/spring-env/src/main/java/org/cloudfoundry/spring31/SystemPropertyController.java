package org.cloudfoundry.spring31;

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
@RequestMapping("/properties/system")
public class SystemPropertyController implements ApplicationContextAware {

	private ConfigurableEnvironment environemnt;

	@RequestMapping
	public HttpEntity<Map<String, Object>> properties() {
		Map<String, Object> body = environemnt.getSystemProperties();
		return new HttpEntity<Map<String, Object>>(body);
	}

	@RequestMapping("/{property:.*}")
	public HttpEntity<Object> property(@PathVariable String property) {
		Object body = environemnt.getSystemProperties().get(property);
		return new HttpEntity<Object>(body);
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		environemnt = (ConfigurableEnvironment) applicationContext.getEnvironment();
	}

}
