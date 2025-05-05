package com.gamereview.model;

import java.time.LocalDate;

/**
 * Model class representing a user review.
 */
public class ReviewModel {

    private int id;
    private String username;
    private String text;
    private String gameTitle;
    private String gameSlug;
    private LocalDate datePosted;

    public ReviewModel() {
    }

    public ReviewModel(int id, String username, String text, String gameTitle, String gameSlug, LocalDate datePosted) {
        this.id = id;
        this.username = username;
        this.text = text;
        this.gameTitle = gameTitle;
        this.gameSlug = gameSlug;
        this.datePosted = datePosted;
    }

    public ReviewModel(String username, String text, String gameTitle, String gameSlug, LocalDate datePosted) {
        this.username = username;
        this.text = text;
        this.gameTitle = gameTitle;
        this.gameSlug = gameSlug;
        this.datePosted = datePosted;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getGameTitle() {
        return gameTitle;
    }

    public void setGameTitle(String gameTitle) {
        this.gameTitle = gameTitle;
    }

    public String getGameSlug() {
        return gameSlug;
    }

    public void setGameSlug(String gameSlug) {
        this.gameSlug = gameSlug;
    }

    public LocalDate getDatePosted() {
        return datePosted;
    }

    public void setDatePosted(LocalDate datePosted) {
        this.datePosted = datePosted;
    }
}
