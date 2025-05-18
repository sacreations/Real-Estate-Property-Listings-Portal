package models;

/**
 * Abstract base class for all user types
 */
public abstract class User {
    private String userId;
    private String username;
    private String password;
    private String email;
    private String phoneNumber;
    
    // Constructor
    public User(String userId, String username, String password, String email, String phoneNumber) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }
    
    // Getters and setters
    public String getUserId() {
        return userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    // Abstract methods
    public abstract String getUserType();
    
    // For file operations
    public abstract String toFileString();
}
