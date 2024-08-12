package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver for the Database Connection not found.", e);
        }
    }

    
    private static void initializeConnection() {
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/FWRP", "root", "Robin@123");
        } catch (SQLException e) {
            throw new RuntimeException("Error establishing database connection", e);
        }

    }

    
    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                initializeConnection();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error checking connection status", e);
        }
        return connection;
    }
}
