package servlets;

import models.Property;
import models.User;
import utils.BST;
import utils.FileManager;
import utils.QuickSort;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.ArrayList;

/**
 * Servlet for handling property operations
 */
public class PropertyServlet extends HttpServlet {
    private BST propertyBST;
    
    @Override
    public void init() {
        propertyBST = new BST();
        try {
            // Load all properties into BST
            List<Property> properties = FileManager.readAllProperties();
            for (Property property : properties) {
                propertyBST.insert(property);
            }
        } catch (IOException e) {
            getServletContext().log("Error initializing property BST", e);
        }
    }
    
    // Handle GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        // Check if session exists
        HttpSession session = request.getSession(false);
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/list")) {
            // Display property listings
            handleListProperties(request, response);
            
        } else if (pathInfo.equals("/add")) {
            // Display add property form
            // Only admin users can add properties
            if (session != null && "admin".equals(session.getAttribute("userType"))) {
                request.getRequestDispatcher("/WEB-INF/jsp/property-form.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
            
        } else if (pathInfo.startsWith("/edit/")) {
            // Display edit property form
            String propertyId = pathInfo.substring(6);
            handleEditProperty(request, response, propertyId);
            
        } else if (pathInfo.startsWith("/view/")) {
            // Display property details
            String propertyId = pathInfo.substring(6);
            handleViewProperty(request, response, propertyId);
            
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    // Handle POST requests
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        if ("add".equals(action)) {
            handleAddProperty(request, response);
        } else if ("update".equals(action)) {
            handleUpdateProperty(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteProperty(request, response);
        } else if ("search".equals(action)) {
            handleSearchProperties(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/properties");
        }
    }
    
    // Handle listing all properties
    private void handleListProperties(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all properties from file (for consistency)
        List<Property> properties = FileManager.readAllProperties();
        
        // Apply sorting (default: price ascending)
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        if (sortBy == null) {
            sortBy = "price"; // Default sort field
        }
        
        boolean ascending = !"desc".equals(sortOrder);
        
        if ("price".equals(sortBy)) {
            if (ascending) {
                QuickSort.sortByPriceAsc(properties);
            } else {
                QuickSort.sortByPriceDesc(properties);
            }
        } else if ("bedrooms".equals(sortBy)) {
            QuickSort.sortByBedrooms(properties, ascending);
        } else if ("area".equals(sortBy)) {
            QuickSort.sortByArea(properties, ascending);
        }
        
        // Apply filtering if parameters exist
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String location = request.getParameter("location");
        String propertyType = request.getParameter("propertyType");
        
        List<Property> filteredProperties = new ArrayList<>(properties);
        
        // Filter by price range - either minPrice or maxPrice or both can be provided
        if (minPriceStr != null && !minPriceStr.isEmpty() || maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try {
                double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? 
                    Double.parseDouble(minPriceStr) : Double.MIN_VALUE;
                    
                double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? 
                    Double.parseDouble(maxPriceStr) : Double.MAX_VALUE;
                
                List<Property> priceFilteredProperties = new ArrayList<>();
                for (Property property : filteredProperties) {
                    if (property.getPrice() >= minPrice && property.getPrice() <= maxPrice) {
                        priceFilteredProperties.add(property);
                    }
                }
                filteredProperties = priceFilteredProperties;
            } catch (NumberFormatException e) {
                // Log the error but continue with unfiltered properties
                getServletContext().log("Error parsing price values", e);
            }
        }
        
        // Filter by location if provided
        if (location != null && !location.isEmpty()) {
            List<Property> locationFilteredProperties = new ArrayList<>();
            for (Property property : filteredProperties) {
                if (property.getLocation().toLowerCase().contains(location.toLowerCase())) {
                    locationFilteredProperties.add(property);
                }
            }
            filteredProperties = locationFilteredProperties;
        }
        
        // Filter by property type if provided
        if (propertyType != null && !propertyType.isEmpty()) {
            List<Property> typeFilteredProperties = new ArrayList<>();
            for (Property property : filteredProperties) {
                if (property.getPropertyType().equalsIgnoreCase(propertyType)) {
                    typeFilteredProperties.add(property);
                }
            }
            filteredProperties = typeFilteredProperties;
        }
        
        request.setAttribute("properties", filteredProperties);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.getRequestDispatcher("/WEB-INF/jsp/property-listing.jsp").forward(request, response);
    }
    
    // Handle viewing a specific property
    private void handleViewProperty(HttpServletRequest request, HttpServletResponse response, String propertyId) throws ServletException, IOException {
        Property property = FileManager.findPropertyById(propertyId);
        
        if (property != null) {
            request.setAttribute("property", property);
            request.getRequestDispatcher("/WEB-INF/jsp/property-view.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/properties");
        }
    }
    
    // Handle displaying the edit property form
    private void handleEditProperty(HttpServletRequest request, HttpServletResponse response, String propertyId) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/properties");
            return;
        }
        
        Property property = FileManager.findPropertyById(propertyId);
        
        if (property != null) {
            request.setAttribute("property", property);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/WEB-INF/jsp/property-form.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/properties");
        }
    }
    
    // Handle adding a new property
    private void handleAddProperty(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Get parameters
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String location = request.getParameter("location");
        String bedroomsStr = request.getParameter("bedrooms");
        String bathroomsStr = request.getParameter("bathrooms");
        String areaStr = request.getParameter("area");
        String propertyType = request.getParameter("propertyType");
        String status = request.getParameter("status");
        String imageUrl = request.getParameter("imageUrl");
        
        // Validate required fields
        if (title == null || title.isEmpty() || 
            priceStr == null || priceStr.isEmpty() || 
            location == null || location.isEmpty()) {
            
            request.setAttribute("errorMessage", "Title, price, and location are required fields");
            request.getRequestDispatcher("/WEB-INF/jsp/property-form.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse numeric values
            double price = Double.parseDouble(priceStr);
            int bedrooms = bedroomsStr.isEmpty() ? 0 : Integer.parseInt(bedroomsStr);
            int bathrooms = bathroomsStr.isEmpty() ? 0 : Integer.parseInt(bathroomsStr);
            double area = areaStr.isEmpty() ? 0 : Double.parseDouble(areaStr);
            
            // Generate property ID
            String propertyId = UUID.randomUUID().toString();
            
            // Get owner ID from session
            String ownerId = (String) session.getAttribute("userId");
            
            // Create property object
            Property newProperty = new Property(
                propertyId,
                title,
                description,
                price,
                location,
                bedrooms,
                bathrooms,
                area,
                propertyType,
                ownerId,
                status,
                imageUrl
            );
            
            // Add property to file
            FileManager.addProperty(newProperty);
            
            // Update BST
            propertyBST.insert(newProperty);
            
            // Redirect to properties list
            response.sendRedirect(request.getContextPath() + "/properties");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric value");
            request.getRequestDispatcher("/WEB-INF/jsp/property-form.jsp").forward(request, response);
        }
    }
    
    // Handle updating an existing property
    private void handleUpdateProperty(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Get parameters
        String propertyId = request.getParameter("propertyId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String location = request.getParameter("location");
        String bedroomsStr = request.getParameter("bedrooms");
        String bathroomsStr = request.getParameter("bathrooms");
        String areaStr = request.getParameter("area");
        String propertyType = request.getParameter("propertyType");
        String status = request.getParameter("status");
        String imageUrl = request.getParameter("imageUrl");
        
        // Validate required fields
        if (propertyId == null || propertyId.isEmpty() || 
            title == null || title.isEmpty() || 
            priceStr == null || priceStr.isEmpty() || 
            location == null || location.isEmpty()) {
            
            request.setAttribute("errorMessage", "PropertyId, title, price, and location are required fields");
            request.getRequestDispatcher("/WEB-INF/jsp/property-form.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse numeric values
            double price = Double.parseDouble(priceStr);
            int bedrooms = bedroomsStr.isEmpty() ? 0 : Integer.parseInt(bedroomsStr);
            int bathrooms = bathroomsStr.isEmpty() ? 0 : Integer.parseInt(bathroomsStr);
            double area = areaStr.isEmpty() ? 0 : Double.parseDouble(areaStr);
            
            // Get original property to preserve owner ID
            Property originalProperty = FileManager.findPropertyById(propertyId);
            
            if (originalProperty == null) {
                response.sendRedirect(request.getContextPath() + "/properties");
                return;
            }
            
            // Update property object
            Property updatedProperty = new Property(
                propertyId,
                title,
                description,
                price,
                location,
                bedrooms,
                bathrooms,
                area,
                propertyType,
                originalProperty.getOwnerId(),
                status,
                imageUrl
            );
            
            // Update property in file
            FileManager.updateProperty(updatedProperty);
            
            // Update BST (delete and reinsert)
            propertyBST.deleteById(propertyId);
            propertyBST.insert(updatedProperty);
            
            // Redirect to properties list
            response.sendRedirect(request.getContextPath() + "/properties");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric value");
            request.getRequestDispatcher("/WEB-INF/jsp/property-form.jsp").forward(request, response);
        }
    }
    
    // Handle deleting a property
    private void handleDeleteProperty(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Get property ID
        String propertyId = request.getParameter("propertyId");
        
        if (propertyId != null && !propertyId.isEmpty()) {
            // Delete property from file
            FileManager.deleteProperty(propertyId);
            
            // Delete property from BST
            propertyBST.deleteById(propertyId);
        }
        
        // Redirect to properties list
        response.sendRedirect(request.getContextPath() + "/properties");
    }
    
    // Handle searching for properties
    private void handleSearchProperties(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect back to the listing page with search parameters
        // This is handled by the list method
        
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String location = request.getParameter("location");
        String propertyType = request.getParameter("propertyType");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        StringBuilder redirectUrl = new StringBuilder(request.getContextPath())
            .append("/properties?");
        
        if (minPrice != null && !minPrice.isEmpty()) {
            redirectUrl.append("minPrice=").append(minPrice).append("&");
        }
        
        if (maxPrice != null && !maxPrice.isEmpty()) {
            redirectUrl.append("maxPrice=").append(maxPrice).append("&");
        }
        
        if (location != null && !location.isEmpty()) {
            redirectUrl.append("location=").append(location).append("&");
        }
        
        if (propertyType != null && !propertyType.isEmpty()) {
            redirectUrl.append("propertyType=").append(propertyType).append("&");
        }
        
        if (sortBy != null && !sortBy.isEmpty()) {
            redirectUrl.append("sortBy=").append(sortBy).append("&");
        }
        
        if (sortOrder != null && !sortOrder.isEmpty()) {
            redirectUrl.append("sortOrder=").append(sortOrder);
        }
        
        response.sendRedirect(redirectUrl.toString());
    }
}
