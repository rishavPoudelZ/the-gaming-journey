package com.thegamingjourney.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
import com.thegamingjourney.util.CookieUtil;
import com.thegamingjourney.util.SessionUtil;

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {

    private static final String[] PUBLIC_PAGES = {
        "Login", "Register"
    };

    private static final String[] USER_PAGES = {
    		"About-Us", "Home", "User-Dashboard", "Favourites", "My-Reviews", "Games", "Game"
    };

    private static final String[] ADMIN_PAGES = {
        "Admin-Dashboard", "Admin-Game-List", "Admin-User-Reviews", "Add-Games", "Edit-Game"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // Skip static resources
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") || uri.endsWith(".jpg")) {
            chain.doFilter(request, response);
            return;
        }

        String userRole = CookieUtil.getCookie(req, "tgj_role") != null
                ? CookieUtil.getCookie(req, "tgj_role").getValue()
                : null;

        // Normalize URI end
        String page = uri.substring(uri.lastIndexOf("/") + 1);

        boolean isPublicPage = matchesAny(page, PUBLIC_PAGES);
        boolean isUserPage = matchesAny(page, USER_PAGES);
        boolean isAdminPage = matchesAny(page, ADMIN_PAGES);

        if (userRole == null) {
            // Not logged in
            if (isPublicPage) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/Login");
            }
        } else if ("user".equals(userRole)) {
            if (isAdminPage) {
                res.sendRedirect(req.getContextPath() + "/Home");
            } else {
                chain.doFilter(request, response);
            }
        } else if ("admin".equals(userRole)) {
            if (isUserPage) {
                res.sendRedirect(req.getContextPath() + "/Admin-Dashboard");
            } else {
                chain.doFilter(request, response);
            }
        } else {
            // Unknown role
            res.sendRedirect(req.getContextPath() + "/Login");
        }
    }

    private boolean matchesAny(String page, String[] allowedPages) {
        for (String allowed : allowedPages) {
            if (page.equalsIgnoreCase(allowed)) {
                return true;
            }
        }
        return false;
    }
}
