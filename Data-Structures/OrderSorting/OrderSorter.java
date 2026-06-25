public class OrderSorter {

    /**
     * Bubble Sort
     * Time Complexity: O(n^2) worst/average case. O(n) best case (if already sorted).
     */
    public static void bubbleSort(Order[] orders) {
        if (orders == null || orders.length <= 1) return;

        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            boolean isSorted = true; 
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
                    // Swap
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                    isSorted = false;
                }
            }
            // Break early.
            if (isSorted) break;
        }
    }

    /**
     * Quick Sort
     * Time Complexity: O(n log n) average case. O(n^2) worst case.
     */
    public static void quickSort(Order[] orders, int low, int high) {
        if (orders == null || orders.length <= 1) return;

        if (low < high) {
            int partitionIndex = partition(orders, low, high);
            quickSort(orders, low, partitionIndex - 1);
            quickSort(orders, partitionIndex + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].getTotalPrice();
        int smallerElementIndex = (low - 1);

        for (int j = low; j < high; j++) {
            if (orders[j].getTotalPrice() <= pivot) {
                smallerElementIndex++;
                // Swap
                Order temp = orders[smallerElementIndex];
                orders[smallerElementIndex] = orders[j];
                orders[j] = temp;
            }
        }
        // Swap the pivot into its correct position
        Order temp = orders[smallerElementIndex + 1];
        orders[smallerElementIndex + 1] = orders[high];
        orders[high] = temp;

        return smallerElementIndex + 1;
    }

    public static void main(String[] args) {
        Order[] ordersForBubble = {
            new Order("101", "Sarah", 150.50),
            new Order("102", "John", 45.00),
            new Order("103", "Emily", 300.75)
        };

        Order[] ordersForQuick = {
            new Order("201", "Michael", 85.20),
            new Order("202", "Dwight", 12.99),
            new Order("203", "Jim", 450.00)
        };

        System.out.println("--- Bubble Sort Results ---");
        bubbleSort(ordersForBubble);
        for (Order o : ordersForBubble) System.out.println(o);

        System.out.println("\n--- Quick Sort Results ---");
        quickSort(ordersForQuick, 0, ordersForQuick.length - 1);
        for (Order o : ordersForQuick) System.out.println(o);
    }
}