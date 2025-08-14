package dao;

import util.DBConnection;
import model.Item;

import java.sql.*;
import java.math.BigDecimal;
import java.util.*;

public class ItemDAO {

    // ---- List with search + sort + pagination ----
    public List<Item> list(String q, String sort, String dir, int limit, int offset) throws Exception {
        String orderBy = switch (sort == null ? "name" : sort) {
            case "price" -> "price";
            case "quantity" -> "quantity";
            default -> "name";
        };
        String direction = "DESC".equalsIgnoreCase(dir) ? "DESC" : "ASC";

        String sql = "SELECT item_id, name, price, quantity FROM items " +
                     "WHERE (? IS NULL OR name LIKE ?) " +
                     "ORDER BY " + orderBy + " " + direction + " " +
                     "LIMIT ? OFFSET ?";

        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (q == null || q.isBlank()) {
                ps.setNull(1, Types.VARCHAR);
                ps.setNull(2, Types.VARCHAR);
            } else {
                ps.setString(1, q);
                ps.setString(2, "%" + q + "%");
            }
            ps.setInt(3, limit);
            ps.setInt(4, offset);

            List<Item> items = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item it = new Item();
                    it.setItemId(rs.getInt("item_id"));
                    it.setName(rs.getString("name"));
                    it.setPrice(rs.getBigDecimal("price"));
                    it.setQuantity(rs.getInt("quantity"));
                    items.add(it);
                }
            }
            return items;
        }
    }

    public int count(String q) throws Exception {
        String sql = "SELECT COUNT(*) FROM items WHERE (? IS NULL OR name LIKE ?)";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (q == null || q.isBlank()) {
                ps.setNull(1, Types.VARCHAR);
                ps.setNull(2, Types.VARCHAR);
            } else {
                ps.setString(1, q);
                ps.setString(2, "%" + q + "%");
            }
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }

    // ---- CRUD ----
    public Item find(int id) throws Exception {
        String sql = "SELECT item_id, name, price, quantity FROM items WHERE item_id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Item it = new Item();
                it.setItemId(rs.getInt("item_id"));
                it.setName(rs.getString("name"));
                it.setPrice(rs.getBigDecimal("price"));
                it.setQuantity(rs.getInt("quantity"));
                return it;
            }
        }
    }

    public void create(Item it) throws Exception {
        String sql = "INSERT INTO items(name, price, quantity) VALUES(?,?,?)";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, it.getName());
            ps.setBigDecimal(2, it.getPrice() == null ? new BigDecimal("0.00") : it.getPrice());
            ps.setInt(3, it.getQuantity());
            ps.executeUpdate();
        }
    }

    public void update(Item it) throws Exception {
        String sql = "UPDATE items SET name=?, price=?, quantity=? WHERE item_id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, it.getName());
            ps.setBigDecimal(2, it.getPrice());
            ps.setInt(3, it.getQuantity());
            ps.setInt(4, it.getItemId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws Exception {
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement("DELETE FROM items WHERE item_id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ---- Stock adjustment ----
    public void restock(int id, int delta) throws Exception {
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(
                "UPDATE items SET quantity = quantity + ? WHERE item_id=?")) {
            ps.setInt(1, delta);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }
}
