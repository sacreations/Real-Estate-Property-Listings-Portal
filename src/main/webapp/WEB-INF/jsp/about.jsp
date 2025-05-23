<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Real Estate Portal</title>
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
            position: relative;
            text-align: center;
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
        
        .section-title {
            position: relative;
            margin-bottom: 40px;
            padding-bottom: 15px;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            width: 50px;
            height: 3px;
            background-color: var(--secondary-color);
        }
        
        .value-card {
            transition: var(--transition);
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--box-shadow);
            height: 100%;
        }
        
        .value-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }
        
        .value-icon {
            font-size: 3rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
            transition: var(--transition);
        }
        
        .value-card:hover .value-icon {
            transform: rotateY(180deg);
        }
        
        /* Team section */
        .team-member-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid var(--light-color);
            transition: var(--transition);
            margin: 0 auto 20px;
        }
        
        .team-card {
            text-align: center;
            padding: 30px 20px;
            border-radius: 15px;
            background: white;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }
        
        .team-card:hover {
            transform: translateY(-10px);
        }
        
        .team-card:hover .team-member-img {
            border-color: var(--secondary-color);
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/about">About Us</a>
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
    <div class="hero-section animate__animated animate__fadeIn">
        <div class="container">
            <h1 class="display-4 fw-bold animate__animated animate__fadeInDown">About Our Real Estate Portal</h1>
            <p class="lead animate__animated animate__fadeInUp" style="animation-delay: 0.2s">Connecting people with their dream properties since 2020</p>
        </div>
    </div>
    
    <!-- About Us Content -->
    <div class="container my-5">
        <div class="row">
            <div class="col-lg-8 mx-auto animate__animated animate__fadeInUp" style="animation-delay: 0.3s">
                <h2 class="section-title text-center">Our Story</h2>
                <p class="lead text-center mb-4">
                    Founded in 2020, our Real Estate Portal was created with a simple mission: to make property hunting easier and more efficient.
                </p>
                <p>
                    Our platform connects property seekers with a wide range of listings across the country. Whether you're looking for an apartment in the city, a suburban house, commercial space, or land for development, our comprehensive database has options to suit every need and budget.
                </p>
                <p>
                    We believe that finding your dream property should be an exciting journey, not a stressful process. Our user-friendly interface, advanced search features, and detailed property listings are all designed with this philosophy in mind.
                </p>
                <p>
                    As we continue to grow, we remain committed to providing exceptional service to both property seekers and owners. Our team is constantly working on improving our platform and expanding our offerings to better serve our community.
                </p>
            </div>
        </div>
    </div>
    
    <!-- Our Values -->
    <div class="bg-light py-5">
        <div class="container">
            <h2 class="section-title text-center">Our Values</h2>
            <div class="row g-4">
                <div class="col-md-4 animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                    <div class="value-card h-100">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-handshake value-icon"></i>
                            <h4>Trust</h4>
                            <p>We are committed to transparency and honesty in every property listing and transaction.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 animate__animated animate__fadeInUp" style="animation-delay: 0.4s">
                    <div class="value-card h-100">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-user-shield value-icon"></i>
                            <h4>Reliability</h4>
                            <p>Our platform provides accurate, up-to-date information you can depend on.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 animate__animated animate__fadeInUp" style="animation-delay: 0.6s">
                    <div class="value-card h-100">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-chart-line value-icon"></i>
                            <h4>Innovation</h4>
                            <p>We continuously evolve our platform to meet the changing needs of our users.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer>
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
