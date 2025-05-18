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
    <style>
        .property-card {
            transition: transform 0.3s;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .property-img {
            height: 200px;
            object-fit: cover;
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2>Property Listings</h2>
            </div>
            <c:if test="${sessionScope.userType eq 'admin'}">
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/properties/add" class="btn btn-success">
                        <i class="bi bi-plus-circle me-2"></i>Add New Property
                    </a>
                </div>
            </c:if>
        </div>
        
        <!-- Search and Filter Form -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Search & Filter Properties</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/properties" method="post">
                    <input type="hidden" name="action" value="search">
                    
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label for="minPrice" class="form-label">Min Price</label>
                            <input type="number" class="form-control" id="minPrice" name="minPrice" placeholder="Min Price" value="${param.minPrice}">
                        </div>
                        <div class="col-md-3">
                            <label for="maxPrice" class="form-label">Max Price</label>
                            <input type="number" class="form-control" id="maxPrice" name="maxPrice" placeholder="Max Price" value="${param.maxPrice}">
                        </div>
                        <div class="col-md-3">
                            <label for="location" class="form-label">Location</label>
                            <input type="text" class="form-control" id="location" name="location" placeholder="Location" value="${param.location}">
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
                                <button type="submit" class="btn btn-primary">Apply Filters</button>
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
                        <h4>No properties found matching your criteria</h4>
                        <p>Try adjusting your search filters</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="property" items="${properties}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card property-card h-100">
                                <img src="${empty property.imageUrl ? 'https://via.placeholder.com/300x200?text=No+Image' : property.imageUrl}" 
                                     class="card-img-top property-img" alt="${property.title}">
                                <div class="card-body">
                                    <h5 class="card-title">${property.title}</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">${property.location}</h6>
                                    <p class="card-text text-primary fw-bold">
                                        <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="$" />
                                    </p>
                                    <div class="d-flex justify-content-between">
                                        <span><i class="bi bi-building"></i> ${property.propertyType}</span>
                                        <span><i class="bi bi-rulers"></i> ${property.area} sqft</span>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <span><i class="bi bi-door-closed"></i> ${property.bedrooms} BR</span>
                                        <span><i class="bi bi-water"></i> ${property.bathrooms} BA</span>
                                        <span class="badge bg-${property.status eq 'available' ? 'success' : 'danger'}">${property.status}</span>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/properties/view/${property.propertyId}" class="btn btn-sm btn-primary">
                                            View Details
                                        </a>
                                        <c:if test="${sessionScope.userType eq 'admin'}">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/properties/edit/${property.propertyId}" class="btn btn-sm btn-warning">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </a>
                                                <button type="button" class="btn btn-sm btn-danger" 
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
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="deleteModalBody">
                    Are you sure you want to delete this property?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/properties" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" id="deletePropertyId" name="propertyId" value="">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
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
