package com.thegamingjourney.controller;

import com.thegamingjourney.model.User;
import com.thegamingjourney.service.RegisterService;
import com.thegamingjourney.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/Register")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RegisterService registerService;

    @Override
    public void init() {
        registerService = new RegisterService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String retypePassword = request.getParameter("retypePassword");
        
        
        

        // Validation
        if (ValidationUtil.isNullOrEmpty(username) || 
            ValidationUtil.isNullOrEmpty(email) ||
            ValidationUtil.isNullOrEmpty(password)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must meet complexity requirements.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.doPasswordsMatch(password, retypePassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // ✅ Handle profile picture upload
        String profileFileName = null;
        Part profilePart = request.getPart("profilePic");
        System.out.println("File Part: " + profilePart);
        System.out.println("Submitted Filename: " + profilePart.getSubmittedFileName());
        System.out.println("Size: " + profilePart.getSize());
        
        if (profilePart != null && profilePart.getSize() > 0) {
            String extension = getExtension(profilePart.getSubmittedFileName());
            profileFileName = username + "_profilePicture" + extension;

            String uploadPath = getServletContext().getRealPath("/assests/usersImages");
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File file = new File(uploadDir, profileFileName);
            try (InputStream input = profilePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                System.out.println("Uploaded to: " + file.getAbsolutePath()); // For debugging
            } catch (IOException ex) {
                ex.printStackTrace();
                request.setAttribute("error", "Failed to upload profile picture.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }
        }

        // Proceed to register
        try {
            if (registerService.usernameExists(username)) {
                request.setAttribute("error", "Username is already taken.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            User newUser = new User(username, email, password, profileFileName);

            boolean success = registerService.registerUser(newUser);

            if (success) {
                response.sendRedirect("Login");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }

    private String getExtension(String filename) {
        int dotIndex = filename.lastIndexOf('.');
        return (dotIndex != -1) ? filename.substring(dotIndex) : "";
    }
}
