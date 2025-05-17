package models;

/**
 * Class for admin users
 */
public class AdminUser extends User {
    private String adminLevel;
    private String department;
    
    // Constructor
    public AdminUser(String userId, String username, String password, String email, 
                    String phoneNumber, String adminLevel, String department) {
        super(userId, username, password, email, phoneNumber);
        this.adminLevel = adminLevel;
        this.department = department;
    }
    
    // Getters and setters
    public String getAdminLevel() {
        return adminLevel;
    }
    
    public void setAdminLevel(String adminLevel) {
        this.adminLevel = adminLevel;
    }
    
    public String getDepartment() {
        return department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    
    @Override
    public String getUserType() {
        return "admin";
    }
    
    @Override
    public String toFileString() {
        return getUserId() + "," + getUsername() + "," + getPassword() + "," + 
               getEmail() + "," + getPhoneNumber() + "," + getUserType() + "," + 
               adminLevel + "," + department;
    }
    
    // Factory method to create from file string
    public static AdminUser fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length >= 8) {
            return new AdminUser(
                parts[0], // userId
                parts[1], // username
                parts[2], // password
                parts[3], // email
                parts[4], // phoneNumber
                parts[6], // adminLevel
                parts[7]  // department
            );
        }
        return null;
    }
}
