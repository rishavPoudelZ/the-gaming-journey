package com.thegamingjourney.controller;

import com.thegamingjourney.util.CookieUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/Logout")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate the current session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Remove cookies
        CookieUtil.deleteCookie(response, "tgj_username");
        CookieUtil.deleteCookie(response, "tgj_role");

        // Redirect to login page
        response.sendRedirect("Login");
    }
}
