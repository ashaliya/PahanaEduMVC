package dao;

import model.Customer;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    /* ---------- helpers to be schema-tolerant ---------- */

    private boolean hasColumn(Connection con, String table, String column) throws SQLException {
        try (ResultSet rs = con.getMetaData().getColumns(null, null, table, column)) {
            return rs.next();
        }
    }

    private String safeGetString(ResultSet rs, String col) {
        try { return rs.getString(col); } catch (SQLException ignore) { return null; }
    }
    private Integer safeGetInt(ResultSet rs, String col) {
        try {
            int v = rs.getInt(col);
            return rs.wasNull() ? null : v;
        } catch (SQLException ignore) { return null; }
    }

    /* ---------- existence ---------- */

    public boolean exists(int accountNumber) throws Exception {
        String sql = "SELECT 1 FROM customers WHERE account_number=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /* ---------- create ---------- */

    /** Create customer. Writes to columns that exist in your DB (email / units_consumed optional). */
    public void create(Customer c) throws Exception {
        try (Connection con = DBConnection.initializeDatabase()) {

            boolean hasEmail  = hasColumn(con, "customers", "email");
            boolean hasUnits  = hasColumn(con, "customers", "units_consumed");

            StringBuilder cols = new StringBuilder("account_number,name,address,phone");
            StringBuilder vals = new StringBuilder("?,?,?,?");

            if (hasEmail) { cols.append(",email"); vals.append(",?"); }
            if (hasUnits) { cols.append(",units_consumed"); vals.append(",?"); }

            String sql = "INSERT INTO customers(" + cols + ") VALUES(" + vals + ")";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                int i = 1;
                ps.setInt(i++, c.getAccountNumber());
                ps.setString(i++, c.getName());
                ps.setString(i++, c.getAddress());
                ps.setString(i++, c.getPhone());

                if (hasEmail) {
                    ps.setString(i++, c.getEmail()); // may be null
                }
                if (hasUnits) {
                    // if your model doesn’t have units, this will be 0 by default
                    ps.setInt(i++, c.getUnitsConsumed());
                }

                ps.executeUpdate();
            }
        }
    }

    /* ---------- update ---------- */

    /** Update by account_number. Only updates columns present in your DB. */
    public void update(Customer c) throws Exception {
        try (Connection con = DBConnection.initializeDatabase()) {

            boolean hasEmail = hasColumn(con, "customers", "email");
            boolean hasUnits = hasColumn(con, "customers", "units_consumed");

            StringBuilder set = new StringBuilder("name=?, address=?, phone=?");
            if (hasEmail) set.append(", email=?");
            if (hasUnits) set.append(", units_consumed=?");

            String sql = "UPDATE customers SET " + set + " WHERE account_number=?";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                int i = 1;
                ps.setString(i++, c.getName());
                ps.setString(i++, c.getAddress());
                ps.setString(i++, c.getPhone());
                if (hasEmail)  ps.setString(i++, c.getEmail());
                if (hasUnits)  ps.setInt(i++, c.getUnitsConsumed());
                ps.setInt(i, c.getAccountNumber());
                ps.executeUpdate();
            }
        }
    }

    /* ---------- read (single) ---------- */

    public Customer findByAccount(int accountNumber) throws Exception {
        String sql = "SELECT * FROM customers WHERE account_number=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                Customer c = new Customer();
                c.setAccountNumber(rs.getInt("account_number"));
                c.setName(safeGetString(rs, "name"));
                c.setAddress(safeGetString(rs, "address"));
                c.setPhone(safeGetString(rs, "phone"));

                // optional columns
                c.setEmail(safeGetString(rs, "email"));
                Integer units = safeGetInt(rs, "units_consumed");
                if (units != null) c.setUnitsConsumed(units);

                return c;
            }
        }
    }

    /* ---------- search/list ---------- */

    /** Search by name or phone. Empty/null q returns all, ordered by name. */
    public List<Customer> search(String q) throws Exception {
        List<Customer> list = new ArrayList<>();
        String like = (q == null || q.isBlank()) ? "%" : "%" + q.trim() + "%";

        String sql = "SELECT * FROM customers " +
                     "WHERE name LIKE ? OR phone LIKE ? " +
                     "ORDER BY name ASC";

        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, like);
            ps.setString(2, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer c = new Customer();
                    c.setAccountNumber(rs.getInt("account_number"));
                    c.setName(safeGetString(rs, "name"));
                    c.setAddress(safeGetString(rs, "address"));
                    c.setPhone(safeGetString(rs, "phone"));

                    // optional columns
                    c.setEmail(safeGetString(rs, "email"));
                    Integer units = safeGetInt(rs, "units_consumed");
                    if (units != null) c.setUnitsConsumed(units);

                    list.add(c);
                }
            }
        }
        return list;
    }

    /** Return all customers (small datasets). */
    public List<Customer> findAll() throws Exception {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY name ASC";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = new Customer();
                c.setAccountNumber(rs.getInt("account_number"));
                c.setName(safeGetString(rs, "name"));
                c.setAddress(safeGetString(rs, "address"));
                c.setPhone(safeGetString(rs, "phone"));

                // optional columns
                c.setEmail(safeGetString(rs, "email"));
                Integer units = safeGetInt(rs, "units_consumed");
                if (units != null) c.setUnitsConsumed(units);

                list.add(c);
            }
        }
        return list;
    }

    /* ---------- delete ---------- */

    public void delete(int accountNumber) throws Exception {
        String sql = "DELETE FROM customers WHERE account_number=?";
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, accountNumber);
            ps.executeUpdate();
        }
    }
}
