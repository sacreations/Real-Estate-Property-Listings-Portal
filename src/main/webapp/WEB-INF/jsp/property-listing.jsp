<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Listings - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/real-estate-theme.css">
    <style>
        .property-card {
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .property-img-container {
            position: relative;
            overflow: hidden;
            height: 200px;
        }
        
        .property-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .property-card:hover .property-img {
            transform: scale(1.1);
        }
        
        .property-status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 1;
        }
        
        .property-type-badge {
            position: absolute;
            bottom: 15px;
            left: 15px;
            z-index: 1;
            background: rgba(255, 255, 255, 0.9);
            color: var(--primary-color);
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .property-details {
            padding: 20px;
            border-top: none;
        }
        
        .property-title {
            font-weight: 600;
            margin-bottom: 5px;
            display: block;
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .property-title:hover {
            color: var(--secondary-color);
        }
        
        .property-location {
            color: #718096;
            font-size: 0.9rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        
        .property-price {
            font-weight: 700;
            color: var(--secondary-color);
            font-size: 1.25rem;
            margin-bottom: 15px;
        }
        
        .property-features {
            display: flex;
            justify-content: space-between;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
            color: #718096;
            font-size: 0.85rem;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
        }
        
        .feature-icon {
            margin-right: 5px;
            color: var(--primary-color);
        }
        
        .search-filters {
            background: white;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
            margin-bottom: 30px;
            padding: 25px;
        }
        
        .search-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .filter-title {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/properties">
                <i class="bi bi-building me-2"></i>Real Estate Portal
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/properties">Properties</a>
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
                                    <i class="bi bi-person-circle me-1"></i> ${sessionScope.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                        <i class="bi bi-person me-2"></i>Profile
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=loginPage">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=registerPage">
                                    <i class="bi bi-person-plus me-1"></i> Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="row align-items-center mb-4">
            <div class="col-md-8">
                <h1 class="h2 mb-0">Property Listings</h1>
                <p class="text-muted">Find your perfect property among our extensive collection</p>
            </div>
            <c:if test="${sessionScope.userType eq 'admin'}">
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/properties/add" class="btn btn-primary">
                        <i class="bi bi-plus-circle me-2"></i>Add New Property
                    </a>
                </div>
            </c:if>
        </div>
        
        <!-- Search and Filter Form -->
        <div class="search-filters animate__animated animate__fadeIn">
            <div class="search-header d-flex justify-content-between align-items-center">
                <h5 class="filter-title">
                    <i class="bi bi-search me-2"></i>Search & Filter Properties
                </h5>
                <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#filterCollapse">
                    <i class="bi bi-sliders"></i> Toggle Filters
                </button>
            </div>
            <div class="collapse show" id="filterCollapse">
                <form action="${pageContext.request.contextPath}/properties" method="post">
                    <input type="hidden" name="action" value="search">
                    
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label for="minPrice" class="form-label">Min Price</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="minPrice" name="minPrice" placeholder="Min Price" value="${param.minPrice}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="maxPrice" class="form-label">Max Price</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="maxPrice" name="maxPrice" placeholder="Max Price" value="${param.maxPrice}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="location" class="form-label">Location</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                <input type="text" class="form-control" id="location" name="location" placeholder="City, State" value="${param.location}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="propertyType" class="form-label">Property Type</label>
                            <select class="form-select" id="propertyType" name="propertyType">
                                <option value="">All Types</option>
                                <option value="apartment" ${param.propertyType eq 'apartment' ? 'selected' : ''}>Apartment</option>
                                <option value="house" ${param.propertyType eq 'house' ? 'selected' : ''}>House</option>
                                <option value="land" ${param.propertyType eq 'land' ? 'selected' : ''}>Land</option>
                                <option value="commercial" ${param.propertyType eq 'commercial' ? 'selected' : ''}>Commercial</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="sortBy" class="form-label">Sort By</label>
                            <select class="form-select" id="sortBy" name="sortBy">
                                <option value="price" ${sortBy eq 'price' ? 'selected' : ''}>Price</option>
                                <option value="bedrooms" ${sortBy eq 'bedrooms' ? 'selected' : ''}>Bedrooms</option>
                                <option value="area" ${sortBy eq 'area' ? 'selected' : ''}>Area</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="sortOrder" class="form-label">Sort Order</label>
                            <select class="form-select" id="sortOrder" name="sortOrder">
                                <option value="asc" ${sortOrder eq 'asc' ? 'selected' : ''}>Ascending</option>
                                <option value="desc" ${sortOrder eq 'desc' ? 'selected' : ''}>Descending</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">&nbsp;</label>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-filter-circle me-2"></i>Apply Filters
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Property Listings -->
        <div class="row">
            <c:choose>
                <c:when test="${empty properties}">
                    <div class="col-12 text-center py-5">
                        <div class="py-5">
                            <i class="bi bi-house-slash text-muted" style="font-size: 4rem;"></i>
                            <h4 class="mt-3">No properties found matching your criteria</h4>
                            <p class="text-muted">Try adjusting your search filters</p>
                            <a href="${pageContext.request.contextPath}/properties" class="btn btn-outline-primary mt-3">
                                <i class="bi bi-arrow-counterclockwise me-2"></i>Reset Filters
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="property" items="${properties}" varStatus="status">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card property-card animate__animated animate__fadeIn" style="animation-delay: ${status.index * 0.1}s">
                                <div class="property-img-container">
                                    <img src="${empty property.imageUrl ? 'https://via.placeholder.com/300x200?text=No+Image' : property.imageUrl}" 
                                         class="property-img" alt="${property.title}">
                                    <div class="property-status-badge">
                                        <span class="badge bg-${property.status eq 'available' ? 'success' : property.status eq 'pending' ? 'warning' : 'danger'}">${property.status}</span>
                                    </div>
                                    <div class="property-type-badge">
                                        <i class="bi ${property.propertyType eq 'apartment' ? 'bi-building' : property.propertyType eq 'house' ? 'bi-house' : property.propertyType eq 'land' ? 'bi-map' : 'bi-shop'}"></i> ${property.propertyType}
                                    </div>
                                </div>
                                <div class="property-details">
                                    <a href="${pageContext.request.contextPath}/properties/view/${property.propertyId}" class="property-title h5">${property.title}</a>
                                    <div class="property-location">
                                        <i class="bi bi-geo-alt me-1"></i> ${property.location}
                                    </div>
                                    <div class="property-price">
                                        <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="$" />
                                    </div>
                                    <div class="property-features">
                                        <div class="feature-item">
                                            <i class="bi bi-rulers feature-icon"></i>
                                            <span>${property.area} sqft</span>
                                        </div>
                                        <div class="feature-item">
                                            <i class="bi bi-door-closed feature-icon"></i>
                                            <span>${property.bedrooms} BD</span>
                                        </div>
                                        <div class="feature-item">
                                            <i class="bi bi-water feature-icon"></i>
                                            <span>${property.bathrooms} BA</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-white">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <a href="${pageContext.request.contextPath}/properties/view/${property.propertyId}" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-info-circle me-1"></i> Details
                                        </a>
                                        <c:if test="${sessionScope.userType eq 'admin'}">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/properties/edit/${property.propertyId}" class="btn btn-sm btn-outline-secondary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        onclick="confirmDelete('${property.propertyId}', '${property.title}')">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="bi bi-exclamation-triangle me-2"></i>Confirm Deletion
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="deleteModalBody">
                    Are you sure you want to delete this property?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="bi bi-x-circle me-2"></i>Cancel
                    </button>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/properties" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" id="deletePropertyId" name="propertyId" value="">
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-trash me-2"></i>Delete
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer mt-5 py-4">
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
        function confirmDelete(propertyId, propertyTitle) {
            document.getElementById('deletePropertyId').value = propertyId;
            document.getElementById('deleteModalBody').innerText = 'Are you sure you want to delete "' + propertyTitle + '"?';
            
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            deleteModal.show();
        }
    </script>
</body>
</html>
