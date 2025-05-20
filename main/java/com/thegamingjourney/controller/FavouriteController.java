package com.thegamingjourney.controller;

import com.thegamingjourney.service.GamePageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/Favourite")
public class FavouriteController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GamePageService service;

    @Override
    public void init() throws ServletException {
        service = new GamePageService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int gameId = Integer.parseInt(request.getParameter("gameId"));

        boolean isFavorite = false;
		try {
			isFavorite = service.isFavorite(userId, gameId);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        boolean success = false;

        if (isFavorite) {
            try {
				success = service.removeFavorite(userId, gameId);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            response.getWriter().write(success ? "Removed from favorites" : "Failed to remove");
        } else {
            try {
				success = service.addFavorite(userId, gameId);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            response.getWriter().write(success ? "Added to favorites" : "Failed to add");
        }
    }
}
