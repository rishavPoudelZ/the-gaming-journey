package com.thegamingjourney.controller;

import com.thegamingjourney.model.User;
import com.thegamingjourney.service.RegisterService;
import com.thegamingjourney.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
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

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String retypePassword = request.getParameter("retypePassword");

        // Check empty fields
        if (ValidationUtil.isNullOrEmpty(username)) {
            request.setAttribute("error", "Username is required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (ValidationUtil.isNullOrEmpty(email)) {
            request.setAttribute("error", "Email is required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (ValidationUtil.isNullOrEmpty(password)) {
            request.setAttribute("error", "Password is required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters and meet security requirements.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.doPasswordsMatch(password, retypePassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // Proceed to register
        try {
            if (registerService.usernameExists(username)) {
                request.setAttribute("error", "Username is already taken.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            User newUser = new User(username, email, password);
            boolean success = registerService.registerUser(newUser);

            if (success) {
                response.sendRedirect("login"); // redirect to login page or controller
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
}
