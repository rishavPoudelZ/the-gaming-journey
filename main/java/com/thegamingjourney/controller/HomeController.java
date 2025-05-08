package com.thegamingjourney.controller;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.service.HomeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/Home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final HomeService homeService = new HomeService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Game> games = null;
        try {
            // Get the top 10 games based on rating
            games = homeService.getTopGames();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.setAttribute("gamesList", games);
        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }
}
