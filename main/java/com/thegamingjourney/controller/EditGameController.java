package com.thegamingjourney.controller;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.service.AdminGameListService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int gameId = Integer.parseInt(request.getParameter("gameId"));
            String title = request.getParameter("gameName");
            String description = request.getParameter("description");
            String developer = request.getParameter("developer");
            String releaseDate = request.getParameter("releaseDate");
            String ageRestriction = request.getParameter("ageRestriction");
            String gameUrl = request.getParameter("gameUrl");
            String[] genres = request.getParameterValues("genres");
            String[] platforms = request.getParameterValues("platforms");

            Game game = new Game();
            game.setGameId(gameId);
            game.setTitle(title);
            game.setDescription(description);
            game.setDeveloper(developer);
            game.setReleaseDate(Date.valueOf(releaseDate));
            game.setAgeRestriction(ageRestriction);
            game.setGameUrl(gameUrl);

            service.updateGame(game, genres, platforms);

            response.sendRedirect("Admin-Dashboard"); // Redirect to dashboard or wherever needed

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update game. Please try again.");
            doGet(request, response); // Redisplay form with error
        }
    }
    
    
}


