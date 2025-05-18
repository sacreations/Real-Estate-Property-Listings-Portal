<!-- filepath: d:\SLIIT\OOP\finalproject\src\main\webapp\index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Real Estate Property Listings Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    
    <!-- Hero Section -->
    <div class="hero-section mb-5">
        <div class="container">
            <h1 class="display-4 fw-bold">Real Estate Property Listings Portal</h1>
            <p class="lead">Find your dream property with our comprehensive listing platform</p>
            <div class="d-flex justify-content-center mt-4">
                <c:choose>
                    <c:when test="${empty sessionScope.userId}">
                        <a href="${pageContext.request.contextPath}/WEB-INF/jsp/login.jsp" class="btn btn-primary btn-lg mx-2">Login</a>
                        <a href="${pageContext.request.contextPath}/WEB-INF/jsp/register.jsp" class="btn btn-outline-light btn-lg mx-2">Register</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/properties" class="btn btn-primary btn-lg mx-2">View Properties</a>
                        <c:if test="${sessionScope.userType eq 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-lg mx-2">Admin Dashboard</a>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-md-8 offset-md-2 text-center">
                <h2>Welcome to Our Real Estate Portal</h2>
                <p class="lead">
                    Browse through our extensive collection of properties, find your dream home, 
                    or list your property for sale or rent.
                </p>
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mt-4">
                    <a href="${pageContext.request.contextPath}/properties" class="btn btn-primary btn-lg px-4 gap-3">Browse Properties</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Feature Section -->
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <h4 class="card-title">Search Properties</h4>
                        <p class="card-text">Find properties that match your requirements using our advanced search features.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <h4 class="card-title">Detailed Listings</h4>
                        <p class="card-text">View comprehensive information about each property including images and specifications.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <h4 class="card-title">User Management</h4>
                        <p class="card-text">Create an account to save your favorite properties and manage your listings.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Real Estate Property Listings Portal</h5>
                    <p>Find your dream property with our comprehensive listing platform</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2025 Real Estate Portal. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>