/*
 * Copyright 2009-2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.cloudfoundry.test.service;

import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * Container for auto-wired dependencies. Serves as verification of proper
 * dependency resolution by AppContext
 *
 * @author Jennifer Hickey
 * @author Thomas Risberg
 *
 */
@Component
public class ServiceHolder implements ApplicationContextAware {

	private final Logger log = LoggerFactory.getLogger(ServiceHolder.class);

	private ApplicationContext applicationContext;

	@Autowired(required=false)
	private SessionFactory sessionFactory;

	public String[] getBeanNames() {
		log.info("Retrieving bean names");
		return applicationContext.getBeanDefinitionNames();
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}
}
