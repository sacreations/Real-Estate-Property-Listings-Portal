package models;

import java.io.Serializable;

/**
 * Class representing a real estate property
 */
public class Property implements Serializable, Comparable<Property> {
    private String propertyId;
    private String title;
    private String description;
    private double price;
    private String location;
    private int bedrooms;
    private int bathrooms;
    private double area;
    private String propertyType;
    private String ownerId;
    private String status;
    private String imageUrl;
    
    // Constructor
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
    
    // Getters and setters
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
    
    // For file operations
    public String toFileString() {
        return propertyId + "," + title + "," + description + "," + price + "," + 
               location + "," + bedrooms + "," + bathrooms + "," + area + "," +
               propertyType + "," + ownerId + "," + status + "," + imageUrl;
    }
    
    // Factory method to create from file string
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
    
    // For BST operations
    @Override
    public int compareTo(Property other) {
        return Double.compare(this.price, other.price);
    }
}
