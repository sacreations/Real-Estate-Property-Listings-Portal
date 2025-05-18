package utils;

import models.Property;
import java.util.List;

/**
 * QuickSort implementation for sorting properties
 */
public class QuickSort {
    
    /**
     * Sort properties by price (ascending)
     */
    public static void sortByPriceAsc(List<Property> properties) {
        quickSortByPrice(properties, 0, properties.size() - 1, true);
    }
    
    /**
     * Sort properties by price (descending)
     */
    public static void sortByPriceDesc(List<Property> properties) {
        quickSortByPrice(properties, 0, properties.size() - 1, false);
    }
    
    /**
     * Sort properties by number of bedrooms
     */
    public static void sortByBedrooms(List<Property> properties, boolean ascending) {
        quickSortByBedrooms(properties, 0, properties.size() - 1, ascending);
    }
    
    /**
     * Sort properties by area
     */
    public static void sortByArea(List<Property> properties, boolean ascending) {
        quickSortByArea(properties, 0, properties.size() - 1, ascending);
    }
    
    // Helper methods for QuickSort
    
    private static void quickSortByPrice(List<Property> properties, int low, int high, boolean ascending) {
        if (low < high) {
            int pi = partitionByPrice(properties, low, high, ascending);
            
            quickSortByPrice(properties, low, pi - 1, ascending);
            quickSortByPrice(properties, pi + 1, high, ascending);
        }
    }
    
    private static int partitionByPrice(List<Property> properties, int low, int high, boolean ascending) {
        double pivot = properties.get(high).getPrice();
        int i = (low - 1);
        
        for (int j = low; j < high; j++) {
            if (ascending) {
                if (properties.get(j).getPrice() <= pivot) {
                    i++;
                    swap(properties, i, j);
                }
            } else {
                if (properties.get(j).getPrice() >= pivot) {
                    i++;
                    swap(properties, i, j);
                }
            }
        }
        
        swap(properties, i + 1, high);
        return i + 1;
    }
    
    private static void quickSortByBedrooms(List<Property> properties, int low, int high, boolean ascending) {
        if (low < high) {
            int pi = partitionByBedrooms(properties, low, high, ascending);
            
            quickSortByBedrooms(properties, low, pi - 1, ascending);
            quickSortByBedrooms(properties, pi + 1, high, ascending);
        }
    }
    
    private static int partitionByBedrooms(List<Property> properties, int low, int high, boolean ascending) {
        int pivot = properties.get(high).getBedrooms();
        int i = (low - 1);
        
        for (int j = low; j < high; j++) {
            if (ascending) {
                if (properties.get(j).getBedrooms() <= pivot) {
                    i++;
                    swap(properties, i, j);
                }
            } else {
                if (properties.get(j).getBedrooms() >= pivot) {
                    i++;
                    swap(properties, i, j);
                }
            }
        }
        
        swap(properties, i + 1, high);
        return i + 1;
    }
    
    private static void quickSortByArea(List<Property> properties, int low, int high, boolean ascending) {
        if (low < high) {
            int pi = partitionByArea(properties, low, high, ascending);
            
            quickSortByArea(properties, low, pi - 1, ascending);
            quickSortByArea(properties, pi + 1, high, ascending);
        }
    }
    
    private static int partitionByArea(List<Property> properties, int low, int high, boolean ascending) {
        double pivot = properties.get(high).getArea();
        int i = (low - 1);
        
        for (int j = low; j < high; j++) {
            if (ascending) {
                if (properties.get(j).getArea() <= pivot) {
                    i++;
                    swap(properties, i, j);
                }
            } else {
                if (properties.get(j).getArea() >= pivot) {
                    i++;
                    swap(properties, i, j);
                }
            }
        }
        
        swap(properties, i + 1, high);
        return i + 1;
    }
    
    private static void swap(List<Property> properties, int i, int j) {
        Property temp = properties.get(i);
        properties.set(i, properties.get(j));
        properties.set(j, temp);
    }
}
