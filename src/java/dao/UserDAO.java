package dao;

import model.User;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // --- Helpers ---
    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        // password is optional to expose; usually avoid returning it unless needed
        try {
            u.setPassword(rs.getString("password")); // only present in some queries
        } catch (SQLException ignore) { /* column may not exist in SELECT */ }
        u.setRole(rs.getString("role"));
        u.setActive(rs.getBoolean("active"));
        return u;
    }

    // --- Login / validation ---
    public User validate(String username, String password) throws Exception {
        // Only allow active users to log in
        String sql = "SELECT id, username, password, role, active " +
                     "FROM users WHERE username=? AND password=? AND active=1";

        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return map(rs);
            }
        }
    }

    // --- Create (used by AdminUserCreateServlet) ---
    public void create(User u, String rawPassword) throws Exception {
        String sql = "INSERT INTO users (username, password, role, active) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, rawPassword); // TODO: replace with a hashed value in production
            ps.setString(3, u.getRole());
            ps.setBoolean(4, u.isActive());

            ps.executeUpdate();
        }
    }

    // --- Read: list with optional search ---
    public List<User> list(String q) throws Exception {
        List<User> out = new ArrayList<>();
        String base = "SELECT id, username, role, active FROM users";
        String sql = (q != null && !q.isBlank())
                ? base + " WHERE username LIKE ? ORDER BY id DESC"
                : base + " ORDER BY id DESC";

        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (q != null && !q.isBlank()) {
                ps.setString(1, "%" + q + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) out.add(map(rs));
            }
        }
        return out;
    }

    // --- Read: find by id ---
    public User find(int id) throws Exception {
        String sql = "SELECT id, username, role, active FROM users WHERE id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    // --- Update core fields (username, role, active) ---
    public void update(User u) throws Exception {
        String sql = "UPDATE users SET username=?, role=?, active=? WHERE id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getRole());
            ps.setBoolean(3, u.isActive());
            ps.setInt(4, u.getId());
            ps.executeUpdate();
        }
    }

    // --- Update password only ---
    public void updatePassword(int id, String newRaw) throws Exception {
        String sql = "UPDATE users SET password=? WHERE id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newRaw); // TODO: hash in production
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    // --- Update role only (optional helper) ---
    public void updateRole(int id, String role) throws Exception {
        String sql = "UPDATE users SET role=? WHERE id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, role);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    // --- Delete ---
    public void delete(int id) throws Exception {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
