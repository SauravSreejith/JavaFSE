public class PaymentContext {
    private PaymentStrategy strategy;

    public PaymentContext(PaymentStrategy s) {
        strategy = s;
    }

    public void setStrategy(PaymentStrategy s) {
        strategy = s;
    }

    // O(1)
    public void executePayment(double amt) { // O(1)
        strategy.pay(amt);
    }
}
