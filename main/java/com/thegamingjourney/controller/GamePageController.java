package com.thegamingjourney.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.service.GamePageService;

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

        request.getRequestDispatcher("/WEB-INF/pages/GamePage.jsp").forward(request, response);
    }
}
