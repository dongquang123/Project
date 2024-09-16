<%-- 
Document   : home
Created on : Jun 24, 2024, 7:43:49 AM
Author     : Fantasy
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration,entity.Product,java.util.Vector,entity.User"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Electro - HTML Ecommerce Template</title>

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

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>
        <!-- HEADER -->
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
                        <li><a href="URLProduct?Type=allCategories">All Categories</a></li>
                        <li><a href="URLProduct?Type=laptop">Laptops</a></li>
                        <li><a href="URLProduct?Type=smartphone">Smartphones</a></li>
                        <li><a href="URLProduct?Type=accessories">Accessories</a></li>
                        <c:if test="${sessionScope.acc.getIsAdmin() ==1}">
                             <li><a href="URLManagerProduct?manage=listProduct">Manage Product</a></li>
                             <li><a href="URLmanageCustomer?manageCus=listCustomer">Manage Customer</a></li>
                             <li><a href="URLOrder?manageCus=listCustomer">Manage Order</a></li>
                             <li><a href="URLadmin">Summary</a></li>
                        </c:if>
                        <c:if test="${sessionScope.acc.getIsAdmin() ==0}">
                             <li><a href="URLOrder?manageCus=OrderDetail&user_id=${sessionScope.acc.getUser_id()}">Manage Order</a></li>
                        </c:if>
                    </ul>
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- /NAVIGATION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/shop01.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Laptop<br>Collection</h3>
                                <a href="URLProduct?Type=laptop" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/shop03.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Accessories<br>Collection</h3>
                                <a href="URLProduct?Type=accessories" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/shop02.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Cameras<br>Collection</h3>
                                <a href="URLProduct?Type=camera" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">New Products</h3>

                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">
                                        <c:forEach items="${newProduct}" var="o">
                                            <!-- product -->
                                            <div style="height: 530px" class="product">
                                                <div style="height: 250px" class="product-img">
                                                    <img style="max-height:  250px" src="./img/${o.image_url}" alt="">
                                                    <div class="product-label">
                                                        <span class="new">NEW</span>
                                                    </div>
                                                </div>
                                                <div class="product-body">
                                                    <p class="product-category">Category</p>
                                                    <h3 class="product-name"><a href="URLDetail?service=${o.product_name}">${o.product_name}</a></h3>
                                                    <h4 class="product-price">${o.price} $</h4>
                                                    <div class="product-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <div class="product-btns">
                                                        <button class="add-to-wishlist"><a href="URLwishList?service=like&product_id=${o.product_id}"><i class="fa fa-heart-o"></a></i><span class="tooltipp">add to wishlist</span></button>
                                                    </div>
                                                </div>
                                                      <% String userName1 = (String)session.getAttribute("userName");%>
                                                      
                                                       
                                                          <div class="add-to-cart">
                                                              <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i><a href="URLcart?service=add2cart&product_id=${o.product_id}" style="color: white"> add to cart</a></button>
                                                          </div>
                                                    
                                            </div>
                                        </c:forEach>

                                    </div>
                                    <div id="slick-nav-1" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                    <!-- Products tab & slick -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->


        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">Top selling</h3>
                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab2" class="tab-pane fade in active">
                                    <div class="products-slick" data-nav="#slick-nav-2">
                                        <!-- product -->
                                        <c:forEach items="${topSelling}" var="o">
                                            <!-- product -->
                                            <div style="height: 530px" class="product">
                                                <div style="height: 250px" class="product-img">
                                                    <img style="max-height:  250px" src="./img/${o.image_url}" alt="">
                                                    <div class="product-label">
                                                        <span class="new">NEW</span>
                                                    </div>
                                                </div>
                                                <div class="product-body">
                                                    <p class="product-category">Category</p>
                                                    <h3 class="product-name"><a href="URLDetail?service=${o.product_name}">${o.product_name}</a></h3>
                                                    <h4 class="product-price">${o.price} $</h4>
                                                    <div class="product-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <div class="product-btns">
                                                        <button class="add-to-wishlist"><a href="URLwishList?service=like&product_id=${o.product_id}"><i class="fa fa-heart-o"></a></i><span class="tooltipp">add to wishlist</span></button>
                                                    </div>
                                                </div>
                                                      <% String userName2 = (String)session.getAttribute("userName");
                                                       if(userName2 == null){%>
                                                          <div class="add-to-cart">
                                                              <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i><a href="URLUser?service=login1" style="color: white"> add to cart</a></button>
                                                          </div>
                                                       <%}else{%>
                                                          <div class="add-to-cart">
                                                              <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i><a href="URLcart?service=add2cart&product_id=${o.product_id}" style="color: white"> add to cart</a></button>
                                                          </div>
                                                    <%}%>
                                            </div>
                                        </c:forEach>
                                        <!-- /product -->
                                    </div>
                                    <div id="slick-nav-2" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                    <!-- /Products tab & slick -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top selling</h4>
                            <div class="section-nav">
                                <div id="slick-nav-3" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-3">
                            <div>
                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/eos_r5.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=EOS R5">EOS R5</a></h3>
                                        <h4 class="product-price">3899.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/alpha7iv.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Alpha 7 IV">Alpha 7 IV</a></h3>
                                        <h4 class="product-price">2499.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/xps13.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=XPS 13">XPS 13</a></h3>
                                        <h4 class="product-price">1199.99$</h4>
                                    </div>
                                </div>
                                <!-- product widget -->
                            </div>

                            <div>
                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/alpha_7c.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Sony Alpha 7C">Sony Alpha 7C</a></h3>
                                        <h4 class="product-price">1799.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/pavilion.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Pavilion">Pavilion</a></h3>
                                        <h4 class="product-price">749.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/thinkpad_x1.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=ThinkPad X1">ThinkPad X1</a></h3>
                                        <h4 class="product-price">1299.99$</h4>
                                    </div>
                                </div>
                                <!-- product widget -->
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top selling</h4>
                            <div class="section-nav">
                                <div id="slick-nav-4" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-4">
                            <div>
                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/eos_r6.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Canon EOS R6">Canon EOS R6</a></h3>
                                        <h4 class="product-price">2499.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/rog_phone_5.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=ROG Phone 5">ROG Phone 5</a></h3>
                                        <h4 class="product-price">999.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/macbook.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=MacBook Pro">MacBook Pro</a></h3>
                                        <h4 class="product-price">1999.99$</h4>
                                    </div>
                                </div>
                                <!-- product widget -->
                            </div>

                            <div>
                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/thinkpad_x1.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=ThinkPad X1">ThinkPad X1</a></h3>
                                        <h4 class="product-price">1299.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/pavilion.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Pavilion">Pavilion</a></h3>
                                        <h4 class="product-price">749.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/alpha_7c.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Sony Alpha 7C">Sony Alpha 7C</a></h3>
                                        <h4 class="product-price">1799.99$</h4>
                                    </div>
                                </div>
                                <!-- product widget -->
                            </div>
                        </div>
                    </div>

                    <div class="clearfix visible-sm visible-xs"></div>

                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top selling</h4>
                            <div class="section-nav">
                                <div id="slick-nav-5" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-5">
                            <div>
                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/alpha_7c.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Sony Alpha 7C">Sony Alpha 7C</a></h3>
                                        <h4 class="product-price">1799.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/pavilion.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Pavilion">Pavilion</a></h3>
                                        <h4 class="product-price">749.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/thinkpad_x1.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=ThinkPad X1">ThinkPad X1</a></h3>
                                        <h4 class="product-price">1299.99$</h4>
                                    </div>
                                </div>
                                <!-- product widget -->
                            </div>

                            <div>
                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/eos_r5.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=EOS R5">EOS R5</a></h3>
                                        <h4 class="product-price">3899.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/alpha7iv.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=Alpha 7 IV">Alpha 7 IV</a></h3>
                                        <h4 class="product-price">2499.99$</h4>
                                    </div>
                                </div>
                                <!-- /product widget -->

                                <!-- product widget -->
                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="./img/xps13.jpg" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a href="URLDetail?service=XPS 13">XPS 13</a></h3>
                                        <h4 class="product-price">1199.99$</h4>
                                    </div>
                                </div>
                                <!-- product widget -->
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- NEWSLETTER -->
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="newsletter">
                            <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                            <form action="URLLetter">
                                <input name="newLetter" class="input" type="email" placeholder="Enter Your Email">
                                <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                            </form>
                            <ul class="newsletter-follow">
                                <li>
                                    <a href="https://www.facebook.com/"><i class="fa fa-facebook"></i></a>
                                </li>
                                <li>
                                    <a href="https://x.com/?lang=vi"><i class="fa fa-twitter"></i></a>
                                </li>
                                <li>
                                    <a href="https://www.instagram.com/"><i class="fa fa-instagram"></i></a>
                                </li>
                                <li>
                                    <a href="https://www.pinterest.com/"><i class="fa fa-pinterest"></i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /NEWSLETTER -->

        <!-- FOOTER -->
        <footer id="footer">
            <!-- top footer -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">About Us</h3>
                                <ul class="footer-links">
                                    <li><a href="#"><i class="fa fa-map-marker"></i>Ha Noi</a></li>
                                    <li><a href="#"><i class="fa fa-phone"></i>0763221204</a></li>
                                    <li><a href="#"><i class="fa fa-envelope-o"></i>quangdnhe180789@fpt.edu.vn</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Categories</h3>
                                <ul class="footer-links">
                                    <li><a href="URLProduct?Type=laptop">Laptops</a></li>
                                    <li><a href="URLProduct?Type=smartphone">Smartphones</a></li>
                                    <li><a href="URLProduct?Type=accessories">Accessories</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="clearfix visible-xs"></div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Information</h3>
                                <ul class="footer-links">
                                    <li><a href="#">About Us</a></li>
                                    <li><a href="#">Contact Us</a></li>
                                    <li><a href="#">Privacy Policy</a></li>
                                    <li><a href="#">Orders and Returns</a></li>
                                    <li><a href="#">Terms & Conditions</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Service</h3>
                                <ul class="footer-links">
                                    <li><a href="URLcart">View Cart</a></li>
                                    <li><a href="#">Track My Order</a></li>
                                    <li><a href="#">Help</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /top footer -->

            <!-- bottom footer -->
            <div id="bottom-footer" class="section">
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <ul class="footer-payments">
                                <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                                <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                            </ul>
                            <span class="copyright">
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            </span>
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /bottom footer -->
        </footer>
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>


