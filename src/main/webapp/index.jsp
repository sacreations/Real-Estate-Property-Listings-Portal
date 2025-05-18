<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Real Estate Property Listings Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css">
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
            background-color: var(--light-color);
            font-family: 'Poppins', sans-serif;
            color: #333;
            overflow-x: hidden;
        }
        
        /* Hero Section */
        .hero-section {
            height: 100vh;
            min-height: 600px;
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .hero-content {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 15px;
            z-index: 1;
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
            margin: 15px 0 25px;
        }
        
        .hero-section p {
            font-size: 1.3rem;
            margin-bottom: 30px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
            max-width: 700px;
        }

        .hero-search-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            margin-top: 40px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .hero-search-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
        }
        
        /* Buttons */
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
        
        .btn-custom-outline {
            background: transparent;
            border: 2px solid white;
            padding: 11px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: var(--transition);
            color: white;
        }
        
        .btn-custom-outline:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-3px);
        }
        
        /* Feature Cards */
        .section-title {
            position: relative;
            margin-bottom: 60px;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .section-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--secondary-color);
            margin: 15px auto 0;
            border-radius: 2px;
        }
        
        .feature-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            height: 100%;
            border: none;
            background: white;
            position: relative;
            z-index: 1;
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 0;
            background: var(--gradient-primary);
            z-index: -1;
            transition: var(--transition);
            opacity: 0.05;
        }
        
        .feature-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }
        
        .feature-card:hover::before {
            height: 100%;
        }
        
        .feature-card .card-body {
            padding: 30px;
        }
        
        .feature-card .card-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
            transition: var(--transition);
            display: inline-block;
        }
        
        .feature-card:hover .feature-icon {
            transform: rotateY(180deg);
        }
        
        /* Stats Section */
        .stats-section {
            background: var(--gradient-primary);
            padding: 80px 0;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .stats-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80') center center/cover;
            opacity: 0.1;
        }
        
        .stat-item {
            text-align: center;
            position: relative;
            z-index: 1;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: white;
        }
        
        .stat-label {
            font-size: 1.2rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Testimonials */
        .testimonial-section {
            padding: 100px 0;
            background-color: #f8f9fa;
        }
        
        .testimonial-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--box-shadow);
            position: relative;
            margin: 20px;
        }
        
        .testimonial-card::before {
            content: '\201C';
            font-family: Georgia, serif;
            font-size: 5rem;
            color: rgba(56, 178, 172, 0.1);
            position: absolute;
            top: 10px;
            left: 20px;
            line-height: 1;
        }
        
        .testimonial-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--secondary-color);
        }
        
        .testimonial-text {
            margin-bottom: 20px;
            font-style: italic;
        }
        
        .testimonial-name {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .testimonial-role {
            color: var(--secondary-color);
            font-size: 0.9rem;
        }
        
        .swiper-pagination-bullet-active {
            background: var(--secondary-color);
        }
        
        /* Footer */
        footer {
            background-color: var(--dark-color);
            padding: 70px 0 30px;
            color: #ffffff;
            position: relative;
        }
        
        footer h5 {
            color: white;
            font-weight: 700;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }
        
        footer h5::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--secondary-color);
        }
        
        footer p {
            color: rgba(255,255,255,0.7);
            line-height: 1.8;
        }
        
        .social-icons a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            color: white;
            margin-right: 10px;
            transition: var(--transition);
        }
        
        .social-icons a:hover {
            background: var(--secondary-color);
            transform: translateY(-5px);
        }
        
        footer .list-unstyled li {
            margin-bottom: 12px;
        }
        
        footer .list-unstyled a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: var(--transition);
            display: inline-block;
        }
        
        footer .list-unstyled a:hover {
            color: var(--secondary-color);
            transform: translateX(5px);
        }
        
        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 20px;
            margin-top: 30px;
        }
        
        @media (max-width: 767px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .hero-section p {
                font-size: 1.1rem;
            }
            
            .hero-search-container {
                padding: 15px;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
    <section class="hero-section" id="home">
        <div class="container">
            <div class="hero-content text-center animate__animated animate__fadeIn">
                <h1>Find Your Dream Property</h1>
                <p>Discover the perfect home with our comprehensive property listings platform that helps you make informed decisions for your real estate investments</p>
                
                <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
                    <c:choose>
                        <c:when test="${empty sessionScope.userId}">
                            <a href="${pageContext.request.contextPath}/auth?action=loginPage" class="btn btn-custom-primary animate__animated animate__fadeInUp">
                                <i class="fas fa-sign-in-alt me-2"></i> Login
                            </a>
                            <a href="${pageContext.request.contextPath}/auth?action=registerPage" class="btn btn-custom-outline animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
                                <i class="fas fa-user-plus me-2"></i> Register
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/properties" class="btn btn-custom-primary animate__animated animate__fadeInUp">
                                <i class="fas fa-home me-2"></i> View Properties
                            </a>
                            <c:if test="${sessionScope.userType eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-custom-outline animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
                                    <i class="fas fa-tachometer-alt me-2"></i> Admin Dashboard
                                </a>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Property Search Form -->
                <div class="hero-search-container animate__animated animate__fadeInUp" style="animation-delay: 0.4s;">
                    <div class="hero-search-title text-start">Find Your Perfect Property</div>
                    <form action="${pageContext.request.contextPath}/properties" method="get" class="row g-3">
                        <div class="col-md-4">
                            <select class="form-select form-select-lg" name="propertyType">
                                <option value="">Property Type</option>
                                <option value="apartment">Apartment</option>
                                <option value="house">House</option>
                                <option value="commercial">Commercial</option>
                                <option value="land">Land</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <input type="text" class="form-control form-control-lg" name="location" placeholder="Location">
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-custom-primary w-100 h-100">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="py-5" id="about">
        <div class="container my-5">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0 animate__animated animate__fadeInLeft">
                    <img src="https://images.unsplash.com/photo-1582407947304-fd86f028f716?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fHJlYWwlMjBlc3RhdGV8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60" 
                         class="img-fluid rounded-4 shadow" alt="Modern home">
                </div>
                <div class="col-lg-6 animate__animated animate__fadeInRight">
                    <h2 class="section-title text-start">Welcome to Our Real Estate Portal</h2>
                    <p class="lead mb-4">
                        Browse through our extensive collection of properties, find your dream home, 
                        or list your property for sale or rent.
                    </p>
                    <p>Our platform connects buyers, sellers, and agents through a seamless digital experience, providing detailed property insights, market analytics, and expert advice to help you make informed decisions.</p>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/properties" class="btn btn-custom-primary">
                            <i class="fas fa-search me-2"></i> Browse Properties
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Feature Section -->
    <section class="py-5 bg-light" id="features">
        <div class="container py-5">
            <h2 class="text-center section-title mb-5">Our Features</h2>
            <div class="row g-4">
                <div class="col-md-4 animate__animated animate__fadeInUp">
                    <div class="feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-search feature-icon"></i>
                            <h4 class="card-title">Advanced Search</h4>
                            <p class="card-text">Find properties that match your specific requirements using our powerful search features with multiple filtering options.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
                    <div class="feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-list-ul feature-icon"></i>
                            <h4 class="card-title">Detailed Listings</h4>
                            <p class="card-text">View comprehensive information about each property including high-quality images, specifications, and neighborhood details.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 animate__animated animate__fadeInUp" style="animation-delay: 0.4s;">
                    <div class="feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-user-cog feature-icon"></i>
                            <h4 class="card-title">User Dashboard</h4>
                            <p class="card-text">Create an account to save your favorite properties, track listings, and manage your property portfolio.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-6 mb-4 mb-md-0">
                    <div class="stat-item">
                        <div class="stat-number" data-count="1500">0</div>
                        <div class="stat-label">Properties</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-4 mb-md-0">
                    <div class="stat-item">
                        <div class="stat-number" data-count="850">0</div>
                        <div class="stat-label">Happy Clients</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-number" data-count="50">0</div>
                        <div class="stat-label">Agents</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-number" data-count="20">0</div>
                        <div class="stat-label">Cities</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonial-section">
        <div class="container">
            <h2 class="text-center section-title">What Our Clients Say</h2>
            
            <div class="swiper testimonialSwiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <div class="testimonial-text">
                                "I found my dream home through this platform. The search features made it easy to filter properties based on my preferences, and the detailed listings provided all the information I needed."
                            </div>
                            <div class="d-flex align-items-center">
                                <img src="https://randomuser.me/api/portraits/women/32.jpg" alt="Client" class="testimonial-avatar me-3">
                                <div>
                                    <div class="testimonial-name">Sarah Johnson</div>
                                    <div class="testimonial-role">Home Buyer</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <div class="testimonial-text">
                                "As a real estate agent, this platform has significantly increased my property visibility. The user-friendly interface and detailed property showcase options have helped me close deals faster."
                            </div>
                            <div class="d-flex align-items-center">
                                <img src="https://randomuser.me/api/portraits/men/44.jpg" alt="Client" class="testimonial-avatar me-3">
                                <div>
                                    <div class="testimonial-name">Michael Thompson</div>
                                    <div class="testimonial-role">Real Estate Agent</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <div class="testimonial-text">
                                "The property management features on this platform are exceptional. As a property owner, I can easily list and manage multiple properties, track inquiries, and connect with potential buyers."
                            </div>
                            <div class="d-flex align-items-center">
                                <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Client" class="testimonial-avatar me-3">
                                <div>
                                    <div class="testimonial-name">Emma Davis</div>
                                    <div class="testimonial-role">Property Owner</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h5>Real Estate Portal</h5>
                    <p>Find your dream property with our comprehensive listing platform designed to make property hunting simple and efficient.</p>
                    <div class="social-icons mt-3">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/properties"><i class="fas fa-chevron-right me-2"></i>Properties</a></li>
                        <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-chevron-right me-2"></i>About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-chevron-right me-2"></i>Contact</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right me-2"></i>Terms of Service</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <h5>Property Types</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/properties?propertyType=apartment"><i class="fas fa-building me-2"></i>Apartments</a></li>
                        <li><a href="${pageContext.request.contextPath}/properties?propertyType=house"><i class="fas fa-home me-2"></i>Houses</a></li>
                        <li><a href="${pageContext.request.contextPath}/properties?propertyType=commercial"><i class="fas fa-store me-2"></i>Commercial</a></li>
                        <li><a href="${pageContext.request.contextPath}/properties?propertyType=land"><i class="fas fa-map me-2"></i>Land</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Contact Us</h5>
                    <ul class="list-unstyled">
                        <li class="d-flex mb-3">
                            <i class="fas fa-map-marker-alt mt-1 me-3 text-secondary"></i>
                            <span>123 Real Estate St, Colombo</span>
                        </li>
                        <li class="d-flex mb-3">
                            <i class="fas fa-phone mt-1 me-3 text-secondary"></i>
                            <span>+94 11 234 5678</span>
                        </li>
                        <li class="d-flex">
                            <i class="fas fa-envelope mt-1 me-3 text-secondary"></i>
                            <span>info@realestate.com</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row footer-bottom">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2025 Real Estate Portal. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-0">Designed with <i class="fas fa-heart text-danger"></i> for property seekers</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize Swiper
            const testimonialSwiper = new Swiper('.testimonialSwiper', {
                slidesPerView: 1,
                spaceBetween: 30,
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                breakpoints: {
                    768: {
                        slidesPerView: 2,
                    },
                    992: {
                        slidesPerView: 3,
                    }
                },
                autoplay: {
                    delay: 5000,
                },
            });
            
            // Animate stats numbers
            const stats = document.querySelectorAll('.stat-number');
            stats.forEach(stat => {
                const count = parseInt(stat.getAttribute('data-count'));
                let current = 0;
                const increment = Math.ceil(count / 50);
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= count) {
                        current = count;
                        clearInterval(timer);
                    }
                    stat.innerText = current;
                }, 30);
            });
            
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