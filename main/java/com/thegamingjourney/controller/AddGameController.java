package com.thegamingjourney.controller;

import com.thegamingjourney.service.AddGameService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/Add-Games")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
        maxFileSize = 1024 * 1024 * 10,               // 10MB
        maxRequestSize = 1024 * 1024 * 50)            // 50MB
public class AddGameController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AddGameService addGameService = new AddGameService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	try {
            request.setAttribute("genres", addGameService.getAllGenres());
            request.setAttribute("platforms", addGameService.getAllPlatforms());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load genres or platforms.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/AddGame.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String gameTitle = request.getParameter("gameName");

        List<Part> imageParts = request.getParts().stream()
                .filter(part -> "gameImages".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());
        
        String[] selectedGenres = request.getParameterValues("genres");
        String[] selectedPlatforms = request.getParameterValues("platform");

        // Set image path per game
        String uploadBasePath = getServletContext().getRealPath("/assets/gamesImages");
        String gameImagePath = uploadBasePath + File.separator + gameTitle.replaceAll("\\s+", "_");

        try {
            addGameService.saveGameWithImages(request, gameTitle, imageParts, gameImagePath, selectedGenres, selectedPlatforms);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "❌ Error saving game: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/AddGame.jsp").forward(request, response);
        }

        System.out.println("✅ Game \"" + gameTitle + "\" and its images uploaded successfully to: " + gameImagePath);
        response.sendRedirect(request.getContextPath() + "/Admin-Game-List");
    }
}
