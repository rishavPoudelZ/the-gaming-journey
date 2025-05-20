package com.thegamingjourney.controller;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.service.AdminGameListService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Edit-Game")
public class EditGameController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final AdminGameListService service = new AdminGameListService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int gameId = Integer.parseInt(request.getParameter("id"));
        try {
            Game game = service.getGameById(gameId);
            List<String> allGenres = service.getAllGenres();
            List<String> allPlatforms = service.getAllPlatforms();
            List<String> selectedGenres = service.getGenresForGame(gameId);
            List<String> selectedPlatforms = service.getPlatformsForGame(gameId);

            request.setAttribute("game", game);
            request.setAttribute("genres", allGenres);
            request.setAttribute("platforms", allPlatforms);
            request.setAttribute("selectedGenres", selectedGenres);
            request.setAttribute("selectedPlatforms", selectedPlatforms);
            request.setAttribute("editMode", true); // use this in the form to change heading/button

            request.getRequestDispatcher("/WEB-INF/pages/EditGames.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    
}


