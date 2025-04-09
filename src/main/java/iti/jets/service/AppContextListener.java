package iti.jets.service;

import java.sql.DriverManager;
import java.sql.SQLException;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebListener;

@WebListener  // This annotation automatically registers the listener in web.xml
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // You can add any initialization code here if needed
        System.out.println("Application Initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // This method is called when the application is being stopped or undeployed
        try {
            // Deregister JDBC drivers
//            DriverManager.deregisterDriver(DriverManager.getDriver("jdbc:mysql://localhost:3306/mindmaze"));
//            System.out.println("JDBC Driver unregistered.");

            // Stop MySQL's abandoned connection cleanup thread to avoid memory leak
            AbandonedConnectionCleanupThread.uncheckedShutdown();
            System.out.println("Abandoned connection cleanup thread stopped.");

            // If you're using Hibernate, make sure to shut down the session factory or any other resource pools here

            // Optionally, you can perform other resource cleanup tasks like closing custom threads or services.

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
