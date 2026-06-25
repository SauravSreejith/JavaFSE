public class Investment {
    private double presentValue;
    private double annualGrowthRate; // Represented as a decimal (e.g., 0.05 for 5%)

    public Investment(double presentValue, double annualGrowthRate) {
        setPresentValue(presentValue);
        setAnnualGrowthRate(annualGrowthRate);
    }

    public double getPresentValue() { return presentValue; }
    
    public void setPresentValue(double presentValue) {
        //  You can't start with negative money
        if (presentValue >= 0.0) {
            this.presentValue = presentValue;
        } else {
            this.presentValue = 0.0;
        }
    }

    public double getAnnualGrowthRate() { return annualGrowthRate; }
    
    public void setAnnualGrowthRate(double annualGrowthRate) {
        //  A total loss is -1.0. It can't drop lower than that.
        if (annualGrowthRate >= -1.0) {
            this.annualGrowthRate = annualGrowthRate;
        } else {
            this.annualGrowthRate = -1.0;
        }
    }

    @Override
    public String toString() {
        return String.format("Investment [Value: $%.2f | Growth Rate: %.2f%%]", 
                presentValue, (annualGrowthRate * 100));
    }
}