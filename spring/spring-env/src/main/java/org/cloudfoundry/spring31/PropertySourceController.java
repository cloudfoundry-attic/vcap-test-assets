package org.cloudfoundry.spring31;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.EnumerablePropertySource;
import org.springframework.core.env.PropertySource;
import org.springframework.core.env.PropertySources;
import org.springframework.http.HttpEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/properties/sources")
public class PropertySourceController implements ApplicationContextAware {

	private ConfigurableEnvironment environemnt;
	private PropertySources propertySources;

	@RequestMapping
	public HttpEntity<List<String>> sources() {
		List<String> body = new ArrayList<String>();
		for (PropertySource<?> source : propertySources) {
			body.add(source.getName());
		}
		return new HttpEntity<List<String>>(body);
	}

	@RequestMapping("/source/{name:.*}")
	public HttpEntity<Map<String, Object>> source(@PathVariable String name) {
		PropertySource<?> source = propertySources.get(name);
		if (!(source instanceof EnumerablePropertySource)) {
			return new HttpEntity(null);
		}
		Map<String, Object> body = new HashMap<String, Object>();
		for (String key : ((EnumerablePropertySource<?>) source).getPropertyNames()) {
			body.put(key, source.getProperty(key));
		}
		return new HttpEntity<Map<String,Object>>(body);
	}

	@RequestMapping("/source/{name:.*}/{property:.*}")
	public HttpEntity<Object> sourceProperty(@PathVariable String name, @PathVariable String property) {
		PropertySource<?> source = propertySources.get(name);
		if (source == null) {
			return new HttpEntity(null);
		}
		Object body = source.getProperty(property);
		return new HttpEntity<Object>(body);
	}

	@RequestMapping("/property/{property:.*}")
	public HttpEntity<Object> property(@PathVariable String property) {
		Object body = environemnt.getProperty(property);
		return new HttpEntity<Object>(body);
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		environemnt = (ConfigurableEnvironment) applicationContext.getEnvironment();
		propertySources = environemnt.getPropertySources();
	}

}
