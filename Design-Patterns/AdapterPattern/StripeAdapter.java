public class StripeAdapter implements PaymentProcessor {
    private StripeGateway gateway;

    public StripeAdapter(StripeGateway g) {
        gateway = g;
    }

    public void processPayment(double amt) {
        if (amt > 0) gateway.makeStripePayment(amt);
    }
}
