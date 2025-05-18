package utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;

/**
 * Listener for application initialization and destruction
 * This class ensures that required directories and files are created at application startup
 */
public class ApplicationListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        // Get data directory path from context parameters
        String dataDir = context.getInitParameter("data-directory");
        
        // Create directories if they don't exist
        File dataDirFile = new File(dataDir);
        if (!dataDirFile.exists()) {
            dataDirFile.mkdirs();
            context.log("Created data directory: " + dataDir);
        }
        
        // Check and create user and property files if they don't exist
        String usersFile = dataDir + context.getInitParameter("users-file");
        String propertiesFile = dataDir + context.getInitParameter("properties-file");
        
        try {
            File usersFileObj = new File(usersFile);
            if (!usersFileObj.exists()) {
                usersFileObj.createNewFile();
                context.log("Created users file: " + usersFile);
                
                // Create initial admin user
                String initialAdminData = "admin-" + System.currentTimeMillis() + 
                    ",admin,admin123,admin@realestate.com,1234567890,admin,super,Management";
                java.io.FileWriter fw = new java.io.FileWriter(usersFileObj);
                fw.write(initialAdminData);
                fw.close();
            }
            
            File propertiesFileObj = new File(propertiesFile);
            if (!propertiesFileObj.exists()) {
                propertiesFileObj.createNewFile();
                context.log("Created properties file: " + propertiesFile);
            }
            
            // Initialize FileManager with context parameters
            FileManager.initialize(context);
            
        } catch (Exception e) {
            context.log("Error initializing data files", e);
        }
        
        context.log("Real Estate Property Listings Portal initialized successfully");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        context.log("Real Estate Property Listings Portal shutdown");
    }
}
