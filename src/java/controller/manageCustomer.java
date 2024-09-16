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
import entity.User;
import java.sql.ResultSet;
import java.util.Vector;
import model.DAOUser;
import model.DBConnect;
/**
 *
 * @author Fantasy
 */
@WebServlet(name = "manageCustomer", urlPatterns = {"/URLmanageCustomer"})
public class manageCustomer extends HttpServlet {

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
        DBConnect db = new DBConnect();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String manageCus = request.getParameter("manageCus");
            DAOUser dao = new DAOUser();
            if (manageCus == null) {
                manageCus="listCustomer";
            }
            if(manageCus.equals("listCustomer")){
                Vector<User> listCustomer = dao.getUsers("select * from users");
                request.setAttribute("listCustomer", listCustomer);
                request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
            }
            if(manageCus.equals("banCustomer")){
                int uid = Integer.parseInt(request.getParameter("user_id"));
                int n = dao.banned(uid);
                response.sendRedirect("URLmanageCustomer?manageCus=listCustomer");
            }
            if(manageCus.equals("unbanCustomer")){
                int uid = Integer.parseInt(request.getParameter("user_id"));
                int n = dao.Unbanned(uid);
                response.sendRedirect("URLmanageCustomer?manageCus=listCustomer");
            }
            if(manageCus.equals("changeAdmin")){
                int uid = Integer.parseInt(request.getParameter("user_id"));
                int n = dao.Admin(uid);
                response.sendRedirect("URLmanageCustomer?manageCus=listCustomer");
            }
            if(manageCus.equals("search")){
                String search = request.getParameter("search");
                Vector<User> listCustomer = dao.getUsers("select * from users where username Like '%"+search+"%'");
                request.setAttribute("listCustomer", listCustomer);
                request.getRequestDispatcher("manageCustomer.jsp").forward(request, response);
            }
            if(manageCus.equals("search1")){
                String search = request.getParameter("search");
                Vector<User> listCustomer = dao.getUsers("select * from users where username Like '%"+search+"%'");
                request.setAttribute("listCustomer", listCustomer);
                request.getRequestDispatcher("manageOrder.jsp").forward(request, response);
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
