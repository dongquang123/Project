<%-- 
    Document   : ManagerProduct
    Created on : Dec 28, 2020, 5:19:02 PM
    Author     : trinh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration,entity.Product,java.util.Vector"%>
<!DOCTYPE html>
<html lang="en">
    <%
      Product pro = (Product)request.getAttribute("pro");
    %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            img{
                width: 200px;
                height: 120px;
            }
        </style>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Edit <b>Product</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="URLManagerProduct?manage=updateProduct1" method="post">
                            <div class="modal-header">						
                                <h4 class="modal-title">Add Product</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                <label>Product ID</label>
                                <input  type="text" class="form-control" name="product_id" value="<%=pro.getProduct_id()%>" readonly="">
                            </div>
                                <div class="form-group">
                                <label>Product Name</label>
                                <input  type="text" class="form-control" name="product_name" value="<%=pro.getProduct_name()%>"required >
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input  type="text" class="form-control" name="price" value="<%=pro.getPrice()%>" required>
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <input  type="text" class="form-control" name="quantity" value="<%=pro.getQuantity()%>" required>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <input  type="text" class="form-control" name="description" value="<%=pro.getDescription()%>" required>
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input  type="file" class="form-control" name="image_url" value="<%=pro.getImage_url()%>" required>
                            </div>
                            <div class="form-group">
                                <label>Release Date</label>
                                 <input  type="text" class="form-control" name="release_date" value="<%=pro.getRelease_date()%>" required>
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <select name="brand_id" class="form-select" aria-label="Default select example">
                                    <c:forEach items="${allBrand}" var="o">
                                        <option name="brand_id" value="${o.brand_id}" >${o.brand_name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-success" value="Edit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>


        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>