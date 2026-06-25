import java.util.HashMap;
import java.util.Map;

public class InventoryManager {
    // HashMap provides average O(1) time complexity for insertions and lookups.
    private final Map<String, Product> inventory = new HashMap<>();

    // Time Complexity: O(1) average
    public boolean addProduct(Product product) {
        if (product == null || inventory.containsKey(product.getProductId())) {
            return false; // Prevent adding nulls or duplicates
        }
        inventory.put(product.getProductId(), product);
        return true;
    }

    // Time Complexity: O(1) average
    public boolean updateProduct(String productId, int newQuantity, double newPrice) {
        Product existingProduct = inventory.get(productId);
        
        // Ensure the product actually exists before updating
        if (existingProduct != null) {
            existingProduct.setQuantity(newQuantity);
            existingProduct.setPrice(newPrice);
            return true;
        }
        return false;
    }

    // Time Complexity: O(1) average
    public boolean deleteProduct(String productId) {
        // remove() returns null if the key wasn't found
        return inventory.remove(productId) != null;
    }

    // Time Complexity: O(1) average
    public Product getProduct(String productId) {
        return inventory.get(productId);
    }

  
    public static void main(String[] args) {
        InventoryManager manager = new InventoryManager();
        
        manager.addProduct(new Product("P100", "Gaming Monitor", 25, 299.99));
        manager.addProduct(new Product("P101", "Mechanical Keyboard", 50, 89.50));

        System.out.println("Initial Lookup:");
        System.out.println(manager.getProduct("P100"));

        System.out.println("\nAfter Price Update:");
        manager.updateProduct("P100", 20, 275.00);
        System.out.println(manager.getProduct("P100"));
        
        System.out.println("\nTesting Edge Cases:");
        System.out.println("Update non-existent product: " + manager.updateProduct("P999", 1, 1.0));
    }
}