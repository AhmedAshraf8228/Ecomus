package iti.jets.service;

import java.sql.DriverManager;
import java.sql.SQLException;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import iti.jets.dao.impl.GenericRepoImpl;
import iti.jets.entity.Product;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebListener;

@WebListener  // This annotation automatically registers the listener in web.xml
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // You can add any initialization code here if needed
        ln("Application Initialized.");
        new GenericRepoImpl(Product.class);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // This method is called when the application is being stopped or undeployed
        try {
            // Deregister JDBC drivers
//            DriverManager.deregisterDriver(DriverManager.getDriver("jdbc:mysql://localhost:3306/mindmaze"));
//            ln("JDBC Driver unregistered.");

            // Stop MySQL's abandoned connection cleanup thread to avoid memory leak
            AbandonedConnectionCleanupThread.uncheckedShutdown();
            ln("Abandoned connection cleanup thread stopped.");

            // If you're using Hibernate, make sure to shut down the session factory or any other resource pools here

            // Optionally, you can perform other resource cleanup tasks like closing custom threads or services.

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
