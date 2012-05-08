package org.cloudfoundry.test.web;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

@Configuration
@ImportResource("/WEB-INF/spring/servlet-context.xml")
public class ServletContextAnnotationConfig {
}
