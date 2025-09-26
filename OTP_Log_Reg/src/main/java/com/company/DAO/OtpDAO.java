package com.company.DAO;


import java.sql.*;

import com.company.Util.DBUtil;

public class OtpDAO {

    // Insert OTP with timestamp
    public static void insertOtp(String email, String otp) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO otp_reg(email, otp, created_at) VALUES(?, ?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, otp);
            ps.executeUpdate();
        }
    }

    // Verify OTP (valid for 10 minutes)
    public static boolean verifyOtp(String email, String otp) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM otp_reg " +
                         "WHERE email=? AND otp=? " +
                         "AND created_at >= NOW() - INTERVAL 10 MINUTE " +
                         "ORDER BY id DESC LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, otp);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    // Clean up old OTPs after login
    public static void deleteOtp(String email) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM otp_reg WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.executeUpdate();
        }
    }
}
