<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
            color: #e74c3c;
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
            <div class="error-code">500</div>
            <div class="error-text mb-4">Internal Server Error</div>
            <p class="lead mb-4">Something went wrong on our servers. We are working to fix the problem.</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="javascript:history.back()" class="btn btn-outline-primary">Go Back</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Home Page</a>
            </div>
        </div>
    </div>
</body>
</html>
