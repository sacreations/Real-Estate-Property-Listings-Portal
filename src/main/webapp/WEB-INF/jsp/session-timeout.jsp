<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Expired - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        body {
            display: flex;
            align-items: center;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .session-container {
            max-width: 600px;
            text-align: center;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            background-color: white;
        }
        .session-icon {
            font-size: 5rem;
            color: #ffc107;
            margin-bottom: 20px;
        }
        .session-title {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 600;
            color: #2c3e50;
        }
        .countdown {
            font-size: 18px;
            font-weight: 500;
            color: #6c757d;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="session-container mx-auto">
            <div class="session-icon">
                <i class="bi bi-clock-history"></i>
            </div>
            <div class="session-title">Your Session Has Expired</div>
            <p class="lead mb-4">For your security, you have been logged out due to inactivity.</p>
            <p class="countdown mb-4">You will be redirected to the login page in <span id="countdown">5</span> seconds...</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/auth?action=loginPage" class="btn btn-primary">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Login Now
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                    <i class="bi bi-house-door me-2"></i>Return to Home
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // Countdown timer
        let seconds = 5;
        const countdownElement = document.getElementById('countdown');
        
        const countdownInterval = setInterval(function() {
            seconds--;
            countdownElement.textContent = seconds;
            
            if (seconds <= 0) {
                clearInterval(countdownInterval);
                window.location.href = "${pageContext.request.contextPath}/auth?action=loginPage";
            }
        }, 1000);
    </script>
</body>
</html>
