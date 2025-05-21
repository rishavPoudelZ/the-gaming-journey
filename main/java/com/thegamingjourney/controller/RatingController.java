package com.thegamingjourney.controller;

import com.thegamingjourney.service.RatingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/RatingController")
public class RatingController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private RatingService ratingService = new RatingService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int gameId = Integer.parseInt(request.getParameter("gameId"));
        String ratingParam = request.getParameter("ratingValue");
        if (ratingParam == null || ratingParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing or empty ratingValue");
            return;
        }
        int ratingValue = Integer.parseInt(ratingParam);
        
        System.out.println("Received ratingValue: '" + request.getParameter("ratingValue") + "'");

        // Delete any existing rating by this user for this game
        try {
			ratingService.deleteRating(userId, gameId);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Add new rating
        try {
			ratingService.addRating(userId, gameId, ratingValue);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Recalculate average rating for game and update
        int newAvgRating = 0;
		try {
			newAvgRating = ratingService.recalculateAndUpdateAvgRating(gameId);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/Game?id=" + gameId);
    }
}
