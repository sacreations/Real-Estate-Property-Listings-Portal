<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Real Estate Property Listings Portal</title>
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
        }
        
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 150px 0;
            text-align: center;
            position: relative;
        }
        
        .hero-content {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .hero-section h1 {
            font-weight: 700;
            margin-bottom: 20px;
            font-size: 3rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        
        .hero-section p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
        }
        
        .btn-primary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: #219653;
            border-color: #219653;
            transform: translateY(-2px);
        }
        
        .btn-outline-light {
            border-width: 2px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-light:hover {
            background-color: white;
            color: var(--primary-color) !important;
            transform: translateY(-2px);
        }
        
        .feature-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .feature-card .card-body {
            padding: 25px;
        }
        
        .feature-card .card-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .feature-card .card-text {
            color: #666;
            font-size: 0.95rem;
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin-bottom: 15px;
        }
        
        .section-title {
            position: relative;
            margin-bottom: 40px;
            padding-bottom: 15px;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            width: 50px;
            height: 3px;
            background-color: var(--secondary-color);
        }
        
        footer {
            background-color: var(--dark-color);
            padding: 50px 0 30px;
            color: #ffffff;
            margin-top: 60px;
            box-shadow: 0 -5px 15px rgba(0,0,0,0.1);
        }
        
        footer h5 {
            color: white;
            font-weight: 600;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }
        
        footer h5:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 2px;
            background-color: var(--secondary-color);
        }
        
        footer p {
            color: rgba(255,255,255,0.7);
        }
        
        .social-icons a {
            display: inline-block;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            color: white;
            text-align: center;
            line-height: 38px;
            margin-right: 10px;
            transition: all 0.3s ease;
        }
        
        .social-icons a:hover {
            background: var(--secondary-color);
            transform: translateY(-3px);
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1 class="display-4">Find Your Dream Property</h1>
                <p class="lead mb-4">Discover the perfect home with our comprehensive property listings platform</p>
                <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
                    <c:choose>
                        <c:when test="${empty sessionScope.userId}">
                            <!-- Fixed login and register links to use servlets instead of direct JSP access -->
                            <a href="${pageContext.request.contextPath}/auth?action=loginPage" class="btn btn-primary btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i> Login
                            </a>
                            <a href="${pageContext.request.contextPath}/auth?action=registerPage" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-user-plus me-2"></i> Register
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/properties" class="btn btn-primary btn-lg">
                                <i class="fas fa-home me-2"></i> View Properties
                            </a>
                            <c:if test="${sessionScope.userType eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-lg">
                                    <i class="fas fa-tachometer-alt me-2"></i> Admin Dashboard
                                </a>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container my-5 py-5">
        <div class="row">
            <div class="col-md-8 offset-md-2 text-center">
                <h2 class="section-title">Welcome to Our Real Estate Portal</h2>
                <p class="lead mb-4">
                    Browse through our extensive collection of properties, find your dream home, 
                    or list your property for sale or rent.
                </p>
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mt-4 mb-5">
                    <a href="${pageContext.request.contextPath}/properties" class="btn btn-primary btn-lg px-4 gap-3">
                        <i class="fas fa-search me-2"></i> Browse Properties
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Feature Section -->
    <div class="container py-5">
        <h3 class="text-center section-title mb-5">Our Features</h3>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center">
                        <i class="fas fa-search feature-icon"></i>
                        <h4 class="card-title">Advanced Search</h4>
                        <p class="card-text">Find properties that match your specific requirements using our powerful search features with multiple filtering options.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center">
                        <i class="fas fa-list-ul feature-icon"></i>
                        <h4 class="card-title">Detailed Listings</h4>
                        <p class="card-text">View comprehensive information about each property including high-quality images, specifications, and neighborhood details.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center">
                        <i class="fas fa-user-cog feature-icon"></i>
                        <h4 class="card-title">User Dashboard</h4>
                        <p class="card-text">Create an account to save your favorite properties, track listings, and manage your property portfolio.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="mt-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h5>Real Estate Portal</h5>
                    <p>Find your dream property with our comprehensive listing platform designed to make property hunting simple and efficient.</p>
                    <div class="social-icons mt-3">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/properties" class="text-decoration-none text-white-50">Properties</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/about" class="text-decoration-none text-white-50">About Us</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/contact" class="text-decoration-none text-white-50">Contact</a></li>
                        <li class="mb-2"><a href="#" class="text-decoration-none text-white-50">Terms of Service</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <h5>Property Types</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/properties?propertyType=apartment" class="text-decoration-none text-white-50">Apartments</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/properties?propertyType=house" class="text-decoration-none text-white-50">Houses</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/properties?propertyType=commercial" class="text-decoration-none text-white-50">Commercial</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/properties?propertyType=land" class="text-decoration-none text-white-50">Land</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Contact Us</h5>
                    <ul class="list-unstyled text-white-50">
                        <li class="mb-2"><i class="fas fa-map-marker-alt me-2"></i> 123 Real Estate St, Colombo</li>
                        <li class="mb-2"><i class="fas fa-phone me-2"></i> +94 11 234 5678</li>
                        <li class="mb-2"><i class="fas fa-envelope me-2"></i> info@realestate.com</li>
                    </ul>
                </div>
            </div>
            <div class="row mt-4 pt-4 border-top border-secondary">
                <div class="col-md-6 text-md-start text-center">
                    <p class="text-white-50 mb-0">&copy; 2025 Real Estate Portal. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end text-center">
                    <p class="text-white-50 mb-0">Designed with <i class="fas fa-heart text-danger"></i> for property seekers</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>