public class Product {
    private String productId;
    private String productName;
    private int quantity;
    private double price;

    public Product(String productId, String productName, int quantity, double price) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    // Encapsulation
    public String getProductId() { return productId; }
    public String getProductName() { return productName; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { 
        //  Don't allow negative inventory
        if(quantity >= 0) {
            this.quantity = quantity; 
        }
    }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { 
        if(price >= 0.0) {
            this.price = price; 
        }
    }

    // Makes printing the object human-readable
    @Override
    public String toString() {
        return String.format("[%s] %s | Qty: %d | Price: $%.2f", 
                productId, productName, quantity, price);
    }
}