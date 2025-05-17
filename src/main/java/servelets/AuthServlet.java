package servlets;

import models.User;
import models.RegularUser;
import utils.FileManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

/**
 * Servlet for handling authentication operations (login, register, logout)
 */
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            // Handle logout action
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            
        } else if ("loginPage".equals(action)) {
            // Show login page
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            
        } else if ("registerPage".equals(action)) {
            // Show register page
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            
        } else if ("sessionTimeout".equals(action)) {
            // Show session timeout page
            request.getRequestDispatcher("/WEB-INF/jsp/session-timeout.jsp").forward(request, response);
            
        } else {
            // Default - redirect to home page
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegistration(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            return;
        }
        
        // Check credentials
        User user = FileManager.findUserByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("userType", user.getUserType());
            
            // Redirect based on user type
            if ("admin".equals(user.getUserType())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/properties");
            }
        } else {
            // Invalid credentials
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }
    
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get registration parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        
        // Validate input
        if (username == null || username.isEmpty() || email == null || email.isEmpty() || 
            password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            request.setAttribute("errorMessage", "All required fields must be filled");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords don't match");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        User existingUser = FileManager.findUserByUsername(username);
        if (existingUser != null) {
            request.setAttribute("errorMessage", "Username already exists");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user (regular user by default)
        String userId = UUID.randomUUID().toString();
        User newUser = new RegularUser(userId, username, password, email, phoneNumber, address, "");
        
        // Save user to file
        FileManager.addUser(newUser);
        
        // Redirect to login with success message
        request.setAttribute("successMessage", "Registration successful! Please login.");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }
}
