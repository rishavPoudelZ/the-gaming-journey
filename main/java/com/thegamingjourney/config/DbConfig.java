package com.thegamingjourney.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DbConfig is a configuration class for managing database connections.
 * It handles the connection to a MySQL database using JDBC.
 */
public class DbConfig {

    // Database configuration
    private static final String DB_NAME = "tgj"; // <-- your database name
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME + "?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root"; // XAMPP default
    private static final String PASSWORD = "";     // Empty unless you've set one

    /**
     * Returns a connection to the configured MySQL database.
     *
     * @return Connection object
     * @throws SQLException if a database access error occurs
     * @throws ClassNotFoundException if the JDBC driver is not found
     */
    public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Ensures driver is loaded
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
