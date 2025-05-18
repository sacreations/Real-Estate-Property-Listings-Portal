package utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;

/**
 * This class runs when the application starts and stops
 * It sets up initial files and directories needed for the application
 */
public class ApplicationListener implements ServletContextListener {
    
    // This method runs when the application starts
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        // Get storage directory path from web.xml
        String dataDir = context.getInitParameter("data-directory");
        
        // Create storage directory if it doesn't exist
        File dataDirFile = new File(dataDir);
        if (!dataDirFile.exists()) {
            dataDirFile.mkdirs();
            context.log("Created data directory: " + dataDir);
        }
        
        // Get file paths from web.xml
        String usersFile = dataDir + context.getInitParameter("users-file");
        String propertiesFile = dataDir + context.getInitParameter("properties-file");
        
        try {
            // Create users file if it doesn't exist
            File usersFileObj = new File(usersFile);
            if (!usersFileObj.exists()) {
                usersFileObj.createNewFile();
                context.log("Created users file: " + usersFile);
                
                // Add a default admin user
                String initialAdminData = "admin-" + System.currentTimeMillis() + 
                    ",admin,admin123,admin@realestate.com,1234567890,admin,super,Management";
                java.io.FileWriter fw = new java.io.FileWriter(usersFileObj);
                fw.write(initialAdminData);
                fw.close();
            }
            
            // Create properties file if it doesn't exist
            File propertiesFileObj = new File(propertiesFile);
            if (!propertiesFileObj.exists()) {
                propertiesFileObj.createNewFile();
                context.log("Created properties file: " + propertiesFile);
            }
            
            // Set up the file paths in FileManager
            FileManager.initialize(context);
            
        } catch (Exception e) {
            context.log("Error creating data files", e);
        }
        
        context.log("Real Estate Portal started successfully");
    }
    
    // This method runs when the application stops
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        context.log("Real Estate Portal stopped");
    }
}
