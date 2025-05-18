package utils;

import models.User;
import models.Property;
import models.RegularUser;
import models.AdminUser;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.nio.file.*;

import javax.servlet.ServletContext;

/**
 * Utility class for file operations
 */
public class FileManager {
    private static String DATA_DIRECTORY;
    private static String USERS_FILE;
    private static String PROPERTIES_FILE;
    
    // Initialize file paths
    public static void initialize(ServletContext context) {
        DATA_DIRECTORY = context.getInitParameter("data-directory");
        USERS_FILE = DATA_DIRECTORY + context.getInitParameter("users-file");
        PROPERTIES_FILE = DATA_DIRECTORY + context.getInitParameter("properties-file");
    }
    // User operations
    
    /**
     * Read all users from file
     */
    public static List<User> readAllUsers() throws IOException {
        List<User> users = new ArrayList<>();
        File file = new File(USERS_FILE);
        
        if (!file.exists()) {
            return users;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    String userType = parts[5];
                    User user;
                    
                    if ("admin".equals(userType)) {
                        user = AdminUser.fromFileString(line);
                    } else {
                        user = RegularUser.fromFileString(line);
                    }
                    
                    if (user != null) {
                        users.add(user);
                    }
                }
            }
        }
        
        return users;
    }
    
    /**
     * Find user by username
     */
    public static User findUserByUsername(String username) throws IOException {
        List<User> users = readAllUsers();
        
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        
        return null;
    }
    
    /**
     * Find user by ID
     */
    public static User findUserById(String userId) throws IOException {
        List<User> users = readAllUsers();
        
        for (User user : users) {
            if (user.getUserId().equals(userId)) {
                return user;
            }
        }
        
        return null;
    }
    
    /**
     * Add new user to file
     */
    public static void addUser(User user) throws IOException {
        try (PrintWriter writer = new PrintWriter(new FileWriter(USERS_FILE, true))) {
            writer.println(user.toFileString());
        }
    }
    
    /**
     * Update existing user
     */
    public static void updateUser(User updatedUser) throws IOException {
        List<User> users = readAllUsers();
        
        try (PrintWriter writer = new PrintWriter(new FileWriter(USERS_FILE))) {
            for (User user : users) {
                if (user.getUserId().equals(updatedUser.getUserId())) {
                    writer.println(updatedUser.toFileString());
                } else {
                    writer.println(user.toFileString());
                }
            }
        }
    }
    
    /**
     * Delete user by ID
     */
    public static void deleteUser(String userId) throws IOException {
        List<User> users = readAllUsers();
        
        try (PrintWriter writer = new PrintWriter(new FileWriter(USERS_FILE))) {
            for (User user : users) {
                if (!user.getUserId().equals(userId)) {
                    writer.println(user.toFileString());
                }
            }
        }
    }
    
    // Property operations
    
    /**
     * Read all properties from file
     */
    public static List<Property> readAllProperties() throws IOException {
        List<Property> properties = new ArrayList<>();
        File file = new File(PROPERTIES_FILE);
        
        if (!file.exists()) {
            return properties;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                
                Property property = Property.fromFileString(line);
                if (property != null) {
                    properties.add(property);
                }
            }
        }
        
        return properties;
    }
    
    /**
     * Find property by ID
     */
    public static Property findPropertyById(String propertyId) throws IOException {
        List<Property> properties = readAllProperties();
        
        for (Property property : properties) {
            if (property.getPropertyId().equals(propertyId)) {
                return property;
            }
        }
        
        return null;
    }
    
    /**
     * Add new property to file
     */
    public static void addProperty(Property property) throws IOException {
        try (PrintWriter writer = new PrintWriter(new FileWriter(PROPERTIES_FILE, true))) {
            writer.println(property.toFileString());
        }
    }
    
    /**
     * Update existing property
     */
    public static void updateProperty(Property updatedProperty) throws IOException {
        List<Property> properties = readAllProperties();
        
        try (PrintWriter writer = new PrintWriter(new FileWriter(PROPERTIES_FILE))) {
            for (Property property : properties) {
                if (property.getPropertyId().equals(updatedProperty.getPropertyId())) {
                    writer.println(updatedProperty.toFileString());
                } else {
                    writer.println(property.toFileString());
                }
            }
        }
    }
    
    /**
     * Delete property by ID
     */
    public static void deleteProperty(String propertyId) throws IOException {
        List<Property> properties = readAllProperties();
        
        try (PrintWriter writer = new PrintWriter(new FileWriter(PROPERTIES_FILE))) {
            for (Property property : properties) {
                if (!property.getPropertyId().equals(propertyId)) {
                    writer.println(property.toFileString());
                }
            }
        }
    }
}
