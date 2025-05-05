package com.thegamingjourney.controller;

import com.thegamingjourney.model.Review;
import com.thegamingjourney.service.AdminUserReviewsService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class AdminUserReviewsController
 * 
 * Handles HTTP requests to display user reviews for admin users.
 * Interacts with AdminUserReviewsService to fetch review data and
 * forwards it to the JSP view.
 */
@WebServlet(urlPatterns = {"/AdminUserReviews"})
public class AdminUserReviewsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Service for retrieving user review data
    private AdminUserReviewsService reviewService;

    /**
     * Default constructor initializes the service instance.
     */
    public AdminUserReviewsController() {
        this.reviewService = new AdminUserReviewsService();
    }

    /**
     * Handles HTTP GET requests.
     * Retrieves all user reviews and forwards them to the JSP page for display.
     * 
     * @param request  The HttpServletRequest object containing the request data.
     * @param response The HttpServletResponse object used to return the response.
     * @throws ServletException If a servlet-specific error occurs.
     * @throws IOException      If an I/O error occurs.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve all reviews from the service layer
        List<Review> reviews = reviewService.getAllReviews();

        // Set the reviews in request scope
        request.setAttribute("reviews", reviews);

        // Forward to the admin review JSP page
        request.getRequestDispatcher("/WEB-INF/pages/AdminUserReviews.jsp").forward(request, response);
    }
}
