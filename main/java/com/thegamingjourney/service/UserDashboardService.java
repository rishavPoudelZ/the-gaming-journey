package com.thegamingjourney.service;

import com.thegamingjourney.model.User;

public class UserDashboardService {

    private final LoginService loginService = new LoginService();

    public User getUserByUsername(String username) {
        return loginService.getUserByUsername(username);
    }
}
