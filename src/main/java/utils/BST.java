package utils;

import models.Property;
import java.util.ArrayList;
import java.util.List;

/**
 * Simple Binary Search Tree for storing and retrieving property data
 * A BST allows efficient searching, insertion and deletion operations
 */
public class BST {
    
    // Simple Node class for our tree
    private static class Node {
        Property property;
        Node left, right;
        
        Node(Property property) {
            this.property = property;
            left = right = null;
        }
    }
    
    private Node root;
    
    // Constructor - creates an empty tree
    public BST() {
        root = null;
    }
    
    /**
     * Add a property to the tree
     */
    public void insert(Property property) {
        root = addPropertyToTree(root, property);
    }
    
    // Helper method to add property in the correct position
    private Node addPropertyToTree(Node current, Property property) {
        // If tree is empty or we've reached a leaf node, create new node
        if (current == null) {
            return new Node(property);
        }
        
        // Compare prices to decide where to place the property
        if (property.getPrice() < current.property.getPrice()) {
            current.left = addPropertyToTree(current.left, property);
        } else {
            current.right = addPropertyToTree(current.right, property);
        }
        
        return current;
    }
    
    /**
     * Remove a property from the tree by ID
     */
    public void deleteById(String propertyId) {
        root = removeProperty(root, propertyId);
    }
    
    // Helper method to find and remove a property
    private Node removeProperty(Node current, String propertyId) {
        if (current == null) {
            return null;
        }
        
        // If this is the property to remove
        if (current.property.getPropertyId().equals(propertyId)) {
            // Case 1: No children
            if (current.left == null && current.right == null) {
                return null;
            }
            
            // Case 2: One child
            if (current.left == null) {
                return current.right;
            }
            if (current.right == null) {
                return current.left;
            }
            
            // Case 3: Two children
            // Find the smallest value in right subtree
            Property smallestValue = findSmallestProperty(current.right);
            current.property = smallestValue;
            
            // Remove the smallest node from right subtree
            current.right = removeProperty(current.right, smallestValue.getPropertyId());
        } else {
            // Search both subtrees
            current.left = removeProperty(current.left, propertyId);
            current.right = removeProperty(current.right, propertyId);
        }
        
        return current;
    }
    
    // Find the property with the smallest price in a subtree
    private Property findSmallestProperty(Node root) {
        Property smallest = root.property;
        while (root.left != null) {
            smallest = root.left.property;
            root = root.left;
        }
        return smallest;
    }
    
    /**
     * Find a property by its ID
     */
    public Property findById(String propertyId) {
        return searchForProperty(root, propertyId);
    }
    
    // Helper method to search for a property
    private Property searchForProperty(Node current, String propertyId) {
        if (current == null) {
            return null;
        }
        
        if (current.property.getPropertyId().equals(propertyId)) {
            return current.property;
        }
        
        // Check left subtree first
        Property leftResult = searchForProperty(current.left, propertyId);
        if (leftResult != null) {
            return leftResult;
        }
        
        // Then check right subtree
        return searchForProperty(current.right, propertyId);
    }
    
    /**
     * Get all properties stored in the tree
     */
    public List<Property> getAllProperties() {
        List<Property> properties = new ArrayList<>();
        collectPropertiesInOrder(root, properties);
        return properties;
    }
    
    // Helper method to collect all properties in ascending price order
    private void collectPropertiesInOrder(Node current, List<Property> properties) {
        if (current != null) {
            // First get all cheaper properties
            collectPropertiesInOrder(current.left, properties);
            // Then add this property
            properties.add(current.property);
            // Finally get all more expensive properties
            collectPropertiesInOrder(current.right, properties);
        }
    }
    
    /**
     * Get properties within a certain price range
     */
    public List<Property> getPropertiesInPriceRange(double minPrice, double maxPrice) {
        List<Property> properties = new ArrayList<>();
        findPropertiesInRange(root, properties, minPrice, maxPrice);
        return properties;
    }
    
    // Helper method to find properties in a price range
    private void findPropertiesInRange(Node current, List<Property> properties, double minPrice, double maxPrice) {
        if (current != null) {
            double currentPrice = current.property.getPrice();
            
            // Check if current property is in range
            if (currentPrice >= minPrice && currentPrice <= maxPrice) {
                properties.add(current.property);
            }
            
            // Search left subtree if it could contain properties in range
            if (currentPrice > minPrice) {
                findPropertiesInRange(current.left, properties, minPrice, maxPrice);
            }
            
            // Search right subtree if it could contain properties in range
            if (currentPrice < maxPrice) {
                findPropertiesInRange(current.right, properties, minPrice, maxPrice);
            }
        }
    }
}
