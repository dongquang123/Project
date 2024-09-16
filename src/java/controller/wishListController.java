/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Vector;
import model.DAOProducts;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "wishListController", urlPatterns = {"/URLwishList"})
public class wishListController extends HttpServlet {

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
        HttpSession session = request.getSession(true);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("service");
            String service1 = request.getParameter("Type");
            DAOProducts dao = new DAOProducts();
            if (service.equals("wishList")) {
                request.getRequestDispatcher("wishList.jsp").forward(request, response);
            }
            if (service.equals("like")) {
                int pid = Integer.parseInt(request.getParameter("product_id"));
                Product pro;
                pro = (Product) session.getAttribute(pid + "wish");
                if (pro == null) {
                    Vector<Product> vector = dao.getProducts("Select * from products where product_id = " + pid);
                    Product product = vector.get(0);
                    pro = new Product(pid, product.getProduct_name(), product.getPrice(),
                            product.getQuantity(), product.getDescription(), product.getImage_url(),
                            product.getBrand_id(), product.getRelease_date(), 1);
                    session.setAttribute(pid + "wish", pro);
                    response.sendRedirect("Home");
                } else {
                    pro.setQuantityWishList(pro.getQuantityWishList() + 1);
                    pro.setQuantity(pro.getQuantity() - 1);
                    session.setAttribute(pid + "wish", pro);
                    response.sendRedirect("Home");
                }
            }
            if (service != null) {
                if (service.equals("removeAll")) {
                    Product pro1 = null;
                    Vector<Product> product = new Vector<>();
                    Enumeration enu2 = session.getAttributeNames();//getkey();
                    while (enu2.hasMoreElements()) {
                        String pid1 = (String) enu2.nextElement();//pid = key
                        if (!pid1.equals("userName") && !pid1.equals("acc") && pid1.contains("wish")) {
                            session.removeAttribute(pid1);
                        }
                    }
                    request.getRequestDispatcher("wishList.jsp").forward(request, response);
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
