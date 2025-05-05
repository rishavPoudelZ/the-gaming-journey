package com.thegamingjourney.controller;

import com.thegamingjourney.model.User;
import com.thegamingjourney.service.UserDashboardService;
import com.thegamingjourney.util.CookieUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/User-Dashboard")
public class UserDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDashboardService dashboardService = new UserDashboardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read username from cookie
        String username = CookieUtil.getCookieValue(request, "tgj_username");

        if (username == null) {
            response.sendRedirect("login");
            return;
        }

        // Fetch user by username
        User user = dashboardService.getUserByUsername(username);

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        

        // Set user data in request scope
        request.setAttribute("user", user);

        // Forward to JSP under WEB-INF
        request.getRequestDispatcher("/WEB-INF/pages/UserDashboard.jsp").forward(request, response);
    }
}
