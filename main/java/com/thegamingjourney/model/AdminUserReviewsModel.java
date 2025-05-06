package com.thegamingjourney.model; 

import java.time.LocalDate;

public class Review {
    private int reviewId;
    private int userId;
    private int gameId;
    private String reviewText;
    private LocalDate reviewDate;
    private int likes;
    private int dislikes;

    // Constructors
    public Review() {}

    public Review(int reviewId, int userId, int gameId, String reviewText, 
                 LocalDate reviewDate, int likes, int dislikes) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.gameId = gameId;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
        this.likes = likes;
        this.dislikes = dislikes;
    }
    
    // Getters and Setters

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public LocalDate getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(LocalDate reviewDate) {
        this.reviewDate = reviewDate;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }