package dao;

import util.DBConnection;
import java.sql.*;
import java.util.*;

public class ReportDAO {

    public List<Map<String,Object>> topSellers30d() throws Exception {
        String sql = """
            SELECT i.name AS itemName, COALESCE(SUM(bi.qty),0) AS totalQty
            FROM bill_items bi
            JOIN items i ON i.item_id = bi.item_id
            JOIN bills b ON b.id = bi.bill_id
            WHERE b.created_at >= NOW() - INTERVAL 30 DAY
            GROUP BY i.name
            ORDER BY totalQty DESC
            LIMIT 10
        """;
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Map<String,Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String,Object> row = new HashMap<>();
                row.put("itemName", rs.getString("itemName"));
                row.put("totalQty", rs.getInt("totalQty"));
                list.add(row);
            }
            return list;
        }
    }

    public List<Map<String,Object>> revenueDaily30d() throws Exception {
        String sql = """
            SELECT DATE(b.created_at) AS day, COALESCE(SUM(b.total),0) AS total
            FROM bills b
            WHERE b.created_at >= NOW() - INTERVAL 30 DAY
            GROUP BY DATE(b.created_at)
            ORDER BY day
        """;
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Map<String,Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String,Object> row = new HashMap<>();
                row.put("day", rs.getDate("day").toString());
                row.put("total", rs.getBigDecimal("total"));
                list.add(row);
            }
            return list;
        }
    }

    public int totalUsers() throws Exception {
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users");
             ResultSet rs = ps.executeQuery()) {
            rs.next(); return rs.getInt(1);
        }
    }

    public int totalItems() throws Exception {
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM items");
             ResultSet rs = ps.executeQuery()) {
            rs.next(); return rs.getInt(1);
        }
    }

    public int totalCustomers() throws Exception {
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM customers");
             ResultSet rs = ps.executeQuery()) {
            rs.next(); return rs.getInt(1);
        }
    }

    public String revenueLast30dFormatted() throws Exception {
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement("SELECT COALESCE(SUM(total),0) FROM bills WHERE created_at >= NOW() - INTERVAL 30 DAY");
             ResultSet rs = ps.executeQuery()) {
            rs.next(); return rs.getBigDecimal(1).toPlainString();
        }
    }
}
