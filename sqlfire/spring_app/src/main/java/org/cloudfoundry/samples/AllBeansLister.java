package org.cloudfoundry.samples;

import java.util.logging.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;

class AllBeansLister implements BeanFactoryPostProcessor {

    private static final Logger LOG =
            Logger.getLogger(AllBeansLister.class.getName());

    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory factory) throws BeansException {
        LOG.info("--->>> The factory contains the following beans:");
        String[] beanNames = factory.getBeanDefinitionNames();
        for (int i = 0; i < beanNames.length; ++i) {
            LOG.info("    --->>> " + beanNames[i]);
        }
    }
}