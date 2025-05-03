package com.thegamingjourney.util;

import com.thegamingjourney.config.DbConfig;
import java.sql.Connection;

public class DbTest {
    public static void main(String[] args) {
        try (Connection conn = DbConfig.getDbConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Database connection successful!");
            } else {
                System.out.println("❌ Connection is null or closed.");
            }
        } catch (Exception e) {
            System.out.println("❌ Failed to connect to database:");
            e.printStackTrace();
        }
    }
}
