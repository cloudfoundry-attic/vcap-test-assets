package org.cloudfoundry.test;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

@Configuration
@ImportResource("classpath:/META-INF/spring/root-context.xml")
public class RootContextAnnotationConfig {
}
