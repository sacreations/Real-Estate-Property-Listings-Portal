package servlets;

import models.User;
import models.AdminUser;
import models.Property;
import models.RegularUser; // Added missing import
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

/**
 * Servlet for handling admin operations
 */
public class AdminServlet extends HttpServlet {

    // Handle GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
            // Display admin dashboard
            showDashboard(request, response);
        } else if (pathInfo.equals("/users")) {
            // Display user management page
            showUserManagement(request, response);
        } else if (pathInfo.equals("/users/add")) {
            // Display add user form
            request.getRequestDispatcher("/WEB-INF/jsp/admin-user-form.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/users/edit/")) {
            // Display edit user form
            String userId = pathInfo.substring(12);
            showEditUserForm(request, response, userId);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    // Handle POST requests
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        if ("addUser".equals(action)) {
            addUser(request, response);
        } else if ("updateUser".equals(action)) {
            updateUser(request, response);
        } else if ("deleteUser".equals(action)) {
            deleteUser(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
    
    // Show admin dashboard with summary information
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all users and properties
        List<User> users = FileManager.readAllUsers();
        List<Property> properties = FileManager.readAllProperties();
        
        // Count regular users and admin users
        int regularUserCount = 0;
        int adminUserCount = 0;
        
        for (User user : users) {
            if ("admin".equals(user.getUserType())) {
                adminUserCount++;
            } else {
                regularUserCount++;
            }
        }
        
        // Sort properties by price for display
        QuickSort.sortByPriceDesc(properties);
        
        // Take top 5 properties (if available)
        List<Property> topProperties = properties.size() > 5 ? 
                                      properties.subList(0, 5) : properties;
        
        // Set attributes for the dashboard
        request.setAttribute("userCount", users.size());
        request.setAttribute("regularUserCount", regularUserCount);
        request.setAttribute("adminUserCount", adminUserCount);
        request.setAttribute("propertyCount", properties.size());
        request.setAttribute("topProperties", topProperties);
        
        // Forward to dashboard JSP
        request.getRequestDispatcher("/WEB-INF/jsp/admin-dashboard.jsp").forward(request, response);
    }
    
    // Show user management page
    private void showUserManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all users
        List<User> users = FileManager.readAllUsers();
        
        // Set attributes
        request.setAttribute("users", users);
        
        // Forward to user management JSP
        request.getRequestDispatcher("/WEB-INF/jsp/admin-users.jsp").forward(request, response);
    }
    
    // Show edit user form
    private void showEditUserForm(HttpServletRequest request, HttpServletResponse response, String userId) throws ServletException, IOException {
        // Get user by ID
        User user = FileManager.findUserById(userId);
        
        if (user != null) {
            request.setAttribute("user", user);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/WEB-INF/jsp/admin-user-form.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    // Add a new user (admin or regular)
    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String userType = request.getParameter("userType");
        
        // Check if username already exists
        User existingUser = FileManager.findUserByUsername(username);
        if (existingUser != null) {
            request.setAttribute("errorMessage", "Username already exists");
            request.getRequestDispatcher("/WEB-INF/jsp/admin-user-form.jsp").forward(request, response);
            return;
        }
        
        // Generate user ID
        String userId = UUID.randomUUID().toString();
        
        // Create user object based on type
        User newUser;
        if ("admin".equals(userType)) {
            String adminLevel = request.getParameter("adminLevel");
            String department = request.getParameter("department");
            newUser = new AdminUser(userId, username, password, email, phoneNumber, adminLevel, department);
        } else {
            String address = request.getParameter("address");
            String preferences = request.getParameter("preferences");
            newUser = new RegularUser(userId, username, password, email, phoneNumber, address, preferences);
        }
        
        // Add user to file
        FileManager.addUser(newUser);
        
        // Redirect back to user management
        response.sendRedirect(request.getContextPath() + "/admin/users?success=added");
    }
    
    // Update an existing user
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String userType = request.getParameter("userType");
        
        // Get existing user
        User existingUser = FileManager.findUserById(userId);
        if (existingUser == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        // Check if username already exists for another user
        User usernameCheck = FileManager.findUserByUsername(username);
        if (usernameCheck != null && !usernameCheck.getUserId().equals(userId)) {
            request.setAttribute("errorMessage", "Username already exists for another user");
            request.setAttribute("user", existingUser);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/WEB-INF/jsp/admin-user-form.jsp").forward(request, response);
            return;
        }
        
        // Update user fields
        existingUser.setUsername(username);
        existingUser.setEmail(email);
        existingUser.setPhoneNumber(phoneNumber);
        
        // Update specific fields based on user type
        if (existingUser instanceof RegularUser) {
            RegularUser regularUser = (RegularUser) existingUser;
            String address = request.getParameter("address");
            String preferences = request.getParameter("preferences");
            
            regularUser.setAddress(address);
            regularUser.setPreferences(preferences);
        } else if (existingUser instanceof AdminUser) {
            AdminUser adminUser = (AdminUser) existingUser;
            String adminLevel = request.getParameter("adminLevel");
            String department = request.getParameter("department");
            
            adminUser.setAdminLevel(adminLevel);
            adminUser.setDepartment(department);
        }
        
        // Update user in file
        FileManager.updateUser(existingUser);
        
        // Redirect back to user management
        response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
    }
    
    // Delete a user
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user ID
        String userId = request.getParameter("userId");
        
        // Check if trying to delete self
        HttpSession session = request.getSession(false);
        String currentUserId = (String) session.getAttribute("userId");
        
        if (userId.equals(currentUserId)) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=selfDelete");
            return;
        }
        
        // Delete user from file
        FileManager.deleteUser(userId);
        
        // Redirect back to user management
        response.sendRedirect(request.getContextPath() + "/admin/users?success=deleted");
    }
}
