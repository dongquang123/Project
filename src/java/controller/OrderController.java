/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import entity.User;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;
import model.DAOUser;
import model.DBConnect;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.DAOOrders;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "OrderController", urlPatterns = {"/URLOrder"})
public class OrderController extends HttpServlet {

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
            String manageCus = request.getParameter("manageCus");
            DAOOrders dao1 = new DAOOrders();
            DAOUser dao = new DAOUser();
            DBConnect db = new DBConnect();
            if (manageCus == null) {
                manageCus = "OrderDetail";
            }
            
            if(manageCus.equals("search")){
                int user_id = Integer.parseInt(request.getParameter("user_id"));
                String search = request.getParameter("search");
                ResultSet rs = db.getData("Select o.order_id,p.product_name,oi.quantity,p.price,o.status,oi.item_id,o.user_id\n"
                        + "from products p \n"
                        + "inner join orderItems oi on p.product_id=oi.product_id\n"
                        + "inner join orders o on o.order_id=oi.order_id\n"
                        + "inner join users u on u.user_id=o.user_id\n"
                        + "where p.product_name Like '%" + search+"%' and o.user_id="+user_id);
                request.setAttribute("rs", rs);
                request.getRequestDispatcher("manageOrderDetail.jsp").forward(request, response);
            }
            if (manageCus.equals("listCustomer")) {
                Vector<User> listCustomer = dao.getUsers("select * from users");
                request.setAttribute("listCustomer", listCustomer);
                request.getRequestDispatcher("manageOrder.jsp").forward(request, response);
            } else if (manageCus.equals("OrderDetail")) {
                int user_id = Integer.parseInt(request.getParameter("user_id"));
                ResultSet rs = db.getData("Select o.order_id,p.product_name,oi.quantity,p.price,o.status,oi.item_id,o.user_id\n"
                        + "from products p \n"
                        + "inner join orderItems oi on p.product_id=oi.product_id\n"
                        + "inner join orders o on o.order_id=oi.order_id\n"
                        + "inner join users u on u.user_id=o.user_id\n"
                        + "where u.user_id =" + user_id);
                request.setAttribute("rs", rs);
                request.setAttribute("user_id", user_id);
                request.getRequestDispatcher("manageOrderDetail.jsp").forward(request, response);
            } else {
                int item_id = Integer.parseInt(request.getParameter("item_id"));
                int user_id = Integer.parseInt(request.getParameter("user_id"));
                int n = dao1.updateOrder(manageCus, item_id);
                request.setAttribute("manageCus", manageCus);
                response.sendRedirect("URLOrder?user_id=" + user_id);
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
