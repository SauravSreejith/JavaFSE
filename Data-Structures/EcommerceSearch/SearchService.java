import java.util.Arrays;
import java.util.Comparator;

public class SearchService {

    /**
     * Linear Search
     * Time Complexity: O(n) worst-case.
     */
    public static SearchProduct linearSearch(SearchProduct[] products, String targetName) {
        if (products == null || targetName == null) return null;

        for (SearchProduct product : products) {
            // Case-insensitive comparison is a great real-world feature
            if (product.getProductName().equalsIgnoreCase(targetName)) {
                return product;
            }
        }
        return null;
    }

    /**
     * Binary Search
     * Time Complexity: O(log n) worst-case.
     */
    public static SearchProduct binarySearch(SearchProduct[] sortedProducts, String targetName) {
        if (sortedProducts == null || targetName == null) return null;

        int left = 0;
        int right = sortedProducts.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int comparison = sortedProducts[mid].getProductName().compareToIgnoreCase(targetName);

            if (comparison == 0) {
                return sortedProducts[mid]; // Found it
            } else if (comparison < 0) {
                left = mid + 1; // Target is in the right half
            } else {
                right = mid - 1; // Target is in the left half
            }
        }
        return null; 
    }

    public static void main(String[] args) {
        SearchProduct[] inventory = {
            new SearchProduct("E01", "USB-C Cable", "Electronics"),
            new SearchProduct("E02", "Laptop Stand", "Office"),
            new SearchProduct("E03", "Bluetooth Mouse", "Electronics"),
            new SearchProduct("E04", "Desk Mat", "Office")
        };

        System.out.println("--- Linear Search ---");
        // We can search the unsorted array directly
        SearchProduct found = linearSearch(inventory, "bluetooth mouse");
        System.out.println("Result: " + (found != null ? found : "Not Found"));

        System.out.println("\n--- Binary Search ---");
        // We must sort the array first for binary search to work
        SearchProduct[] sortedInventory = inventory.clone();
        Arrays.sort(sortedInventory, Comparator.comparing(SearchProduct::getProductName, String.CASE_INSENSITIVE_ORDER));
        
        SearchProduct foundBinary = binarySearch(sortedInventory, "desk mat");
        System.out.println("Result: " + (foundBinary != null ? foundBinary : "Not Found"));
    }
}