package com.thegamingjourney.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.service.GamePageService;
import com.thegamingjourney.service.RatingService;

import java.io.IOException;

@WebServlet("/Game")
public class GamePageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GamePageService service;

    @Override
    public void init() throws ServletException {
        service = new GamePageService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	Integer userId = (session != null && session.getAttribute("userId") != null) 
    	                 ? (Integer) session.getAttribute("userId") 
    	                 : null;
    	
        String gameIdParam = request.getParameter("id");
        if (gameIdParam == null || !gameIdParam.matches("\\d+")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid game ID");
            return;
        }

        int gameId = Integer.parseInt(gameIdParam);
        Game game = null;
		try {
			game = service.getGameById(gameId);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (game == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Game not found");
            return;
        }

        request.setAttribute("game", game);
        try {
			request.setAttribute("reviews", service.getReviewsForGame(gameId));
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        if (userId != null) {
            int userRating = 0;
			try {
				userRating = new RatingService().getUserRating(userId, gameId);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            request.setAttribute("userRating", userRating); // Pass to JSP
        }

        request.getRequestDispatcher("/WEB-INF/pages/GamePage.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Support Unicode reviews

        String action = request.getParameter("action");

        if ("addReview".equals(action)) {
            try {
                Integer userId = (Integer) request.getSession().getAttribute("userId");
                if (userId == null) {
                    response.sendRedirect("/login"); // or send 401
                    return;
                }

                int gameId = Integer.parseInt(request.getParameter("gameId"));
                String reviewText = request.getParameter("reviewText");

                if (reviewText != null && !reviewText.trim().isEmpty()) {
                    service.addReview(userId, gameId, reviewText.trim());
                    response.sendRedirect("Game?id=" + gameId); // redirect back to game page
                } else {
                    request.setAttribute("error", "Review cannot be empty.");
                    doGet(request, response); // show page again with error
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to post review");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    
    
}
