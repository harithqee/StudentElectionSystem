package com.election.controller;

import com.election.model.UserBean;
import java.sql.*;

public class UserDAO {
    
    // 1. Derby Configuration
    // ;create=true tells Derby to build the database if it's missing
    private static final String JDBC_URL = "jdbc:derby://localhost:1527/StudentElection;create=true";
    private static final String JDBC_USER = "app";
    private static final String JDBC_PASS = "app";

    // 2. Connection Helper
    private Connection getConnection() throws Exception {
        // Load Derby Client Driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
    }

    // METHOD 1: Authenticate User
    public UserBean authenticateUser(String username, String password, String role) {
        UserBean user = null;
        String sql = "";

        if (role.equals("student")) {
            sql = "SELECT * FROM Student WHERE studentId=? AND password=?";
        } else if (role.equals("lecturer")) {
            sql = "SELECT * FROM Lecturer WHERE LecturerID=? AND password=?";
        } else if (role.equals("admin")) {
            sql = "SELECT * FROM Admin WHERE adminID=? AND password=?";
        }

        try (Connection conn = getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setString(1, username);
            pst.setString(2, password);
            
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new UserBean();
                    user.setRole(role);
                    user.setPassword(password);
                    
                    if (role.equals("student")) {
                        user.setId(rs.getString("studentId"));
                        user.setName(rs.getString("studentName"));
                        user.setFaculty(rs.getString("faculty"));
                    } else if (role.equals("lecturer")) {
                        user.setId(rs.getString("LecturerID"));
                        user.setName(rs.getString("lecturerName"));
                        user.setFaculty(rs.getString("faculty"));
                    } else if (role.equals("admin")) {
                        user.setId(rs.getString("adminID"));
                        user.setName(rs.getString("name"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // METHOD 2: Register User
    public String registerUser(UserBean user) {
        String sql = "";
        
        if (user.getRole().equals("student")) {
            sql = "INSERT INTO Student (studentId, studentName, email, faculty, password) VALUES (?, ?, ?, ?, ?)";
        } else if (user.getRole().equals("lecturer")) {
            sql = "INSERT INTO Lecturer (LecturerID, lecturerName, email, faculty, password) VALUES (?, ?, ?, ?, ?)";
        } else if (user.getRole().equals("admin")) {
            sql = "INSERT INTO Admin (adminID, name, email, password) VALUES (?, ?, ?, ?)";
        }

        try (Connection conn = getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            if (user.getRole().equals("admin")) {
                pst.setString(1, user.getId());
                pst.setString(2, user.getName());
                pst.setString(3, user.getEmail());
                pst.setString(4, user.getPassword());
            } else {
                pst.setString(1, user.getId());
                pst.setString(2, user.getName());
                pst.setString(3, user.getEmail());
                pst.setString(4, user.getFaculty());
                pst.setString(5, user.getPassword());
            }

            pst.executeUpdate();
            return "SUCCESS";

        } catch (SQLIntegrityConstraintViolationException e) {
            return "ID already exists!";
        } catch (Exception e) {
            e.printStackTrace();
            return "Database Error: " + e.getMessage();
        }
    }
}