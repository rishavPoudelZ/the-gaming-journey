package com.thegamingjourney.controller;

import com.thegamingjourney.service.AdminDashboardService;
import com.thegamingjourney.util.CookieUtil;
import com.thegamingjourney.util.PasswordUtil;
import com.thegamingjourney.dao.UserDAO;
import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.Review;
import com.thegamingjourney.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Admin-Dashboard")
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDashboardService dashboardService = new AdminDashboardService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Game> latestGames = null;
		try {
			latestGames = dashboardService.getLatestGames();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Review> latestReviews = null;
		try {
			latestReviews = dashboardService.getLatestReviews();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.setAttribute("latestGames", latestGames);
        request.setAttribute("latestReviews", latestReviews);

        request.getRequestDispatcher("/WEB-INF/pages/AdminDashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = CookieUtil.getCookieValue(request, "tgj_username");

        if (username == null) {
            response.sendRedirect("login");
            return;
        }

        String currentPasswordInput = request.getParameter("CurrentPassword");
        String newPassword = request.getParameter("NewPassword");
        String confirmPassword = request.getParameter("ConfirmPassword");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsername(username);

        if (user == null) {
            request.setAttribute("error", "User not found.");
        } else {
            try {
                String decryptedPassword = PasswordUtil.decrypt(user.getPassword(), username);

                if (!decryptedPassword.equals(currentPasswordInput)) {
                    request.setAttribute("error", "Current password is incorrect.");
                } else if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "New passwords do not match.");
                } else {
                    String encryptedNewPassword = PasswordUtil.encrypt(username, newPassword);
                    userDAO.updatePassword(username, encryptedNewPassword);
                    request.setAttribute("success", "Password changed successfully.");
                }
            } catch (Exception e) {
                request.setAttribute("error", "An error occurred while updating the password.");
            }
        }
        
        request.setAttribute("user", user);
        List<Game> latestGames = null;
		try {
			latestGames = dashboardService.getLatestGames();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Review> latestReviews = null;
		try {
			latestReviews = dashboardService.getLatestReviews();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.setAttribute("latestGames", latestGames);
        request.setAttribute("latestReviews", latestReviews);

        request.getRequestDispatcher("/WEB-INF/pages/AdminDashboard.jsp").forward(request, response);
    }
}
