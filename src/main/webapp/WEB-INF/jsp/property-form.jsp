<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Add'} Property - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .image-preview {
            max-width: 100%;
            height: 200px;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/properties">Properties</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                    </li>
                    <c:if test="${sessionScope.userType eq 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
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
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">${isEdit ? 'Edit' : 'Add New'} Property</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/properties" method="post">
                            <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
                            <c:if test="${isEdit}">
                                <input type="hidden" name="propertyId" value="${property.propertyId}">
                            </c:if>
                            
                            <!-- Basic Information -->
                            <h5 class="mb-3">Basic Information</h5>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="title" class="form-label">Property Title <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="title" name="title" 
                                           value="${property.title}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" class="form-control" id="price" name="price" 
                                               value="${property.price}" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3">${property.description}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="location" class="form-label">Location <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="location" name="location" 
                                       value="${property.location}" required>
                            </div>
                            
                            <!-- Property Details -->
                            <h5 class="mb-3 mt-4">Property Details</h5>
                            <div class="row mb-3">
                                <div class="col-md-3">
                                    <label for="propertyType" class="form-label">Property Type</label>
                                    <select class="form-select" id="propertyType" name="propertyType">
                                        <option value="apartment" ${property.propertyType eq 'apartment' ? 'selected' : ''}>Apartment</option>
                                        <option value="house" ${property.propertyType eq 'house' ? 'selected' : ''}>House</option>
                                        <option value="land" ${property.propertyType eq 'land' ? 'selected' : ''}>Land</option>
                                        <option value="commercial" ${property.propertyType eq 'commercial' ? 'selected' : ''}>Commercial</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="available" ${property.status eq 'available' ? 'selected' : ''}>Available</option>
                                        <option value="sold" ${property.status eq 'sold' ? 'selected' : ''}>Sold</option>
                                        <option value="pending" ${property.status eq 'pending' ? 'selected' : ''}>Pending</option>
                                        <option value="rented" ${property.status eq 'rented' ? 'selected' : ''}>Rented</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="bedrooms" class="form-label">Bedrooms</label>
                                    <input type="number" class="form-control" id="bedrooms" name="bedrooms" 
                                           value="${property.bedrooms}" min="0">
                                </div>
                                <div class="col-md-3">
                                    <label for="bathrooms" class="form-label">Bathrooms</label>
                                    <input type="number" class="form-control" id="bathrooms" name="bathrooms" 
                                           value="${property.bathrooms}" min="0">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="area" class="form-label">Area (sqft)</label>
                                <input type="number" step="0.01" class="form-control" id="area" name="area" 
                                       value="${property.area}" min="0">
                            </div>
                            
                            <!-- Property Image -->
                            <h5 class="mb-3 mt-4">Property Image</h5>
                            <div class="row mb-4">
                                <div class="col-md-8">
                                    <label for="imageUrl" class="form-label">Image URL</label>
                                    <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                                           value="${property.imageUrl}" onchange="updatePreview()">
                                    <small class="form-text text-muted">Enter a URL for the property image</small>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Image Preview</label>
                                    <div class="image-preview" id="imagePreview">
                                        <c:choose>
                                            <c:when test="${not empty property.imageUrl}">
                                                <img src="${property.imageUrl}" alt="Property Preview">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">No image available</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Form Buttons -->
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/properties" class="btn btn-secondary">
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    ${isEdit ? 'Update' : 'Add'} Property
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updatePreview() {
            const imageUrl = document.getElementById('imageUrl').value;
            const imagePreview = document.getElementById('imagePreview');
            
            if (imageUrl) {
                imagePreview.innerHTML = `<img src="${imageUrl}" alt="Property Preview">`;
            } else {
                imagePreview.innerHTML = `<span class="text-muted">No image available</span>`;
            }
        }
    </script>
</body>
</html>
