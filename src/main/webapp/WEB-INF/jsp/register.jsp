<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #27ae60;
            --accent-color: #e67e22;
            --light-color: #f8f9fa;
            --dark-color: #2c3e50;
        }
        
        body {
            background-color: var(--light-color);
            font-family: 'Poppins', sans-serif;
            color: #333;
            background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 40px 0;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        
        .card-header {
            background-color: var(--secondary-color);
            padding: 25px 15px;
            border-bottom: none;
        }
        
        .card-header h3, .card-header h4 {
            font-weight: 700;
        }
        
        .card-body {
            padding: 30px;
        }
        
        .btn-primary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: #219653;
            border-color: #219653;
            transform: translateY(-2px);
        }
        
        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 16px;
            border: 1px solid #ddd;
        }
        
        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.3);
            border-color: var(--secondary-color);
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
        }
        
        .card-footer {
            background-color: #f8f9fa;
            border-top: none;
            padding: 20px 30px;
        }
        
        .card-footer p {
            margin-bottom: 0;
        }
        
        .card-footer a {
            color: var(--secondary-color);
            font-weight: 600;
            text-decoration: none;
        }
        
        .card-footer a:hover {
            text-decoration: underline;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Real Estate Portal</h3>
                        <h4>Create Account</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/auth" method="post">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                                    <div class="input-group mb-3">
                                        <span class="input-group-text bg-white"><i class="fas fa-user text-secondary"></i></span>
                                        <input type="text" class="form-control border-start-0" id="username" name="username" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                    <div class="input-group mb-3">
                                        <span class="input-group-text bg-white"><i class="fas fa-envelope text-secondary"></i></span>
                                        <input type="email" class="form-control border-start-0" id="email" name="email" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                                    <div class="input-group mb-3">
                                        <span class="input-group-text bg-white"><i class="fas fa-lock text-secondary"></i></span>
                                        <input type="password" class="form-control border-start-0" id="password" name="password" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                    <div class="input-group mb-3">
                                        <span class="input-group-text bg-white"><i class="fas fa-lock text-secondary"></i></span>
                                        <input type="password" class="form-control border-start-0" id="confirmPassword" name="confirmPassword" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="phoneNumber" class="form-label">Phone Number <span class="text-danger">*</span></label>
                                    <div class="input-group mb-3">
                                        <span class="input-group-text bg-white"><i class="fas fa-phone text-secondary"></i></span>
                                        <input type="text" class="form-control border-start-0" id="phoneNumber" name="phoneNumber" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="address" class="form-label">Address</label>
                                    <div class="input-group mb-3">
                                        <span class="input-group-text bg-white"><i class="fas fa-map-marker-alt text-secondary"></i></span>
                                        <input type="text" class="form-control border-start-0" id="address" name="address">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                <label class="form-check-label" for="termsCheck">
                                    I agree to the <a href="#" class="text-decoration-none">Terms of Service</a> and <a href="#" class="text-decoration-none">Privacy Policy</a>
                                </label>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-user-plus me-2"></i> Register
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/auth?action=loginPage">Login</a></p>
                        <p class="mt-3 small"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home me-2"></i>Back to Home</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
