package com.thegamingjourney.controller;

import com.thegamingjourney.service.UserReviewService;
import com.thegamingjourney.model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/My-Reviews")
public class UserReviewController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserReviewService reviewService = new UserReviewService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            List<Review> reviews = reviewService.getReviewsByUserId(userId);
            request.setAttribute("userReviews", reviews);
        } catch (ClassNotFoundException e) {
            request.setAttribute("errorMessage", "Failed to load reviews.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/UserReview.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String reviewIdParam = request.getParameter("reviewId");

        if (reviewIdParam != null) {
            try {
                int reviewId = Integer.parseInt(reviewIdParam);
                reviewService.deleteReviewById(userId, reviewId);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to delete review.");
            }
        }

        // Redirect to avoid form resubmission
        response.sendRedirect(request.getContextPath() + "/My-Reviews");
    }
}
