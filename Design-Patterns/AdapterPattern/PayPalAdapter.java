public class PayPalAdapter implements PaymentProcessor {
    private PayPalGateway gateway;

    public PayPalAdapter(PayPalGateway g) { gateway = g; }

    public void processPayment(double amt) {
        if (amt > 0) gateway.sendPayPalPayment(amt, "USD");
    }
}
