public class ForecastEngine {

    /**
     * Recursive Approach
     * Time Complexity: O(n) where n is the number of years.
     * Space Complexity: O(n) due to the recursive call stack holding 'n' frames in memory.
     */
    public static double predictRecursive(Investment inv, int years) {
        if (inv == null || years < 0) return 0.0;
        
        // Use a private helper to avoid modifying the original Investment object
        return calculateRecursive(inv.getPresentValue(), inv.getAnnualGrowthRate(), years);
    }

    private static double calculateRecursive(double currentValue, double rate, int yearsRemaining) {
        //  Stop recursion when we run out of years
        if (yearsRemaining == 0) {
            return currentValue;
        }
        
        // Apply growth and decrement the years remaining
        double nextYearValue = currentValue * (1 + rate);
        return calculateRecursive(nextYearValue, rate, yearsRemaining - 1);
    }

    /**
     * Optimized Approach (Closed-Form Math)
     * Time Complexity: O(1) mathematically (or O(log n) depending on how Math.pow is implemented).
     * Space Complexity: O(1) because we use a mathematical formula instead of the call stack.
     */
    public static double predictOptimized(Investment inv, int years) {
        if (inv == null || years < 0) return 0.0;
        
        // Future Value = Present Value * (1 + rate)^years
        return inv.getPresentValue() * Math.pow(1 + inv.getAnnualGrowthRate(), years);
    }

    public static void main(String[] args) {
        // Starting with $5,000 at a 7% annual return rate
        Investment myPortfolio = new Investment(5000.00, 0.07);
        int forecastYears = 15;

        System.out.println("--- Starting Portfolio ---");
        System.out.println(myPortfolio);
        System.out.println("Forecasting for " + forecastYears + " years...\n");

        System.out.println("--- Recursive Algorithm Result ---");
        double recursiveResult = predictRecursive(myPortfolio, forecastYears);
        System.out.printf("Future Value: $%.2f%n\n", recursiveResult);

        System.out.println("--- Optimized Algorithm Result ---");
        double optimizedResult = predictOptimized(myPortfolio, forecastYears);
        System.out.printf("Future Value: $%.2f%n", optimizedResult);
        
        // edge cases
        System.out.println("\n--- Testing Edge Cases ---");
        Investment badData = new Investment(-1000, -5.0); // Should auto-correct to 0.0 and -1.0
        System.out.println("Handled Bad Input: " + badData);
    }
}