<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Add'} User - Admin Dashboard</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
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
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">${isEdit ? 'Edit' : 'Add New'} User</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/admin" method="post">
                            <input type="hidden" name="action" value="${isEdit ? 'updateUser' : 'addUser'}">
                            <c:if test="${isEdit}">
                                <input type="hidden" name="userId" value="${user.userId}">
                            </c:if>
                            
                            <!-- Basic Information -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="${user.username}" required ${isEdit ? 'readonly' : ''}>
                                    <c:if test="${isEdit}">
                                        <small class="form-text text-muted">Username cannot be changed</small>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${user.email}" required>
                                </div>
                            </div>
                            
                            <c:if test="${not isEdit}">
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" 
                                       value="${user.phoneNumber}">
                            </div>
                            
                            <!-- User Type Selection -->
                            <div class="mb-3">
                                <label for="userType" class="form-label">User Type <span class="text-danger">*</span></label>
                                <select class="form-select" id="userType" name="userType" onchange="toggleUserTypeFields()" required>
                                    <option value="regular" ${user.userType eq 'regular' ? 'selected' : ''}>Regular User</option>
                                    <option value="admin" ${user.userType eq 'admin' ? 'selected' : ''}>Admin User</option>
                                </select>
                            </div>
                            
                            <!-- Regular User Fields -->
                            <div id="regularUserFields" style="display: ${user.userType eq 'regular' || empty user.userType ? 'block' : 'none'};">
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" 
                                           value="${user.userType eq 'regular' ? user.address : ''}">
                                </div>
                                <div class="mb-3">
                                    <label for="preferences" class="form-label">Preferences (comma separated)</label>
                                    <input type="text" class="form-control" id="preferences" name="preferences" 
                                           value="${user.userType eq 'regular' ? user.preferences : ''}" 
                                           placeholder="e.g., apartment, beachfront, modern">
                                </div>
                            </div>
                            
                            <!-- Admin User Fields -->
                            <div id="adminUserFields" style="display: ${user.userType eq 'admin' ? 'block' : 'none'};">
                                <div class="mb-3">
                                    <label for="adminLevel" class="form-label">Admin Level</label>
                                    <select class="form-select" id="adminLevel" name="adminLevel">
                                        <option value="super" ${user.userType eq 'admin' && user.adminLevel eq 'super' ? 'selected' : ''}>Super Admin</option>
                                        <option value="property" ${user.userType eq 'admin' && user.adminLevel eq 'property' ? 'selected' : ''}>Property Admin</option>
                                        <option value="support" ${user.userType eq 'admin' && user.adminLevel eq 'support' ? 'selected' : ''}>Support Admin</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="department" class="form-label">Department</label>
                                    <input type="text" class="form-control" id="department" name="department" 
                                           value="${user.userType eq 'admin' ? user.department : ''}">
                                </div>
                            </div>
                            
                            <!-- Form Buttons -->
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    ${isEdit ? 'Update' : 'Add'} User
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
        function toggleUserTypeFields() {
            const userType = document.getElementById('userType').value;
            const regularUserFields = document.getElementById('regularUserFields');
            const adminUserFields = document.getElementById('adminUserFields');
            
            if (userType === 'regular') {
                regularUserFields.style.display = 'block';
                adminUserFields.style.display = 'none';
            } else {
                regularUserFields.style.display = 'none';
                adminUserFields.style.display = 'block';
            }
        }
    </script>
</body>
</html>
