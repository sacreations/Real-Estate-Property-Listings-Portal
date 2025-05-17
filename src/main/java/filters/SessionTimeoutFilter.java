package filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter to handle session timeout and redirect to session-timeout page
 */
public class SessionTimeoutFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Skip filter for public resources
        String requestURI = httpRequest.getRequestURI();
        if (isPublicResource(requestURI, httpRequest.getContextPath())) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if session exists and is valid for protected resources
        HttpSession session = httpRequest.getSession(false);
        
        // If no session or session expired and trying to access protected resource
        if (requiresAuthentication(requestURI, httpRequest.getContextPath()) && 
            (session == null || session.getAttribute("userId") == null)) {
            
            // Redirect to session timeout page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/WEB-INF/jsp/session-timeout.jsp");
            return;
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
    
    // Check if the resource is public (doesn't require authentication)
    private boolean isPublicResource(String uri, String contextPath) {
        return uri.equals(contextPath + "/") || 
               uri.equals(contextPath + "/index.jsp") ||
               uri.startsWith(contextPath + "/auth") ||
               uri.contains("/css/") || 
               uri.contains("/js/") || 
               uri.contains("/images/");
    }
    
    // Check if the resource requires authentication
    private boolean requiresAuthentication(String uri, String contextPath) {
        return uri.startsWith(contextPath + "/admin/") || 
               uri.startsWith(contextPath + "/user/") ||
               uri.contains("/properties/add") ||
               uri.contains("/properties/edit");
    }
}
