package com.thegamingjourney.controller;

import com.thegamingjourney.model.User;
import com.thegamingjourney.dao.UserDAO;
import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.Review;
import com.thegamingjourney.service.UserDashboardService;
import com.thegamingjourney.util.CookieUtil;
import com.thegamingjourney.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

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

        // Get the top 3 favourites and top 3 reviews
        List<Game> top3Favourites = null;
		try {
			top3Favourites = dashboardService.getTop3FavouritesByUsername(username);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Review> top3Reviews = null;
		try {
			top3Reviews = dashboardService.getTop3ReviewsByUsername(username);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Set user data, favourites, and reviews in request scope
        request.setAttribute("user", user);
        request.setAttribute("top3Favourites", top3Favourites);
        request.setAttribute("top3Reviews", top3Reviews);

        // Forward to JSP under WEB-INF
        request.getRequestDispatcher("/WEB-INF/pages/UserDashboard.jsp").forward(request, response);
    }
    
    @Override
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

        // Refresh user data
        List<Game> top3Favourites = null;
		try {
			top3Favourites = dashboardService.getTop3FavouritesByUsername(username);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Review> top3Reviews = null;
		try {
			top3Reviews = dashboardService.getTop3ReviewsByUsername(username);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.setAttribute("user", user);
        request.setAttribute("top3Favourites", top3Favourites);
        request.setAttribute("top3Reviews", top3Reviews);

        request.getRequestDispatcher("/WEB-INF/pages/UserDashboard.jsp").forward(request, response);
    }

}
