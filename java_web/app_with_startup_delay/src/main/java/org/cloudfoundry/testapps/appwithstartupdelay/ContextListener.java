package org.cloudfoundry.testapps.appwithstartupdelay;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Date;

public class ContextListener implements ServletContextListener {

    public void contextDestroyed(ServletContextEvent arg0) {
    }

    public void contextInitialized(ServletContextEvent arg0) {
        try {
            Thread.sleep(45 * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
