package utils;

import models.Property;

/**
 * Node class for the Binary Search Tree
 * Each node contains a property and references to left and right children
 */
public class BSTNode {
    private Property property;
    private BSTNode left;
    private BSTNode right;
    
    // Constructor
    public BSTNode(Property property) {
        this.property = property;
        this.left = null;
        this.right = null;
    }
    
    // Getters and setters
    public Property getProperty() {
        return property;
    }
    
    public void setProperty(Property property) {
        this.property = property;
    }
    
    public BSTNode getLeft() {
        return left;
    }
    
    public void setLeft(BSTNode left) {
        this.left = left;
    }
    
    public BSTNode getRight() {
        return right;
    }
    
    public void setRight(BSTNode right) {
        this.right = right;
    }
    
    // Helper method to check if this is a leaf node
    public boolean isLeaf() {
        return left == null && right == null;
    }
    
    // Helper method to check if node has both children
    public boolean hasFullChildren() {
        return left != null && right != null;
    }
}
