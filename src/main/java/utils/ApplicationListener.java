package utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class runs when the application starts and stops
 * It sets up initial files and directories needed for the application
 * and validates critical application resources
 */
public class ApplicationListener implements ServletContextListener {
    
    private static final Logger LOGGER = Logger.getLogger(ApplicationListener.class.getName());
    
    // This method runs when the application starts
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        LOGGER.info("Starting Real Estate Portal initialization");
        
        // Get storage directory path from web.xml
        String dataDir = context.getInitParameter("data-directory");
        if (dataDir == null || dataDir.isEmpty()) {
            LOGGER.severe("Data directory path not configured in web.xml");
            return;
        }
        
        LOGGER.info("Using data directory: " + dataDir);
        
        // Create storage directory if it doesn't exist
        File dataDirFile = new File(dataDir);
        if (!dataDirFile.exists()) {
            if (dataDirFile.mkdirs()) {
                LOGGER.info("Created data directory: " + dataDir);
            } else {
                LOGGER.severe("Failed to create data directory: " + dataDir + ". Verify permissions.");
                return;
            }
        } else {
            LOGGER.info("Data directory exists: " + dataDir);
            if (!dataDirFile.canWrite() || !dataDirFile.canRead()) {
                LOGGER.severe("No read/write permission for data directory: " + dataDir);
                return;
            }
        }
        
        // Get file paths from web.xml
        String usersFileName = context.getInitParameter("users-file");
        String propertiesFileName = context.getInitParameter("properties-file");
        
        if (usersFileName == null || propertiesFileName == null) {
            LOGGER.severe("File configuration missing in web.xml");
            return;
        }
        
        String usersFile = dataDir + usersFileName;
        String propertiesFile = dataDir + propertiesFileName;
        
        LOGGER.info("Users file path: " + usersFile);
        LOGGER.info("Properties file path: " + propertiesFile);
        
        try {
            // Create users file if it doesn't exist
            File usersFileObj = new File(usersFile);
            if (!usersFileObj.exists()) {
                if (usersFileObj.createNewFile()) {
                    LOGGER.info("Created users file: " + usersFile);
                    
                    // Add a default admin user
                    String initialAdminData = "admin-" + System.currentTimeMillis() + 
                        ",admin,admin123,admin@realestate.com,1234567890,admin,super,Management";
                    try (FileWriter fw = new FileWriter(usersFileObj)) {
                        fw.write(initialAdminData);
                        LOGGER.info("Added default admin user");
                    }
                } else {
                    LOGGER.severe("Failed to create users file: " + usersFile + ". Verify permissions.");
                }
            } else {
                LOGGER.info("Users file exists: " + usersFile);
                if (usersFileObj.length() == 0) {
                    LOGGER.info("Users file is empty, adding default admin user");
                    // Add a default admin user
                    String initialAdminData = "admin-" + System.currentTimeMillis() + 
                        ",admin,admin123,admin@realestate.com,1234567890,admin,super,Management";
                    try (FileWriter fw = new FileWriter(usersFileObj)) {
                        fw.write(initialAdminData);
                        LOGGER.info("Added default admin user");
                    }
                }
            }
            
            // Create properties file if it doesn't exist
            File propertiesFileObj = new File(propertiesFile);
            if (!propertiesFileObj.exists()) {
                if (propertiesFileObj.createNewFile()) {
                    LOGGER.info("Created properties file: " + propertiesFile);
                } else {
                    LOGGER.severe("Failed to create properties file: " + propertiesFile + ". Verify permissions.");
                }
            } else {
                LOGGER.info("Properties file exists: " + propertiesFile);
            }
            
            // Set up the file paths in FileManager
            FileManager.initialize(context);
            
            // Validate critical application resources
            validateWebAppResources(context);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during application initialization", e);
        }
        
        LOGGER.info("Real Estate Portal started successfully");
    }
    
    // Validate that critical webapp resources exist
    private void validateWebAppResources(ServletContext context) {
        String webappPath = context.getRealPath("/");
        LOGGER.info("Webapp real path: " + webappPath);
        
        // Check if index.jsp exists
        validateResource(context, "/index.jsp", "Welcome page");
        
        // Check JSP directories
        validateDirectory(context, "/WEB-INF/jsp", "JSP directory");
        validateDirectory(context, "/WEB-INF/jsp/error", "Error JSP directory");
        
        // Check critical JSP files
        validateResource(context, "/WEB-INF/jsp/error/404.jsp", "404 error page");
        validateResource(context, "/WEB-INF/jsp/error/500.jsp", "500 error page");
    }
    
    private void validateResource(ServletContext context, String path, String description) {
        String fullPath = context.getRealPath(path);
        if (fullPath != null && Files.exists(Paths.get(fullPath))) {
            LOGGER.info("Found " + description + ": " + path);
        } else {
            LOGGER.warning("Missing " + description + ": " + path);
        }
    }
    
    private void validateDirectory(ServletContext context, String path, String description) {
        String fullPath = context.getRealPath(path);
        if (fullPath != null && Files.exists(Paths.get(fullPath)) && Files.isDirectory(Paths.get(fullPath))) {
            LOGGER.info("Found " + description + ": " + path);
        } else {
            LOGGER.warning("Missing " + description + ": " + path);
        }
    }
    
    // This method runs when the application stops
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("Real Estate Portal stopped");
    }
}
