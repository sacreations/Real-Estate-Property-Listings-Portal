<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${property.title} - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .property-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        
        .feature-icon {
            width: 40px;
            height: 40px;
            background-color: #e9f7ef;
            color: #27ae60;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
        }
        
        .property-details {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
        
        .price-tag {
            font-size: 2rem;
            color: #27ae60;
            font-weight: 700;
        }
        
        .map-container {
            height: 300px;
            border-radius: 10px;
            overflow: hidden;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/properties">Real Estate Portal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/properties">Properties</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                    </li>
                    <c:if test="${sessionScope.userType eq 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                        </li>
                    </c:if>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    ${sessionScope.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=loginPage">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=registerPage">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container my-5">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/properties" class="text-decoration-none">Properties</a></li>
                <li class="breadcrumb-item active" aria-current="page">${property.title}</li>
            </ol>
        </nav>
        
        <div class="row">
            <!-- Property Image -->
            <div class="col-lg-8 mb-4">
                <img src="${empty property.imageUrl ? 'https://via.placeholder.com/800x400?text=No+Image+Available' : property.imageUrl}" 
                     alt="${property.title}" class="property-image shadow">
            </div>
            
            <!-- Property Quick Info -->
            <div class="col-lg-4 mb-4">
                <div class="property-details shadow h-100">
                    <h4 class="mb-3">${property.title}</h4>
                    <p class="text-muted mb-3">
                        <i class="bi bi-geo-alt"></i> ${property.location}
                    </p>
                    <div class="price-tag mb-3">
                        <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="$" />
                    </div>
                    <p class="badge bg-${property.status eq 'available' ? 'success' : 'danger'} mb-3">${property.status}</p>
                    
                    <hr>
                    
                    <div class="row mb-3">
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <span class="feature-icon">
                                    <i class="bi bi-building"></i>
                                </span>
                                <div>
                                    <small class="text-muted d-block">Type</small>
                                    ${property.propertyType}
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <span class="feature-icon">
                                    <i class="bi bi-rulers"></i>
                                </span>
                                <div>
                                    <small class="text-muted d-block">Area</small>
                                    ${property.area} sqft
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-4">
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <span class="feature-icon">
                                    <i class="bi bi-door-closed"></i>
                                </span>
                                <div>
                                    <small class="text-muted d-block">Bedrooms</small>
                                    ${property.bedrooms}
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <span class="feature-icon">
                                    <i class="bi bi-water"></i>
                                </span>
                                <div>
                                    <small class="text-muted d-block">Bathrooms</small>
                                    ${property.bathrooms}
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <a href="#contactSection" class="btn btn-primary">
                            <i class="bi bi-envelope"></i> Contact Agent
                        </a>
                        <c:if test="${sessionScope.userType eq 'admin'}">
                            <a href="${pageContext.request.contextPath}/properties/edit/${property.propertyId}" class="btn btn-warning">
                                <i class="bi bi-pencil"></i> Edit Property
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Property Description and Details -->
        <div class="row">
            <div class="col-lg-8">
                <div class="card shadow mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Description</h5>
                    </div>
                    <div class="card-body">
                        <p>${property.description}</p>
                    </div>
                </div>
                
                <div class="card shadow mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Property Features</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item"><i class="bi bi-check-circle-fill text-success me-2"></i> Property ID: ${property.propertyId}</li>
                                    <li class="list-group-item"><i class="bi bi-check-circle-fill text-success me-2"></i> Type: ${property.propertyType}</li>
                                    <li class="list-group-item"><i class="bi bi-check-circle-fill text-success me-2"></i> Status: ${property.status}</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item"><i class="bi bi-check-circle-fill text-success me-2"></i> Area: ${property.area} sqft</li>
                                    <li class="list-group-item"><i class="bi bi-check-circle-fill text-success me-2"></i> Bedrooms: ${property.bedrooms}</li>
                                    <li class="list-group-item"><i class="bi bi-check-circle-fill text-success me-2"></i> Bathrooms: ${property.bathrooms}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Location Map -->
                <div class="card shadow">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Location</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="map-container">
                            <!-- Replace with an actual map of the property location if available -->
                            <iframe width="100%" height="100%" frameborder="0" style="border:0"
                                src="https://www.google.com/maps/embed/v1/place?q=${property.location}&key=YOUR_API_KEY" allowfullscreen>
                            </iframe>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Contact Agent Section -->
            <div class="col-lg-4" id="contactSection">
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Contact Agent</h5>
                    </div>
                    <div class="card-body">
                        <form>
                            <div class="mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" placeholder="Your name">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" placeholder="Your email">
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="tel" class="form-control" id="phone" placeholder="Your phone number">
                            </div>
                            <div class="mb-3">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" rows="3" placeholder="I'm interested in this property..."></textarea>
                            </div>
                            <div class="d-grid">
                                <button type="button" class="btn btn-primary" onclick="showEnquirySuccess()">
                                    Send Inquiry
                                </button>
                                <div id="enquirySuccessMessage" class="alert alert-success mt-3" style="display: none;">
                                    Your inquiry has been sent! An agent will contact you soon.
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Agent Info Card (Sample) -->
                <div class="card shadow">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Property Agent</h5>
                    </div>
                    <div class="card-body text-center">
                        <img src="https://via.placeholder.com/150" class="rounded-circle mb-3" alt="Agent" width="100">
                        <h5>John Smith</h5>
                        <p class="text-muted">Senior Property Agent</p>
                        <hr>
                        <div class="d-flex justify-content-center">
                            <a href="tel:+94112345678" class="btn btn-outline-secondary mx-1">
                                <i class="bi bi-telephone"></i>
                            </a>
                            <a href="mailto:agent@realestate.com" class="btn btn-outline-secondary mx-1">
                                <i class="bi bi-envelope"></i>
                            </a>
                            <a href="#" class="btn btn-outline-secondary mx-1">
                                <i class="bi bi-whatsapp"></i>
                            </a>
                        </div>
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
    <script>
        function showEnquirySuccess() {
            document.getElementById('enquirySuccessMessage').style.display = 'block';
        }
    </script>
</body>
</html>
