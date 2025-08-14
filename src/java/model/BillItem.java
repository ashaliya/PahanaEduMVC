package model;
import java.math.BigDecimal;
public class BillItem {
    private int id;
    private int billId;
    private int itemId;
    private String itemName;
    private int qty;
    private BigDecimal price;
    private BigDecimal lineTotal;
    public int getId(){ return id; }
    public void setId(int id){ this.id = id; }
    public int getBillId(){ return billId; }
    public void setBillId(int billId){ this.billId = billId; }
    public int getItemId(){ return itemId; }
    public void setItemId(int itemId){ this.itemId = itemId; }
    public String getItemName(){ return itemName; }
    public void setItemName(String itemName){ this.itemName = itemName; }
    public int getQty(){ return qty; }
    public void setQty(int qty){ this.qty = qty; }
    public java.math.BigDecimal getPrice(){ return price; }
    public void setPrice(java.math.BigDecimal price){ this.price = price; }
    public java.math.BigDecimal getLineTotal(){ return lineTotal; }
    public void setLineTotal(java.math.BigDecimal lineTotal){ this.lineTotal = lineTotal; }
}
