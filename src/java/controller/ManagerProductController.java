/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Product;
import entity.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import model.DAOProducts;
import model.DAOBrands;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "ManagerProductController", urlPatterns = {"/URLManagerProduct"})
public class ManagerProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOProducts dao = new DAOProducts();
        DAOBrands brand = new DAOBrands();
        try (PrintWriter out = response.getWriter()) {
            String manage = request.getParameter("manage");
            if (manage == null) {
                manage = "listProduct";
            }
            if(manage.equals("search")){
                String search = request.getParameter("search1");
                String sql = "Select * from products where product_name Like '%"+search+"%'";
                Vector<Product> allProduct = dao.getProducts(sql);
                request.setAttribute("allProduct", allProduct);
                request.getRequestDispatcher("manageProduct.jsp").forward(request, response);
            }
            if (manage.equals("removeProduct")) {
                int pid = Integer.parseInt(request.getParameter("product_id"));
                int n = dao.removeProduct(pid);
                response.sendRedirect("URLManagerProduct");
            }
            if (manage.equals("listProduct")) {
                Vector<Product> vector2 = dao.getProducts("Select * from products");
                Vector<Brand> vector3 = brand.getBrands("select * from brands");
                request.setAttribute("allProduct", vector2);
                request.setAttribute("allBrand", vector3);
                request.getRequestDispatcher("manageProduct.jsp").forward(request, response);
            }
            if (manage.equals("updateProduct")) {
                int pid = Integer.parseInt(request.getParameter("product_id"));
                Product pro = dao.getProductById(pid);
                request.setAttribute("pro", pro);
                Vector<Brand> vector3 = brand.getBrands("select * from brands");
                request.setAttribute("allBrand", vector3);
                request.getRequestDispatcher("Edit.jsp").forward(request, response);
            }
            if (manage.equals("updateProduct1")) {
                
                String product_name = request.getParameter("product_name");
                Double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String description = request.getParameter("description");
                String image_url = request.getParameter("image_url");
                int brand_id = Integer.parseInt(request.getParameter("brand_id"));
                String release_date = request.getParameter("release_date");
                int product_id  = Integer.parseInt(request.getParameter("product_id"));
                Product pro = new Product(product_id,product_name, 1899, quantity, description, image_url, brand_id, release_date);
                int n= dao.updateProduct(pro);
                response.sendRedirect("URLManagerProduct");
            }
            String submit = request.getParameter("submit");
            if (submit != null) {
                if (manage.equals("addProduct")) {
                    String product_name = request.getParameter("product_name");
                    Double price = Double.parseDouble(request.getParameter("price"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    String description = request.getParameter("description");
                    String image_url = request.getParameter("image_url");
                    int brand_id = Integer.parseInt(request.getParameter("brand_id"));
                    String release_date = request.getParameter("release_date");
                    Product pro = new Product(product_name, price, quantity, description, image_url, brand_id, release_date);
                    int n = dao.insertProduct(pro);
                    response.sendRedirect("URLManagerProduct");
                }
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
