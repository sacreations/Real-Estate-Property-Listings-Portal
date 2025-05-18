package filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * This filter checks if the user's session has expired
 * It redirects to the timeout page for protected pages that need a login
 */
public class SessionTimeoutFilter implements Filter {

    // Initialize filter
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nothing to initialize
    }

    // Main filter method that runs on each request
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get the page being requested
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Skip check for public pages (login, register, home page, etc.)
        if (isPublicPage(requestURI, contextPath)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Get the user's session if it exists
        HttpSession session = httpRequest.getSession(false);
        
        // Check if session exists and is valid
        if (needsLogin(requestURI, contextPath) && 
            (session == null || session.getAttribute("userId") == null)) {
            
            // Redirect to session timeout page via the AuthServlet
            httpResponse.sendRedirect(contextPath + "/auth?action=sessionTimeout");
            return;
        }
        
        // Continue to the requested page
        chain.doFilter(request, response);
    }

    // Clean up when filter is destroyed
    @Override
    public void destroy() {
        // Nothing to clean up
    }
    
    // Check if this is a public page that doesn't need login
    private boolean isPublicPage(String uri, String contextPath) {
        return uri.equals(contextPath + "/") || 
               uri.equals(contextPath + "/index.jsp") ||
               uri.startsWith(contextPath + "/auth") ||
               uri.contains("/css/") || 
               uri.contains("/js/") || 
               uri.contains("/images/") ||
               uri.equals(contextPath + "/properties") ||  // Allow viewing property listings
               uri.startsWith(contextPath + "/properties/view"); // Allow viewing individual properties
    }
    
    // Check if this page requires being logged in
    private boolean needsLogin(String uri, String contextPath) {
        return uri.startsWith(contextPath + "/admin/") || 
               uri.startsWith(contextPath + "/user/") ||
               uri.contains("/properties/add") ||
               uri.contains("/properties/edit");
    }
}
