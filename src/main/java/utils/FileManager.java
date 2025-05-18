package utils;

import models.User;
import models.Property;
import models.RegularUser;
import models.AdminUser;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletContext;

/**
 * This class handles all file operations for storing and retrieving data
 * It works with user and property files to save and load data
 */
public class FileManager {
    private static String DATA_DIRECTORY;    // Directory where data files are stored
    private static String USERS_FILE;        // Path to users data file
    private static String PROPERTIES_FILE;   // Path to properties data file
    private static final Logger LOGGER = Logger.getLogger(FileManager.class.getName());
    
    /**
     * Set up file paths based on application settings
     */
    public static void initialize(ServletContext context) {
        // Get paths from web.xml configuration
        DATA_DIRECTORY = context.getInitParameter("data-directory");
        String usersFileName = context.getInitParameter("users-file");
        String propertiesFileName = context.getInitParameter("properties-file");
        
        // Verify directory exists
        File dataDir = new File(DATA_DIRECTORY);
        if (!dataDir.exists()) {
            LOGGER.warning("Data directory does not exist: " + DATA_DIRECTORY);
            if (dataDir.mkdirs()) {
                LOGGER.info("Created data directory: " + DATA_DIRECTORY);
            } else {
                LOGGER.severe("Failed to create data directory: " + DATA_DIRECTORY);
            }
        }
        
        USERS_FILE = DATA_DIRECTORY + usersFileName;
        PROPERTIES_FILE = DATA_DIRECTORY + propertiesFileName;
        
        // Verify files exist
        verifyFilesExist();
    }
    
    /**
     * Verify that data files exist and are accessible
     */
    private static void verifyFilesExist() {
        File usersFile = new File(USERS_FILE);
        File propertiesFile = new File(PROPERTIES_FILE);
        
        try {
            if (!usersFile.exists()) {
                LOGGER.warning("Users file does not exist: " + USERS_FILE);
                if (usersFile.createNewFile()) {
                    LOGGER.info("Created users file: " + USERS_FILE);
                } else {
                    LOGGER.severe("Failed to create users file: " + USERS_FILE);
                }
            } else if (!usersFile.canRead() || !usersFile.canWrite()) {
                LOGGER.severe("Cannot read/write to users file: " + USERS_FILE);
            }
            
            if (!propertiesFile.exists()) {
                LOGGER.warning("Properties file does not exist: " + PROPERTIES_FILE);
                if (propertiesFile.createNewFile()) {
                    LOGGER.info("Created properties file: " + PROPERTIES_FILE);
                } else {
                    LOGGER.severe("Failed to create properties file: " + PROPERTIES_FILE);
                }
            } else if (!propertiesFile.canRead() || !propertiesFile.canWrite()) {
                LOGGER.severe("Cannot read/write to properties file: " + PROPERTIES_FILE);
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error verifying data files", e);
        }
    }
    
    // USER OPERATIONS
    
    /**
     * Get a list of all users from the users file
     */
    public static List<User> readAllUsers() throws IOException {
        List<User> users = new ArrayList<>();
        File file = new File(USERS_FILE);
        
        if (!file.exists()) {
            LOGGER.warning("Attempting to read non-existent users file: " + USERS_FILE);
            return users;  // Return empty list if file doesn't exist
        }
        
        if (file.length() == 0) {
            LOGGER.info("Users file is empty: " + USERS_FILE);
            return users;  // Return empty list if file is empty
        }
        
        // Read the file line by line
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                
                // Parse each line to create user objects
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    String userType = parts[5];
                    User user;
                    
                    // Create appropriate user type
                    if ("admin".equals(userType)) {
                        user = AdminUser.fromFileString(line);
                    } else {
                        user = RegularUser.fromFileString(line);
                    }
                    
                    if (user != null) {
                        users.add(user);
                    } else {
                        LOGGER.warning("Failed to parse user from line: " + line);
                    }
                } else {
                    LOGGER.warning("Invalid user data format: " + line);
                }
            }
        }
        
        LOGGER.info("Read " + users.size() + " users from file");
        return users;
    }
    
    /**
     * Find a user by their username
     */
    public static User findUserByUsername(String username) throws IOException {
        // Get all users and search for matching username
        List<User> users = readAllUsers();
        
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        
        return null;  // User not found
    }
    
    /**
     * Find a user by their ID
     */
    public static User findUserById(String userId) throws IOException {
        // Get all users and search for matching ID
        List<User> users = readAllUsers();
        
        for (User user : users) {
            if (user.getUserId().equals(userId)) {
                return user;
            }
        }
        
        return null;  // User not found
    }
    
    /**
     * Add a new user to the users file
     */
    public static void addUser(User user) throws IOException {
        File file = new File(USERS_FILE);
        
        // Create parent directory if it doesn't exist
        file.getParentFile().mkdirs();
        
        // Create file if it doesn't exist
        if (!file.exists()) {
            if (!file.createNewFile()) {
                LOGGER.severe("Failed to create users file for adding user: " + USERS_FILE);
                throw new IOException("Unable to create users file");
            }
        }
        
        // Append user to the end of the file
        try (PrintWriter writer = new PrintWriter(new FileWriter(file, true))) {
            writer.println(user.toFileString());
            LOGGER.info("Added user: " + user.getUsername());
        }
    }
    
    /**
     * Update an existing user in the file
     */
    public static void updateUser(User updatedUser) throws IOException {
        // Read all users
        List<User> users = readAllUsers();
        
        // Rewrite the entire file with updated user
        try (PrintWriter writer = new PrintWriter(new FileWriter(USERS_FILE))) {
            for (User user : users) {
                if (user.getUserId().equals(updatedUser.getUserId())) {
                    // Write updated user data
                    writer.println(updatedUser.toFileString());
                } else {
                    // Write existing user data
                    writer.println(user.toFileString());
                }
            }
        }
    }
    
    /**
     * Delete a user from the file
     */
    public static void deleteUser(String userId) throws IOException {
        // Read all users
        List<User> users = readAllUsers();
        
        // Rewrite file without the deleted user
        try (PrintWriter writer = new PrintWriter(new FileWriter(USERS_FILE))) {
            for (User user : users) {
                // Skip the user to be deleted
                if (!user.getUserId().equals(userId)) {
                    writer.println(user.toFileString());
                }
            }
        }
    }
    
    // PROPERTY OPERATIONS
    
    /**
     * Get a list of all properties from the properties file
     */
    public static List<Property> readAllProperties() throws IOException {
        List<Property> properties = new ArrayList<>();
        File file = new File(PROPERTIES_FILE);
        
        if (!file.exists()) {
            LOGGER.warning("Attempting to read non-existent properties file: " + PROPERTIES_FILE);
            return properties;  // Return empty list if file doesn't exist
        }
        
        if (file.length() == 0) {
            LOGGER.info("Properties file is empty: " + PROPERTIES_FILE);
            return properties;  // Return empty list if file is empty
        }
        
        // Read the file line by line
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                
                // Parse each line to create property objects
                Property property = Property.fromFileString(line);
                if (property != null) {
                    properties.add(property);
                } else {
                    LOGGER.warning("Failed to parse property from line: " + line);
                }
            }
        }
        
        LOGGER.info("Read " + properties.size() + " properties from file: " + PROPERTIES_FILE);
        return properties;
    }
    
    /**
     * Find a property by its ID
     */
    public static Property findPropertyById(String propertyId) throws IOException {
        // Get all properties and search for matching ID
        List<Property> properties = readAllProperties();
        
        for (Property property : properties) {
            if (property.getPropertyId().equals(propertyId)) {
                return property;
            }
        }
        
        return null;  // Property not found
    }
    
    /**
     * Add a new property to the properties file
     */
    public static void addProperty(Property property) throws IOException {
        File file = new File(PROPERTIES_FILE);
        
        // Create parent directory if it doesn't exist
        file.getParentFile().mkdirs();
        
        // Create file if it doesn't exist
        if (!file.exists()) {
            if (!file.createNewFile()) {
                LOGGER.severe("Failed to create properties file for adding property: " + PROPERTIES_FILE);
                throw new IOException("Unable to create properties file");
            }
        }
        
        // Append property to the end of the file
        try (PrintWriter writer = new PrintWriter(new FileWriter(file, true))) {
            writer.println(property.toFileString());
            LOGGER.info("Added property: " + property.getTitle());
        }
    }
    
    /**
     * Update an existing property in the file
     */
    public static void updateProperty(Property updatedProperty) throws IOException {
        // Read all properties
        List<Property> properties = readAllProperties();
        
        // Rewrite the entire file with updated property
        try (PrintWriter writer = new PrintWriter(new FileWriter(PROPERTIES_FILE))) {
            for (Property property : properties) {
                if (property.getPropertyId().equals(updatedProperty.getPropertyId())) {
                    // Write updated property data
                    writer.println(updatedProperty.toFileString());
                } else {
                    // Write existing property data
                    writer.println(property.toFileString());
                }
            }
        }
    }
    
    /**
     * Delete a property from the file
     */
    public static void deleteProperty(String propertyId) throws IOException {
        // Read all properties
        List<Property> properties = readAllProperties();
        
        // Rewrite file without the deleted property
        try (PrintWriter writer = new PrintWriter(new FileWriter(PROPERTIES_FILE))) {
            for (Property property : properties) {
                // Skip the property to be deleted
                if (!property.getPropertyId().equals(propertyId)) {
                    writer.println(property.toFileString());
                }
            }
        }
    }
}
