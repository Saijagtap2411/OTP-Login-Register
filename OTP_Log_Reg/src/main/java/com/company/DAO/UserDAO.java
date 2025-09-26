package com.company.DAO;


import java.sql.*;

import com.company.Util.DBUtil;

public class UserDAO {
    public static boolean isEmailRegistered(String email) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT 1 FROM usermasterbean1 WHERE email=? LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
    
    public static void registerUser(String name, String address, String email, String number, String gender) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO usermasterbean1 (name, address, email, number, gender) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, email);
            ps.setString(4, number);
            ps.setString(5, gender);
            ps.executeUpdate();
        }
    }
}
