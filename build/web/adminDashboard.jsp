<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration,entity.Product,java.util.Vector,entity.User"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <%ResultSet rs =(ResultSet)request.getAttribute("topBrand");
      Vector<String> brandName = new Vector<>();
      Vector<Double> price = new Vector<>();
      while(rs.next()){
          brandName.add(rs.getString(2));
          price.add(rs.getDouble(3));
        }
    %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Admin Dashboard</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
        rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
</head>

<body>
    <!-- Page Preloder -->
    <header>
            <!-- TOP HEADER -->
            <div id="top-header">
                <div class="container">
                    <ul class="header-links pull-left">
                        <li><a href="#"><i class="fa fa-phone"></i>0763221204</a></li>
                        <li><a href="#"><i class="fa fa-envelope-o"></i>quangdnhe180789@fpt.edu.vn</a></li>
                        <li><a href="#"><i class="fa fa-map-marker"></i>Ha Noi</a></li>
                    </ul>
                    <ul class="header-links pull-right">

                        <% String userName = (String)session.getAttribute("userName");
                           User user = (User)session.getAttribute("acc");
                           String fullname="";
                           if(user!=null){ 
                               fullname = user.getFullname();
                            }
                            if(userName == null){%>
                        <li><a href="URLUser?service=login1"><i class="fa fa-user-o"></i>Login</a></li>
                        <li><a href="URLUser?service=signUp1"><i class="fa fa-user-o"></i>Sign Up</a></li>
                            <%}else{%>
                        <li><a style="color: white"><%=fullname%></a></li>
                        <li><a style="color: white">Welcome: ${userName}</a></li>
                        <li><a href="URLUser?service=logout"><i class="fa fa-user-o"></i>Logout</a></li>
                        <li><a href="URLUser?service=changeAccount"><i class="fa fa-user-o"></i>Account</a></li>
                            <%}%>
                    </ul>
                </div>
            </div>
            <!-- /TOP HEADER -->

            <!-- MAIN HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-3">
                            <div class="header-logo">
                                <a href="Home" class="logo">
                                    <img src="./img/logo.png" alt="">
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->
                        <div class="col-md-6">
                            <div class="header-search">
                                <form action="URLProduct">
                                    <select name="Type" class="input-select">
                                        <option value="allCategories">All Categories</option>
                                        <option value="laptop">Laptop</option>
                                        <option value="smartphone">Smartphone</option>
                                        <option value="accessories">Accessories</option>
                                    </select>
                                    <input name="search"class="input" placeholder="Search here">
                                    <button class="search-btn" name="submit" value="search">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- /SEARCH BAR -->

                        <!-- ACCOUNT -->
                        <div class="col-md-3 clearfix">
                            <div class="header-ctn">
                                <!-- Wishlist -->
                                <div>
                                    <a  class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <a href="URLwishList?service=wishList">
                                            <i class="fa fa-heart-o"></i>
                                            <span>Your WishList</span>
                                        </a> 
                                    </a>
                                </div>
                                <!-- /Wishlist -->

                                <!-- Cart -->
                                <div class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Your Cart</span>
                                    </a>
                                
                                
                                    <div class="cart-dropdown">
                                            <div class="cart-list">
                                    <%
                                        int cnt=0;
                                        double subTotal=0;
                                        Product pro =null ;
                                        Enumeration enu = session.getAttributeNames();//getkey();
                                        while(enu.hasMoreElements()){
                                          String pid = (String)enu.nextElement();//pid = key
                                          if(!pid.equals("userName") && !pid.equals("acc") && !pid.contains("wish") ){
                                            pro = (Product)session.getAttribute(pid);
                                           %>
                                            
                                                <div class="product-widget">
                                                    <div class="product-img">
                                                        <img src="./img/<%=pro.getImage_url()%>" alt="">
                                                    </div>
                                                    <div class="product-body">
                                                        <h3 class="product-name"><a href="URLDetail?service=<%=pro.getProduct_name()%>"><%=pro.getProduct_name()%></a></h3>
                                                        <h4 class="product-price"><span class="qty"><%=pro.getQuantityUser()%>X</span><%=pro.getPrice()* pro.getQuantityUser()%> $</h4>
                                                        <% subTotal += pro.getPrice()* pro.getQuantityUser(); 
                                                           cnt+= pro.getQuantityUser(); %>
                                                    </div>
                                                    
                                                    <button class="delete" ><a href="URLcart?service=removeCart&product_id=<%=pro.getProduct_id()%>"><i class="fa fa-close"></i></a></button>
                                                </div>
                                               <%}}%>    
                                            </div>
                                        
                                        <div class="cart-summary">
                                            <small><%=cnt%> Item(s) selected</small>
                                            <h5>SUBTOTAL: <%=subTotal%></h5>
                                        </div>
                                        <div class="cart-btns">
                                            <a href="URLcart">View Cart</a>
                                            <a href="URLcheckOut">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Cart -->

                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li class="active"><a href="Home">Home</a></li>
                    </ul>
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>

    <!-- Header Section Begin -->
    <div class="container">
        <div class="row">
            
            
        </div>
    </div>
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text" style="margin-top: 10px   ">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Header Section End -->

    <!-- Dashboard Overview Section Begin -->
    <section class="dashboard-overview spad" style="margin-bottom: 40px">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="overview-item">
                        <h4>Total Users</h4>
                        <h2>${numberOfUser}</h2>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="overview-item">
                        <h4>Total Products</h4>
                        <h2>${numberOfProduct}</h2>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="overview-item">
                        <h4>Total Orders</h4>
                        <h2>${numberOfOrder}</h2>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="overview-item">
                        <h4>Total Revenue</h4>
                        <h2>${total}$</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Dashboard Overview Section End -->

    <!-- Chart Section Begin -->
    <section class="chart-section spad">
        <div class="container">
            <div class="row">
                
                <div class="col-lg-12">
                    <h3>Monthly Sales Data</h3>
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>
    </section>
    <!-- Chart Section End -->

    <!-- Top Products Section Begin -->
    <section class="top-products spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h3>Top Products</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Rank</th>
                                <th>Product</th>
                                <th>Sales</th>
                            </tr>
                        </thead>
                        <%int rank =1;%>
                        <c:forEach items="${product}" var="o">
                        <thead>
                            <tr>
                                <th><%=rank%></th>
                                <th>${o.product_name}</th>
                                <th>${o.price}</th>
                                <%rank++;%>
                            </tr>
                        </thead>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
    <!-- Top Products Section End -->

    <!-- Footer Section Begin -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="footer__copyright__text">
                        <p>Copyright � 2024 All rights reserved | This template is made with <i class="fa fa-heart-o"
                                aria-hidden="true"></i> by <a href="#" target="_blank">Your Company</a></p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery.nicescroll.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery.countdown.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Bar Chart
        const ctxBar = document.getElementById('salesChart').getContext('2d');
        const salesChart = new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: ['<%=brandName.get(0)%>', '<%=brandName.get(1)%>', '<%=brandName.get(2)%>', '<%=brandName.get(3)%>', '<%=brandName.get(4)%>', '<%=brandName.get(5)%>'],
                datasets: [{
                    label: 'Sales',
                    data: [<%=price.get(0)%>, <%=price.get(1)%>, <%=price.get(2)%>, <%=price.get(3)%>, <%=price.get(4)%>, <%=price.get(5)%>],
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Pie Chart for Sales Distribution
        const ctxPie = document.getElementById('salesPieChart').getContext('2d');
        const salesPieChart = new Chart(ctxPie, {
            type: 'pie',
            data: {
                labels: ['Electronics', 'Fashion', 'Home & Kitchen', 'Books', 'Other'],
                datasets: [{
                        
                    label: 'Sales Distribution',
                    data: [3000, 5000, 2000, 1500, 800],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });

        // Additional Pie Chart for Category Distribution
        const ctxCategoryPie = document.getElementById('categoryPieChart').getContext('2d');
        const categoryPieChart = new Chart(ctxCategoryPie, {
            type: 'pie',
            data: {
                labels: ['Category A', 'Category B', 'Category C', 'Category D'],
                datasets: [{
                    label: 'Category Distribution',
                    data: [4000, 3000, 2000, 1000],
                    backgroundColor: [
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(75, 192, 192, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 159, 64, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
    </script>
</body>

</html>
