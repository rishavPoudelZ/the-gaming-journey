package com.thegamingjourney.service;

import com.thegamingjourney.model.User;
import com.thegamingjourney.dao.UserDAO;

import java.util.List;

import com.thegamingjourney.dao.ReviewDAO;
import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.Review;

public class UserDashboardService {

    private final LoginService loginService = new LoginService();
    private final UserDAO userDAO = new UserDAO();
    private final ReviewDAO reviewDAO = new ReviewDAO();

    public User getUserByUsername(String username) {
        return loginService.getUserByUsername(username);
    }
    
    public List<Game> getTop3FavouritesByUsername(String username) throws ClassNotFoundException {
        return userDAO.getTop3FavouritesByUsername(username);
    }

    public List<Review> getTop3ReviewsByUsername(String username) throws ClassNotFoundException {
        return reviewDAO.getTop3ReviewsByUsername(username);
    }
}
