package com.thegamingjourney.controller;

import com.thegamingjourney.model.Review;
import com.thegamingjourney.service.AdminUserReviewsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/AdminUserReviews")
public class AdminUserReviewsController extends HttpServlet {
    private AdminUserReviewsService reviewService = new AdminUserReviewsService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int page = getPageNumber(request);
            List<Review> reviews = reviewService.getReviews(page);
            int totalPages = reviewService.getTotalPages();
            
            request.setAttribute("reviews", reviews);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            request.getRequestDispatcher("/WEB-INF/pages/AdminUserReviews.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/error.jsp")
                   .forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                if (reviewService.deleteReview(reviewId)) {
                    response.sendRedirect(request.getContextPath() + "/admin/reviews?deleted=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/reviews?error=delete_failed");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews?error=invalid_request");
            }
        }
    }

    private int getPageNumber(HttpServletRequest request) {
        try {
            return Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}