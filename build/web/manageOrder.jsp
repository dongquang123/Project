<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration,entity.Product,java.util.Vector"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
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
        <style>
            .img1{
                width: 50%;
                height: 140px;
            }
        </style>
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
                        <li><a href="#"><i class="fa fa-dollar"></i> USD</a></li>

                        <% String userName = (String)session.getAttribute("userName");
                            if(userName == null){%>
                        <li><a href="URLUser?service=login1"><i class="fa fa-user-o"></i>Login</a></li>
                            <%}else{%>
                        <li><a href="URLUser?service=logout"><i class="fa fa-user-o"></i>Logout</a></li>
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
                                <form action="URLmanageCustomer">
                                    <input name="search" class="input" placeholder="Search here">
                                    <a href="URLmanageCustomer"><button class="search-btn" name="submit" value="">Search</button></a>
                                    <input type="hidden" name="manageCus" value="search1"></td>
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
                                        <a href="wishList.jsp">
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
                                          if(pid.equals("userName") || pid.equals("acc")){
                                             continue;
                                          }else{
                                            pro = (Product)session.getAttribute(pid);
                                           %>
                                            
                                                <div class="product-widget">
                                                    <div class="product-img">
                                                        <img class="img1"src="./img/<%=pro.getImage_url()%>" alt="">
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
        <!-- /NAVIGATION -->
        <!--Manage product -->
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row" style="margin: 20px 0px">
                        <div class="col-sm-6" >
                            <h2>Manage <b>Order</b></h2>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>
                                <span class="custom-checkbox">
                                    <input type="checkbox" id="selectAll">
                                    <label for="selectAll"></label>
                                </span>
                            </th>
                            <th>ID</th>
                            <th>FullName</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listCustomer}" var="o">
                            <tr>
                                <td>
                                    <span class="custom-checkbox">
                                        <input type="checkbox" id="checkbox1" name="options[]" value="1">
                                        <label for="checkbox1"></label>
                                    </span>
                                </td>
                                <td>${o.user_id}</td>
                                <td>${o.fullname}</td>
                                <td>${o.email}</td>
                                <td>${o.phone}</td>
                                <td>${o.address}</td>
                                <td>
                                    <a href="URLOrder?manageCus=OrderDetail&user_id=${o.user_id}">Detail</a>
                                </td>
                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
            </div>
            <a href="#"><button type="button" class="btn btn-primary">Back to home</button>

        </div>
        
        <!-- Delete Modal HTML -->
        <div id="deleteEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">						
                            <h4 class="modal-title">Delete Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <p>Are you sure you want to delete these Records?</p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </a>
    <script src="js/manager.js" type="text/javascript"></script>
</body>
</html>