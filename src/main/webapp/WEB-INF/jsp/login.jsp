<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/real-estate-theme.css">
    <style>
        body {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), 
                        url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
        }
        
        .login-header {
            background: var(--gradient-primary);
            padding: 30px;
            text-align: center;
        }
        
        .login-header h3 {
            color: white;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .login-header h4 {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            font-size: 1.2rem;
        }
        
        .login-body {
            padding: 35px;
        }
        
        .input-group-text {
            background-color: transparent;
            border-right: none;
        }
        
        .form-control {
            border-left: none;
            padding-left: 0;
        }
        
        .form-control:focus {
            box-shadow: none;
        }
        
        .input-group:focus-within {
            box-shadow: 0 0 0 .25rem rgba(56, 178, 172, 0.25);
            border-radius: 0.375rem;
        }
        
        .login-footer {
            background-color: #f8f9fa;
            padding: 20px 35px;
            text-align: center;
        }
        
        .login-btn {
            background: var(--gradient-primary);
            border: none;
            padding: 12px;
            font-weight: 600;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(56, 178, 172, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="login-card animate__animated animate__fadeIn">
                    <div class="login-header">
                        <h3>Real Estate Portal</h3>
                        <h4>Welcome Back</h4>
                    </div>
                    <div class="login-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i> ${successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/auth" method="post">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="mb-4">
                                <label for="username" class="form-label">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user text-muted"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" required placeholder="Enter your username">
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
                                </div>
                            </div>
                            
                            <div class="mb-4 d-flex justify-content-between align-items-center">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="rememberMe">
                                    <label class="form-check-label" for="rememberMe">Remember me</label>
                                </div>
                                <a href="#" class="text-secondary small text-decoration-none">Forgot password?</a>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn login-btn">
                                    <i class="fas fa-sign-in-alt me-2"></i> Login
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="login-footer">
                        <p class="mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/auth?action=registerPage" class="text-decoration-none fw-medium">Register Now</a></p>
                        <p class="mt-3 small mb-0"><a href="${pageContext.request.contextPath}/" class="text-decoration-none"><i class="fas fa-home me-2"></i>Back to Home</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
