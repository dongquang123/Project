<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration,entity.Product,java.util.Vector,entity.User"%>
<!DOCTYPE html>
<html lang="en">
    <%
      User user = (User)session.getAttribute("acc");
    %>

    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="icon" type="image/png" href="images/icons/favicon.ico" />

        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">

        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">

        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">

        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/login.css">

        <meta name="robots" content="noindex, follow">
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <form action="URLUser" method="post" class="login100-form validate-form">
                        <span class="login100-form-title p-b-26">
                            ACCOUNT INFORMATION
                        </span>
                        <span class="login100-form-title p-b-48">
                            <i class="zmdi zmdi-font"></i>
                        </span>
                        <br>
                        <div class="wrap-input100 validate-input">
                            User ID
                            <input class="input100" type="text" name="userID" value="<%=user.getUser_id()%>" readonly="">

                        </div>
                        <div class="wrap-input100 validate-input">
                            User Name
                            <input class="input100" type="text" name="user" value="<%=user.getUsername()%>">

                        </div>
                        <div class="wrap-input100 validate-input">
                            Password
                            <input class="input100" type="password" name="password" value="<%=user.getPassword()%>">

                        </div>
                        <div class="wrap-input100 validate-input">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            Full Name
                            <input class="input100" type="text" name="fullname" value="<%=user.getFullname()%>">

                        </div>
                        <div class="wrap-input100 validate-input">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            Email
                            <input class="input100" type="text" name="email" value="<%=user.getEmail()%>">

                        </div>
                        <div class="wrap-input100 validate-input">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            Phone
                            <input class="input100" type="text" name="phone" value="<%=user.getPhone()%>">

                        </div>
                        <div class="wrap-input100 validate-input">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            Address
                            <input class="input100" type="text" name="address" value="<%=user.getAddress()%>">

                        </div>
                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button type="submit" class="login100-form-btn" >
                                    Update Account
                                </button>
                                <input type="hidden" name="service" value="change">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="dropDownSelect1"></div>

        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>

        <script src="vendor/animsition/js/animsition.min.js"></script>

        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

        <script src="vendor/select2/select2.min.js"></script>

        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>

        <script src="vendor/countdowntime/countdowntime.js"></script>

        <script src="js/login.js"></script>

        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
    </body>


</html>
