package com.thegamingjourney.controller;

import com.thegamingjourney.service.UserFavouriteListService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = {"/Favourites", "/Favourites/remove"})
public class UserFavouriteListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserFavouriteListService favouriteService = new UserFavouriteListService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            request.setAttribute("favouriteGames", favouriteService.getFavouriteGamesByUserId(userId));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to fetch favorite games.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/UserFavouriteList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        if ("/Favourites/remove".equals(path)) {
            try {
                int gameId = Integer.parseInt(request.getParameter("gameId"));
                boolean removed = favouriteService.removeFavouriteGame(userId, gameId);

                if (!removed) {
                    request.setAttribute("errorMessage", "Could not remove game from favorites.");
                }

            } catch (Exception e) {
                request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            }
            
            
        }

        // Always reload updated list
        doGet(request, response);
    }
}
