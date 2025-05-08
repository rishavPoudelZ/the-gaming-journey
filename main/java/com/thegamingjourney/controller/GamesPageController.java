package com.thegamingjourney.controller;

import com.thegamingjourney.service.GamesPageService;
import com.thegamingjourney.model.Genre;
import com.thegamingjourney.model.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/Games")
public class GamesPageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final GamesPageService gamesPageService = new GamesPageService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String genre = request.getParameter("genre");

        List<Genre> genresList = null;
		try {
			genresList = gamesPageService.getAllGenres();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.setAttribute("genresList", genresList);

        try {
            List<Game> games;
            if (genre == null || genre.isEmpty()) {
                games = gamesPageService.getAllGamesSortedByRating();
            } else {
                games = gamesPageService.getGamesByGenreSortedByRating(genre);
            }
            request.setAttribute("gamesList", games);
            request.setAttribute("selectedGenre", genre);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/pages/GamesPage.jsp").forward(request, response);
    }
}
