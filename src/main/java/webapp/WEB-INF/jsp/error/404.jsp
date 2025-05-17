<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            align-items: center;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .error-container {
            max-width: 600px;
            text-align: center;
        }
        .error-code {
            font-size: 120px;
            line-height: 1;
            font-weight: 700;
            color: #2c3e50;
        }
        .error-text {
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container mx-auto">
            <div class="error-code">404</div>
            <div class="error-text mb-4">Page Not Found</div>
            <p class="lead mb-4">The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="javascript:history.back()" class="btn btn-outline-primary">
                    <i class="bi bi-arrow-left me-2"></i>Go Back
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="bi bi-house-door me-2"></i>Home Page
                </a>
                <a href="${pageContext.request.contextPath}/properties" class="btn btn-success">
                    <i class="bi bi-building me-2"></i>Browse Properties
                </a>
            </div>
            <div class="mt-5">
                <p>If you believe this is an error, please <a href="${pageContext.request.contextPath}/contact">contact our support team</a>.</p>
            </div>
        </div>
    </div>
</body>
</html>
