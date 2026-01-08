package com.election.controller;

import com.election.model.UserBean;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get Parameters
        String id = request.getParameter("username");
        String pass = request.getParameter("password");
        String role = request.getParameter("user_role");
        
        // 2. Call DAO
        UserDAO dao = new UserDAO();
        UserBean user = dao.authenticateUser(id, pass, role);

        // 3. Handle Result
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            
            // Redirect based on role
            if (role.equals("student")) {
                response.sendRedirect("student_dashboard.jsp");
            } else if (role.equals("lecturer")) {
                response.sendRedirect("lecturer_dashboard.jsp");
            } else {
                response.sendRedirect("admin_dashboard.jsp");
            }
        } else {
            // Failed
            request.setAttribute("errorMessage", "Invalid ID or Password!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}