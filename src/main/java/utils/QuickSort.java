package utils;

import models.Property;
import java.util.List;

/**
 * Simple QuickSort implementation for sorting property lists
 * QuickSort is an efficient sorting algorithm that uses divide-and-conquer
 */
public class QuickSort {
    
    /**
     * Sort properties by price (lowest to highest)
     */
    public static void sortByPriceAsc(List<Property> properties) {
        sortByPrice(properties, 0, properties.size() - 1, true);
    }
    
    /**
     * Sort properties by price (highest to lowest)
     */
    public static void sortByPriceDesc(List<Property> properties) {
        sortByPrice(properties, 0, properties.size() - 1, false);
    }
    
    /**
     * Sort properties by number of bedrooms
     */
    public static void sortByBedrooms(List<Property> properties, boolean ascending) {
        sortByBedrooms(properties, 0, properties.size() - 1, ascending);
    }
    
    /**
     * Sort properties by area size
     */
    public static void sortByArea(List<Property> properties, boolean ascending) {
        sortByArea(properties, 0, properties.size() - 1, ascending);
    }
    
    // Main QuickSort method for price
    private static void sortByPrice(List<Property> properties, int start, int end, boolean ascending) {
        if (start < end) {
            // Partition the list and get pivot position
            int pivotPosition = partitionByPrice(properties, start, end, ascending);
            
            // Sort the two halves
            sortByPrice(properties, start, pivotPosition - 1, ascending);
            sortByPrice(properties, pivotPosition + 1, end, ascending);
        }
    }
    
    // Helper method to partition the list by price
    private static int partitionByPrice(List<Property> properties, int start, int end, boolean ascending) {
        // Use the last element as pivot
        double pivotPrice = properties.get(end).getPrice();
        int i = start - 1;
        
        for (int j = start; j < end; j++) {
            if (ascending) {
                // For ascending order: keep smaller values to the left
                if (properties.get(j).getPrice() <= pivotPrice) {
                    i++;
                    swapProperties(properties, i, j);
                }
            } else {
                // For descending order: keep larger values to the left
                if (properties.get(j).getPrice() >= pivotPrice) {
                    i++;
                    swapProperties(properties, i, j);
                }
            }
        }
        
        // Put pivot in its correct position
        swapProperties(properties, i + 1, end);
        return i + 1;
    }
    
    // QuickSort method for bedrooms
    private static void sortByBedrooms(List<Property> properties, int start, int end, boolean ascending) {
        if (start < end) {
            int pivotPosition = partitionByBedrooms(properties, start, end, ascending);
            sortByBedrooms(properties, start, pivotPosition - 1, ascending);
            sortByBedrooms(properties, pivotPosition + 1, end, ascending);
        }
    }
    
    // Helper method to partition the list by bedrooms
    private static int partitionByBedrooms(List<Property> properties, int start, int end, boolean ascending) {
        int pivotBedrooms = properties.get(end).getBedrooms();
        int i = start - 1;
        
        for (int j = start; j < end; j++) {
            if (ascending) {
                if (properties.get(j).getBedrooms() <= pivotBedrooms) {
                    i++;
                    swapProperties(properties, i, j);
                }
            } else {
                if (properties.get(j).getBedrooms() >= pivotBedrooms) {
                    i++;
                    swapProperties(properties, i, j);
                }
            }
        }
        
        swapProperties(properties, i + 1, end);
        return i + 1;
    }
    
    // QuickSort method for area
    private static void sortByArea(List<Property> properties, int start, int end, boolean ascending) {
        if (start < end) {
            int pivotPosition = partitionByArea(properties, start, end, ascending);
            sortByArea(properties, start, pivotPosition - 1, ascending);
            sortByArea(properties, pivotPosition + 1, end, ascending);
        }
    }
    
    // Helper method to partition the list by area
    private static int partitionByArea(List<Property> properties, int start, int end, boolean ascending) {
        double pivotArea = properties.get(end).getArea();
        int i = start - 1;
        
        for (int j = start; j < end; j++) {
            if (ascending) {
                if (properties.get(j).getArea() <= pivotArea) {
                    i++;
                    swapProperties(properties, i, j);
                }
            } else {
                if (properties.get(j).getArea() >= pivotArea) {
                    i++;
                    swapProperties(properties, i, j);
                }
            }
        }
        
        swapProperties(properties, i + 1, end);
        return i + 1;
    }
    
    // Helper method to swap two properties in a list
    private static void swapProperties(List<Property> properties, int i, int j) {
        Property temp = properties.get(i);
        properties.set(i, properties.get(j));
        properties.set(j, temp);
    }
}
