public class Order {
    private String orderId;
    private String customerName;
    private double totalPrice;

    public Order(String orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    // Encapsulation
    public String getOrderId() { return orderId; }
    public String getCustomerName() { return customerName; }
    
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) {
        // Defensive check
        if (totalPrice >= 0.0) {
            this.totalPrice = totalPrice;
        }
    }

    @Override
    public String toString() {
        return String.format("Order [%s] | %s | Total: $%.2f", 
                orderId, customerName, totalPrice);
    }
}