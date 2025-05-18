<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/properties">Properties</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
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
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <h2>Admin Dashboard</h2>
        
        <!-- Stats Cards -->
        <div class="row mt-4">
            <div class="col-md-3 mb-4">
                <div class="card bg-primary text-white h-100">
                    <div class="card-body py-5">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="fw-bold mb-0">${userCount}</h4>
                                <p class="mb-0">Total Users</p>
                            </div>
                            <i class="bi bi-people fs-1"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex">
                        <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none">
                            View Users <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <div class="card bg-success text-white h-100">
                    <div class="card-body py-5">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="fw-bold mb-0">${propertyCount}</h4>
                                <p class="mb-0">Total Properties</p>
                            </div>
                            <i class="bi bi-house fs-1"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex">
                        <a href="${pageContext.request.contextPath}/properties" class="text-white text-decoration-none">
                            View Properties <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <div class="card bg-info text-white h-100">
                    <div class="card-body py-5">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="fw-bold mb-0">${regularUserCount}</h4>
                                <p class="mb-0">Regular Users</p>
                            </div>
                            <i class="bi bi-person fs-1"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex">
                        <span class="text-white">
                            Regular Users Count
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <div class="card bg-warning text-white h-100">
                    <div class="card-body py-5">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="fw-bold mb-0">${adminUserCount}</h4>
                                <p class="mb-0">Admin Users</p>
                            </div>
                            <i class="bi bi-person-badge fs-1"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex">
                        <span class="text-white">
                            Admin Users Count
                        </span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row mt-2">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/properties/add" class="btn btn-success w-100 mb-2">
                                    <i class="bi bi-plus-circle me-2"></i>Add Property
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/admin/users/add" class="btn btn-info w-100 mb-2">
                                    <i class="bi bi-person-plus me-2"></i>Add User
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-warning w-100">
                                    <i class="bi bi-people me-2"></i>Manage Users
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/properties" class="btn btn-primary w-100">
                                    <i class="bi bi-houses me-2"></i>View Properties
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Top Properties</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Location</th>
                                        <th>Price</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="property" items="${topProperties}">
                                        <tr>
                                            <td>${property.title}</td>
                                            <td>${property.location}</td>
                                            <td>$${property.price}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/properties/view/${property.propertyId}" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/properties/edit/${property.propertyId}" class="btn btn-sm btn-warning">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
