public class Main {
    public static void main(String[] args) {
        System.out.println("=== Adapter Pattern ===\n");

        new StripeAdapter(new StripeGateway()).processPayment(99.5);
        new PayPalAdapter(new PayPalGateway()).processPayment(25);
    }
}
