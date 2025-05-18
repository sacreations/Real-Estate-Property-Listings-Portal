package servlets;

import models.User;
import models.RegularUser;
import models.AdminUser;
import utils.FileManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling user profile operations
 */
public class UserServlet extends HttpServlet {
    
    // Handle GET requests (e.g., display profile)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/profile")) {
            // Display user profile
            String userId = (String) session.getAttribute("userId");
            User user = FileManager.findUserById(userId);
            
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    // Handle POST requests (e.g., update profile)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String userId = (String) session.getAttribute("userId");
        
        if ("updateProfile".equals(action)) {
            updateUserProfile(request, response, userId);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, userId);
        } else {
            response.sendRedirect(request.getContextPath() + "/user/profile");
        }
    }
    
    // Update user profile
    private void updateUserProfile(HttpServletRequest request, HttpServletResponse response, String userId) throws ServletException, IOException {
        // Get current user
        User currentUser = FileManager.findUserById(userId);
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Update common fields
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        
        currentUser.setEmail(email);
        currentUser.setPhoneNumber(phoneNumber);
        
        // Update specific fields based on user type
        if (currentUser instanceof RegularUser) {
            RegularUser regularUser = (RegularUser) currentUser;
            String address = request.getParameter("address");
            String preferences = request.getParameter("preferences");
            
            regularUser.setAddress(address);
            regularUser.setPreferences(preferences);
        } else if (currentUser instanceof AdminUser) {
            AdminUser adminUser = (AdminUser) currentUser;
            String department = request.getParameter("department");
            
            adminUser.setDepartment(department);
        }
        
        // Update user in file
        FileManager.updateUser(currentUser);
        
        // Redirect back to profile with success message
        request.setAttribute("successMessage", "Profile updated successfully");
        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }
    
    // Change password
    private void changePassword(HttpServletRequest request, HttpServletResponse response, String userId) throws ServletException, IOException {
        // Get current user
        User currentUser = FileManager.findUserById(userId);
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate current password
        if (!currentUser.getPassword().equals(currentPassword)) {
            request.setAttribute("errorMessage", "Current password is incorrect");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
            return;
        }
        
        // Validate new password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
            return;
        }
        
        // Update password
        currentUser.setPassword(newPassword);
        
        // Update user in file
        FileManager.updateUser(currentUser);
        
        // Redirect back to profile with success message
        request.setAttribute("successMessage", "Password changed successfully");
        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }
}
