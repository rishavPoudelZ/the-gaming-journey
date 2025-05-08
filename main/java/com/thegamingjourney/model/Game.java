package com.thegamingjourney.model;

import java.util.Date;
import java.util.List;

public class Game {
    private int gameId;
    private String title;
    private String description;
    private String developer;
    private Date releaseDate;
    private Date dateUploaded;
    private String imagesUrl;
    private int avgRating;
    private String gameUrl;
    private String ageRestriction;
    private String genre; // Added genre field
    private List<String> genres;
    private List<String> platforms;

    // Getters and setters

    public int getGameId() { 
        return gameId; 
    }

    public void setGameId(int gameId) { 
        this.gameId = gameId; 
    }

    public String getTitle() { 
        return title; 
    }

    public void setTitle(String title) { 
        this.title = title; 
    }

    public String getDescription() { 
        return description; 
    }

    public void setDescription(String description) { 
        this.description = description; 
    }

    public String getDeveloper() { 
        return developer; 
    }

    public void setDeveloper(String developer) { 
        this.developer = developer; 
    }

    public Date getReleaseDate() { 
        return releaseDate; 
    }

    public void setReleaseDate(Date releaseDate) { 
        this.releaseDate = releaseDate; 
    }

    public Date getDateUploaded() { 
        return dateUploaded; 
    }

    public void setDateUploaded(Date dateUploaded) { 
        this.dateUploaded = dateUploaded; 
    }

    public String getImagesUrl() { 
        return imagesUrl; 
    }

    public void setImagesUrl(String imagesUrl) { 
        this.imagesUrl = imagesUrl; 
    }

    public int getAvgRating() { 
        return avgRating; 
    }

    public void setAvgRating(int avgRating) { 
        this.avgRating = avgRating; 
    }

    public String getGameUrl() { 
        return gameUrl; 
    }

    public void setGameUrl(String gameUrl) { 
        this.gameUrl = gameUrl; 
    }

    public String getAgeRestriction() { 
        return ageRestriction; 
    }

    public void setAgeRestriction(String ageRestriction) { 
        this.ageRestriction = ageRestriction; 
    }

    public String getGenre() { // Getter for genre
        return genre;
    }

    public void setGenre(String genre) { // Setter for genre
        this.genre = genre;
    }
    
    public List<String> getGenres() {
        return genres;
    }

    public void setGenres(List<String> genres) {
        this.genres = genres;
    }

    public List<String> getPlatforms() {
        return platforms;
    }

    public void setPlatforms(List<String> platforms) {
        this.platforms = platforms;
    }

}
