package models;

/**
 * Class for regular users
 */
public class RegularUser extends User {
    private String address;
    private String preferences;
    
    // Constructor
    public RegularUser(String userId, String username, String password, String email, 
                      String phoneNumber, String address, String preferences) {
        super(userId, username, password, email, phoneNumber);
        this.address = address;
        this.preferences = preferences;
    }
    
    // Getters and setters
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPreferences() {
        return preferences;
    }
    
    public void setPreferences(String preferences) {
        this.preferences = preferences;
    }
    
    @Override
    public String getUserType() {
        return "regular";
    }
    
    @Override
    public String toFileString() {
        return getUserId() + "," + getUsername() + "," + getPassword() + "," + 
               getEmail() + "," + getPhoneNumber() + "," + getUserType() + "," + 
               address + "," + preferences;
    }
    
    // Factory method to create from file string
    public static RegularUser fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length >= 7) {
            // Combine preferences if they contain commas
            String preferences = parts.length > 7 ? 
                String.join(",", java.util.Arrays.copyOfRange(parts, 7, parts.length)) : "";
            
            return new RegularUser(
                parts[0], // userId
                parts[1], // username
                parts[2], // password
                parts[3], // email
                parts[4], // phoneNumber
                parts[6], // address
                preferences // preferences
            );
        }
        return null;
    }
}
