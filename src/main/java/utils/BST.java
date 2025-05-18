package utils;

import models.Property;
import java.util.ArrayList;
import java.util.List;

/**
 * Binary Search Tree implementation for property data structure
 */
public class BST {
    
    // Node class for BST
    private static class Node {
        Property property;
        Node left, right;
        
        Node(Property property) {
            this.property = property;
            left = right = null;
        }
    }
    
    private Node root;
    
    public BST() {
        root = null;
    }
    
    /**
     * Insert a property into the BST
     */
    public void insert(Property property) {
        root = insertRec(root, property);
    }
    
    private Node insertRec(Node root, Property property) {
        if (root == null) {
            root = new Node(property);
            return root;
        }
        
        if (property.compareTo(root.property) < 0) {
            root.left = insertRec(root.left, property);
        } else if (property.compareTo(root.property) > 0) {
            root.right = insertRec(root.right, property);
        }
        
        return root;
    }
    
    /**
     * Delete a property by ID
     */
    public void deleteById(String propertyId) {
        root = deleteByIdRec(root, propertyId);
    }
    
    private Node deleteByIdRec(Node root, String propertyId) {
        if (root == null) {
            return null;
        }
        
        if (root.property.getPropertyId().equals(propertyId)) {
            // Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }
            
            // Node with two children
            // Get the inorder successor (smallest in the right subtree)
            root.property = minValue(root.right);
            
            // Delete the inorder successor
            root.right = deleteByIdRec(root.right, root.property.getPropertyId());
        } else {
            // Search in both subtrees
            root.left = deleteByIdRec(root.left, propertyId);
            root.right = deleteByIdRec(root.right, propertyId);
        }
        
        return root;
    }
    
    private Property minValue(Node root) {
        Property minv = root.property;
        while (root.left != null) {
            minv = root.left.property;
            root = root.left;
        }
        return minv;
    }
    
    /**
     * Find property by ID
     */
    public Property findById(String propertyId) {
        return findByIdRec(root, propertyId);
    }
    
    private Property findByIdRec(Node root, String propertyId) {
        if (root == null) {
            return null;
        }
        
        if (root.property.getPropertyId().equals(propertyId)) {
            return root.property;
        }
        
        Property leftResult = findByIdRec(root.left, propertyId);
        if (leftResult != null) {
            return leftResult;
        }
        
        return findByIdRec(root.right, propertyId);
    }
    
    /**
     * Get all properties in the BST (inorder traversal)
     */
    public List<Property> getAllProperties() {
        List<Property> properties = new ArrayList<>();
        inorderTraversal(root, properties);
        return properties;
    }
    
    private void inorderTraversal(Node root, List<Property> properties) {
        if (root != null) {
            inorderTraversal(root.left, properties);
            properties.add(root.property);
            inorderTraversal(root.right, properties);
        }
    }
    
    /**
     * Get properties within a price range
     */
    public List<Property> getPropertiesInPriceRange(double minPrice, double maxPrice) {
        List<Property> properties = new ArrayList<>();
        getPropertiesInPriceRangeRec(root, properties, minPrice, maxPrice);
        return properties;
    }
    
    private void getPropertiesInPriceRangeRec(Node root, List<Property> properties, double minPrice, double maxPrice) {
        if (root != null) {
            if (root.property.getPrice() >= minPrice && root.property.getPrice() <= maxPrice) {
                properties.add(root.property);
            }
            
            if (root.property.getPrice() > minPrice) {
                getPropertiesInPriceRangeRec(root.left, properties, minPrice, maxPrice);
            }
            
            if (root.property.getPrice() < maxPrice) {
                getPropertiesInPriceRangeRec(root.right, properties, minPrice, maxPrice);
            }
        }
    }
}
