package dao;

import util.DBConnection;
import model.Bill;
import model.BillItem;

import java.sql.*;
import java.math.BigDecimal;
import java.util.*;

public class BillDAO {

    // Create a bill: insert bill header, add lines, reduce stock, compute total
    public int createBill(Integer customerId, int[] itemIds, int[] qtys) throws Exception {
        String insertBill = "INSERT INTO bills(customer_id, total) VALUES(?, 0)";
        String selectItem = "SELECT name, price, quantity FROM items WHERE item_id=?";
        String insertLine = "INSERT INTO bill_items(bill_id, item_id, qty, price) VALUES(?,?,?,?)";
        String updateStock = "UPDATE items SET quantity = quantity - ? WHERE item_id=? AND quantity >= ?";
        String updateTotal = "UPDATE bills SET total=? WHERE id=?";

        try (Connection con = DBConnection.initializeDatabase()) {
            con.setAutoCommit(false);
            try (PreparedStatement psBill = con.prepareStatement(insertBill, Statement.RETURN_GENERATED_KEYS)) {
                if (customerId == null) psBill.setNull(1, Types.INTEGER); else psBill.setInt(1, customerId);
                psBill.executeUpdate();
                int billId;
                try (ResultSet keys = psBill.getGeneratedKeys()) { keys.next(); billId = keys.getInt(1); }

                BigDecimal total = BigDecimal.ZERO;

                for (int i = 0; i < itemIds.length; i++) {
                    int itemId = itemIds[i];
                    int qty = qtys[i];
                    if (qty <= 0) continue;

                    String itemName;
                    BigDecimal price;
                    int stock;

                    try (PreparedStatement psSel = con.prepareStatement(selectItem)) {
                        psSel.setInt(1, itemId);
                        try (ResultSet rs = psSel.executeQuery()) {
                            if (!rs.next()) throw new SQLException("Item not found: " + itemId);
                            itemName = rs.getString("name");
                            price    = rs.getBigDecimal("price");
                            stock    = rs.getInt("quantity");
                            if (stock < qty) throw new SQLException("Insufficient stock for item: " + itemName);
                        }
                    }

                    try (PreparedStatement psLine = con.prepareStatement(insertLine)) {
                        psLine.setInt(1, billId);
                        psLine.setInt(2, itemId);
                        psLine.setInt(3, qty);
                        psLine.setBigDecimal(4, price);
                        psLine.executeUpdate();
                    }

                    try (PreparedStatement psUpd = con.prepareStatement(updateStock)) {
                        psUpd.setInt(1, qty);
                        psUpd.setInt(2, itemId);
                        psUpd.setInt(3, qty);
                        int changed = psUpd.executeUpdate();
                        if (changed == 0) throw new SQLException("Stock update failed for item " + itemId);
                    }

                    total = total.add(price.multiply(BigDecimal.valueOf(qty)));
                }

                try (PreparedStatement psUpdTot = con.prepareStatement(updateTotal)) {
                    psUpdTot.setBigDecimal(1, total);
                    psUpdTot.setInt(2, billId);
                    psUpdTot.executeUpdate();
                }

                con.commit();
                return billId;
            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public Bill getBill(int billId) throws Exception {
        String sqlBill  = "SELECT id, customer_id, total, created_at FROM bills WHERE id=?";
        String sqlItems = "SELECT bi.item_id, i.name, bi.qty, bi.price FROM bill_items bi JOIN items i ON i.item_id=bi.item_id WHERE bi.bill_id=?";

        try (Connection con = DBConnection.initializeDatabase()) {
            Bill b = null;
            try (PreparedStatement ps = con.prepareStatement(sqlBill)) {
                ps.setInt(1, billId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        b = new Bill();
                        b.setId(rs.getInt("id"));
                        b.setCustomerId((Integer) rs.getObject("customer_id"));
                        b.setTotal(rs.getBigDecimal("total"));
                        b.setCreatedAt(rs.getTimestamp("created_at").toString());
                    }
                }
            }
            if (b == null) return null;

            List<BillItem> items = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement(sqlItems)) {
                ps.setInt(1, billId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        BillItem bi = new BillItem();
                        bi.setItemId(rs.getInt("item_id"));
                        bi.setItemName(rs.getString("name"));
                        bi.setQty(rs.getInt("qty"));
                        BigDecimal price = rs.getBigDecimal("price");
                        bi.setPrice(price);
                        bi.setLineTotal(price.multiply(BigDecimal.valueOf(bi.getQty())));
                        items.add(bi);
                    }
                }
            }
            b.setItems(items);
            return b;
        }
    }

    public List<Bill> listBillsLast30() throws Exception {
        String sql = "SELECT id, customer_id, total, created_at FROM bills " +
                     "WHERE created_at >= NOW() - INTERVAL 30 DAY ORDER BY id DESC";
        List<Bill> list = new ArrayList<>();
        try (Connection con = DBConnection.initializeDatabase();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("id"));
                b.setCustomerId((Integer) rs.getObject("customer_id"));
                b.setTotal(rs.getBigDecimal("total"));
                b.setCreatedAt(rs.getTimestamp("created_at").toString());
                list.add(b);
            }
        }
        return list;
    }
}
