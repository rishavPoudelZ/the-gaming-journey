package com.thegamingjourney.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Arrays;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class CookieUtil {

	public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
	    try {
	        String encodedValue = URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
	        Cookie cookie = new Cookie(name, encodedValue);
	        cookie.setMaxAge(maxAge);
	        cookie.setPath("/");
	        response.addCookie(cookie);
	    } catch (Exception e) {
	        e.printStackTrace(); // handle encoding errors
	    }
	}
	

    public static Cookie getCookie(HttpServletRequest request, String name) {
        if (request.getCookies() != null) {
            return Arrays.stream(request.getCookies())
                    .filter(cookie -> name.equals(cookie.getName()))
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }
    
    
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie cookie = getCookie(request, name);
        if (cookie != null) {
            try {
                return URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8.toString());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }


    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
