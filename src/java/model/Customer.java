package model;
public class Customer {
    private int accountNumber;
    private String name;
    private String address;
    private String phone;
    private String email;
    private int unitsConsumed;
    
    public int getAccountNumber(){ return accountNumber; }
    public void setAccountNumber(int accountNumber){ this.accountNumber = accountNumber; }
    
    public String getName(){ return name; }
    public void setName(String name){ this.name = name; }
  
    public String getAddress(){ return address; }
    public void setAddress(String address){ this.address = address; }
    
    public String getPhone(){ return phone; }
    public void setPhone(String phone){ this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public int getUnitsConsumed(){ return unitsConsumed; }
    public void setUnitsConsumed(int unitsConsumed){ this.unitsConsumed = unitsConsumed; }
}
