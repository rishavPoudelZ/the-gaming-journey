package com.thegamingjourney.controller;

import com.thegamingjourney.model.User;
import com.thegamingjourney.service.LoginService;
import com.thegamingjourney.util.CookieUtil;
import com.thegamingjourney.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/Login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginService loginService;

    @Override
    public void init() {
        loginService = new LoginService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Auto-login logic if cookie exists
    	String username = CookieUtil.getCookieValue(req, "tgj_username");
    	
        if (username != null) {
            User user = loginService.getUserByUsername(username);
            if (user != null) {
                SessionUtil.setAttribute(req, "user", user);
                SessionUtil.setAttribute(req, "userId", user.getUserId());
                resp.sendRedirect("Home");
                return;
            }
        }

        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = loginService.validateUser(username, password);

        if (user != null) {
            SessionUtil.setAttribute(request, "user", user);
            SessionUtil.setAttribute(request, "userId", user.getUserId());
            CookieUtil.addCookie(response, "tgj_username", username, 7 * 24 * 60 * 60); // 7 days
            CookieUtil.addCookie(response, "tgj_role", user.getRole(), 7 * 24 * 60 * 60); // Store role in cookie
            
            
            response.sendRedirect("Home");
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}
