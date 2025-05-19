<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Real Estate Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a3c6f;
            --secondary-color: #38b2ac;
            --accent-color: #f6ad55;
            --light-color: #f8f9fa;
            --dark-color: #2d3748;
            --gradient-primary: linear-gradient(135deg, #1a3c6f 0%, #38b2ac 100%);
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.4s ease;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
            background-color: var(--light-color);
            overflow-x: hidden;
        }
        
        /* Hero Section */
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            padding: 100px 0;
            text-align: center;
            position: relative;
        }
        
        .hero-section h1 {
            font-weight: 800;
            margin-bottom: 20px;
            font-size: 3.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            position: relative;
        }

        .hero-section h1::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: var(--secondary-color);
            margin: 15px auto 25px;
        }
        
        .contact-info-icon {
            width: 70px;
            height: 70px;
            background: var(--gradient-primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            flex-shrink: 0;
            font-size: 1.5rem;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }
        
        .contact-card {
            transition: var(--transition);
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--box-shadow);
        }
        
        .contact-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }
        
        .contact-card:hover .contact-info-icon {
            transform: rotateY(180deg);
        }
        
        .btn-custom-primary {
            background: var(--secondary-color);
            border: none;
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: var(--transition);
            color: white;
            box-shadow: 0 5px 15px rgba(56, 178, 172, 0.4);
        }
        
        .btn-custom-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(56, 178, 172, 0.6);
            color: white;
        }
        
        .contact-form {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--box-shadow);
        }
        
        .contact-form-header {
            background: var(--gradient-primary);
            color: white;
            padding: 25px;
        }
    </style>
</head>
<body>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/contact">Contact</a>
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
    
    <!-- Hero Section -->
    <div class="hero-section animate__animated animate__fadeIn">
        <div class="container">
            <h1 class="display-4 fw-bold animate__animated animate__fadeInDown">Contact Us</h1>
            <p class="lead animate__animated animate__fadeInUp" style="animation-delay: 0.2s">Get in touch with our team for any inquiries or support</p>
        </div>
    </div>
    
    <!-- Contact Information -->
    <div class="container my-5">
        <div class="row mb-5">
            <div class="col-md-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                <div class="contact-card h-100">
                    <div class="card-body d-flex p-4">
                        <div class="contact-info-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div>
                            <h4>Our Location</h4>
                            <p class="mb-0">123 Real Estate Street<br>Colombo 00700<br>Sri Lanka</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.4s">
                <div class="contact-card h-100">
                    <div class="card-body d-flex p-4">
                        <div class="contact-info-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div>
                            <h4>Phone</h4>
                            <p class="mb-1">General Inquiries: +94 11 234 5678</p>
                            <p class="mb-0">Customer Support: +94 11 234 5679</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.6s">
                <div class="contact-card h-100">
                    <div class="card-body d-flex p-4">
                        <div class="contact-info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <h4>Email</h4>
                            <p class="mb-1">General Inquiries: info@realestate.com</p>
                            <p class="mb-0">Support: support@realestate.com</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Contact Form -->
        <div class="row">
            <div class="col-lg-8 mx-auto animate__animated animate__fadeInUp" style="animation-delay: 0.7s">
                <div class="contact-form">
                    <div class="contact-form-header">
                        <h3 class="mb-0">Send Us a Message</h3>
                    </div>
                    <div class="card-body p-4">
                        <form id="contactForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="name" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" required>
                            </div>
                            <div class="mb-3">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" rows="5" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-custom-primary" onclick="showThankYou(); return false;">
                                <i class="fas fa-paper-plane me-2"></i>Send Message
                            </button>
                            <div id="thankYouMessage" style="display: none;" class="alert alert-success mt-3">
                                Thank you for your message! We'll get back to you soon.
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Map Section -->
    <div class="container-fluid px-0 mt-5 animate__animated animate__fadeIn" style="animation-delay: 0.8s">
        <div class="ratio ratio-21x9" style="max-height: 400px;">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d63371.79398332231!2d79.8211858!3d6.9218386!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae253d10f7a7003%3A0x320b2e4d32d3838d!2sColombo!5e0!3m2!1sen!2slk!4v1658492745225!5m2!1sen!2slk" 
                     style="border:0;" allowfullscreen="" loading="lazy"></iframe>
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
        function showThankYou() {
            document.getElementById('thankYouMessage').style.display = 'block';
            document.getElementById('contactForm').reset();
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            // Intersection Observer for animations
            const animateElements = document.querySelectorAll('.animate__animated');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.visibility = 'visible';
                        const delay = entry.target.style.animationDelay || '0s';
                        setTimeout(() => {
                            entry.target.classList.add('animate__fadeIn');
                        }, parseFloat(delay) * 1000);
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.2 });
            
            animateElements.forEach(element => {
                if (!element.classList.contains('animate__fadeIn')) {
                    element.style.visibility = 'hidden';
                    observer.observe(element);
                }
            });
        });
    </script>
</body>
</html>
