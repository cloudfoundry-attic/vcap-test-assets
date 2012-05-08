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
package org.cloudfoundry.test.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.cloudfoundry.test.service.ServiceHolder;
import org.hibernate.impl.SessionFactoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controller that exposes basic information about dependencies that were
 * auto-wired on app startup
 *
 * @author Jennifer Hickey
 * @author Thomas Risberg
 *
 */
@Controller
public class ServiceController {

	@Autowired
	private ServiceHolder serviceHolder;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	@ResponseBody
	public String hello() throws IOException {
		return "Welcome to the vcap-java test application";
	}

	@RequestMapping(value = "/beans", method = RequestMethod.GET)
	public ResponseEntity<List<String>> getBeanNames() {
		if (serviceHolder.getBeanNames() == null) {
			return new ResponseEntity<List<String>>(HttpStatus.NOT_FOUND);
		}
		List<String> beans = Arrays.asList(serviceHolder.getBeanNames());
		return new ResponseEntity<List<String>>(beans, HttpStatus.OK);
	}

	@RequestMapping(value = "/hibernate", method = RequestMethod.GET)
	public ResponseEntity<String> getHibernateDialectClass() {
		if (serviceHolder.getSessionFactory() == null) {
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>(((SessionFactoryImpl)serviceHolder.getSessionFactory()).getDialect().getClass().getName(),
				HttpStatus.OK);
	}
}
