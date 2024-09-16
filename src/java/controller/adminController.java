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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOProducts;
import model.DBConnect;
import java.util.Vector;
import entity.Product;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "adminController", urlPatterns = {"/URLadmin"})
public class adminController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            DBConnect db = new DBConnect();
            DAOProducts dao = new DAOProducts();
            ResultSet rs = db.getData("Select Count(user_id) from users");
            ResultSet rs1 = db.getData("Select Count(product_id) from products");
            ResultSet rs2 = db.getData("Select Count(order_id) from orders");
            ResultSet rs3 = db.getData("Select sum(o.quantity*p.price)\n"
                    + "From orderItems o \n"
                    + "inner join products p on o.product_id=p.product_id");
            ResultSet rs4 = db.getData("select Top 6 p.brand_id,brand_name ,Sum(o.quantity*p.price)\n"
                    + "from orderItems o\n"
                    + "inner join products p on o.product_id=p.product_id\n"
                    + "inner Join brands b on b.brand_id=p.brand_id\n"
                    + "Group By p.brand_id,brand_name");
            Vector<Product> product = dao.getProducts("Select top 5 * \n"
                    + "from products \n"
                    + "Order by price desc");
            request.setAttribute("product", product);
            try {
                rs.next();
                rs1.next();
                rs2.next();
                rs3.next();
                request.setAttribute("numberOfUser", rs.getInt(1));
                request.setAttribute("numberOfProduct", rs1.getInt(1));
                request.setAttribute("numberOfOrder", rs2.getInt(1));
                request.setAttribute("total", rs3.getDouble(1));
                request.setAttribute("topBrand", rs4);
            } catch (SQLException ex) {
                Logger.getLogger(adminController.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
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
