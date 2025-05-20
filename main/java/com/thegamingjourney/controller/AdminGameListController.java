package com.thegamingjourney.controller;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.service.AdminGameListService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/Admin-Game-List")
public class AdminGameListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AdminGameListService service = new AdminGameListService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Game> games = service.getAllGames();
            request.setAttribute("games", games);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Consider logging this
        }

        request.getRequestDispatcher("/WEB-INF/pages/AdminGameList.jsp").forward(request, response);
    }
}
