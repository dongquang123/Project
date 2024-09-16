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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.DAOUser;
import entity.User;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "UserController", urlPatterns = {"/URLUser"})
public class UserController extends HttpServlet {

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
        String service = request.getParameter("service");
        HttpSession session = request.getSession(true);
        DAOUser dao = new DAOUser();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (service == null) {
                service = "login";
            }
            if(service.equals("login1")){
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            if (service.equals("login")) {
                    String userName = request.getParameter("user");
                    String passWord = request.getParameter("pass");
                    User user = dao.login(userName, passWord);
                    if (user == null) {
                        String message = "Invalid username or password";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                     else {
                        session.setAttribute("userName", userName);
                        session.setAttribute("acc", user);
                        response.sendRedirect("Home");
                    }
            }
            if (service.equals("logout")) {
                session.removeAttribute("userName");
                response.sendRedirect("Home");
            }
            if (service.equals("signUp1")) {
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
            if(service.equals("register")){
                String user = request.getParameter("user");
                String password = request.getParameter("password");
                String fullname = request.getParameter("fullname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                User u = new User(fullname, password, fullname, email, phone, address, 0, 0);
                int n= dao.insertUser(u);
                session.setAttribute("userName", user);
                response.sendRedirect("Home");
            }
            if(service.equals("changeAccount")){
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            }
            if(service.equals("change")){
                int userID = Integer.parseInt(request.getParameter("userID"));
                String user = request.getParameter("user");
                String password = request.getParameter("password");
                String fullname = request.getParameter("fullname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                User u = new User(userID, fullname, password, fullname, email, phone, address);
                int n= dao.updateUser(u);
                session.setAttribute("userName", user);
                response.sendRedirect("Home");
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
