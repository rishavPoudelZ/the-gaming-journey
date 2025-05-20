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

@WebServlet("/Admin-User-Reviews")
public class AdminUserReviewsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
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
        } catch (Exception e) {
            request.setAttribute("error", "System error: " + e.getMessage());
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
                boolean deleted = reviewService.deleteReview(reviewId);
                
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/Admin-User-Reviews?deleted=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/Admin-User-Reviews?error=delete_failed");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/Admin-User-Reviews?error=invalid_id");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/Admin-User-Reviews?error=system_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/Admin-User-Reviews?error=invalid_action");
        }
    }

    private int getPageNumber(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        if (pageParam == null || pageParam.isEmpty()) {
            return 1;
        }
        
        try {
            int page = Integer.parseInt(pageParam);
            return page > 0 ? page : 1;
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}