package models;

import java.io.Serializable;

// This class represents a real estate property with all its details
// It stores information about location, price, size, etc.
public class Property implements Serializable, Comparable<Property> {
    private String propertyId;      // Unique identifier for the property
    private String title;           // Property title/name
    private String description;     // Detailed description
    private double price;           // Price in dollars
    private String location;        // Property location/address
    private int bedrooms;           // Number of bedrooms
    private int bathrooms;          // Number of bathrooms
    private double area;            // Area size in square feet/meters
    private String propertyType;    // Type: apartment, house, land, etc.
    private String ownerId;         // ID of the user who owns this property
    private String status;          // Status: for sale, sold, for rent, etc.
    private String imageUrl;        // URL to the property image
    
    // Constructor - creates a new property with all details
    public Property(String propertyId, String title, String description, double price, 
                   String location, int bedrooms, int bathrooms, double area,
                   String propertyType, String ownerId, String status, String imageUrl) {
        this.propertyId = propertyId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.location = location;
        this.bedrooms = bedrooms;
        this.bathrooms = bathrooms;
        this.area = area;
        this.propertyType = propertyType;
        this.ownerId = ownerId;
        this.status = status;
        this.imageUrl = imageUrl;
    }
    
    // Getters and setters for all properties
    // These allow us to access and modify the property details
    public String getPropertyId() {
        return propertyId;
    }
    
    public void setPropertyId(String propertyId) {
        this.propertyId = propertyId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public int getBedrooms() {
        return bedrooms;
    }
    
    public void setBedrooms(int bedrooms) {
        this.bedrooms = bedrooms;
    }
    
    public int getBathrooms() {
        return bathrooms;
    }
    
    public void setBathrooms(int bathrooms) {
        this.bathrooms = bathrooms;
    }
    
    public double getArea() {
        return area;
    }
    
    public void setArea(double area) {
        this.area = area;
    }
    
    public String getPropertyType() {
        return propertyType;
    }
    
    public void setPropertyType(String propertyType) {
        this.propertyType = propertyType;
    }
    
    public String getOwnerId() {
        return ownerId;
    }
    
    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    // Convert property to a string format for file storage
    public String toFileString() {
        return propertyId + "," + title + "," + description + "," + price + "," + 
               location + "," + bedrooms + "," + bathrooms + "," + area + "," +
               propertyType + "," + ownerId + "," + status + "," + imageUrl;
    }
    
    // Create a Property object from a string read from file
    public static Property fromFileString(String fileString) {
        String[] parts = fileString.split(",", 12); // Max 12 parts
        if (parts.length >= 11) {
            try {
                double price = Double.parseDouble(parts[3]);
                int bedrooms = Integer.parseInt(parts[5]);
                int bathrooms = Integer.parseInt(parts[6]);
                double area = Double.parseDouble(parts[7]);
                
                String imageUrl = parts.length > 11 ? parts[11] : "";
                
                return new Property(
                    parts[0],     // propertyId
                    parts[1],     // title
                    parts[2],     // description
                    price,        // price
                    parts[4],     // location
                    bedrooms,     // bedrooms
                    bathrooms,    // bathrooms
                    area,         // area
                    parts[8],     // propertyType
                    parts[9],     // ownerId
                    parts[10],    // status
                    imageUrl      // imageUrl
                );
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
    
    // Compare properties by price (used for sorting)
    @Override
    public int compareTo(Property other) {
        return Double.compare(this.price, other.price);
    }
}
