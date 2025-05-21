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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String gameIdStr = request.getParameter("gameId");

        if ("delete".equals(action) && gameIdStr != null) {
            try {
                int gameId = Integer.parseInt(gameIdStr);
                service.deleteGameById(gameId); // You'll implement this in your service
            } catch (NumberFormatException | ClassNotFoundException | SQLException e) {
                e.printStackTrace(); // Consider logging
            } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }

        response.sendRedirect(request.getContextPath() + "/Admin-Game-List");
    }

    
}
