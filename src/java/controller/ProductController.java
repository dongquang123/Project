/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import entity.Product;
import model.DAOProducts;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "ProductController", urlPatterns = {"/URLProduct"})
public class ProductController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
//           String sql = "select * from products where description Like '%laptop%'";
//           Vector<Product> laptop = dao.getProducts(sql);
//           request.setAttribute("laptop", laptop);
//           
//           String sql1 = "select * from products where description Like '%smartphone%'";
//           Vector<Product> smartphone = dao.getProducts(sql1);
//           request.setAttribute("smartphone", smartphone);
//           
//           String sql2 = "select * from products where description Like '%camera%'";
//           Vector<Product> camera = dao.getProducts(sql2);
//           request.setAttribute("camera", camera);

            String service = request.getParameter("Type");
            String search = request.getParameter("search");
            if (search == null) {
                if (service.equals("accessories")) {
                    String sql = "select * from products where description Like '%headphone%' Or description Like '%earbuds%' ";
                    Vector<Product> vector = dao.getProducts(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("store.jsp").forward(request, response);
                } else if (service.equals("allCategories")) {
                    String sql = "select * from products";
                    Vector<Product> vector = dao.getProducts(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("store.jsp").forward(request, response);
                } else {
                    String sql = "select * from products where description Like '%" + service + "%'";
                    Vector<Product> vector = dao.getProducts(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("store.jsp").forward(request, response);
                }
            } else {
                if (service.equals("accessories")) {
                    String sql = "select * from products where description Like ('%headphone%' Or description Like '%earbuds%)"
                            + " And product_name LIKE '%" + search + "%'";
                    Vector<Product> vector = dao.getProducts(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("store.jsp").forward(request, response);
                } else if (service.equals("allCategories")) {
                    String sql = "select * from products where product_name Like '%"+search+"%'";
                    Vector<Product> vector = dao.getProducts(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("store.jsp").forward(request, response);
                } else {
                    String sql = "select * from products where description Like '%" + service + "%' And product_name LIKE '%" + search
                            + "%'";
                    Vector<Product> vector = dao.getProducts(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("store.jsp").forward(request, response);
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
