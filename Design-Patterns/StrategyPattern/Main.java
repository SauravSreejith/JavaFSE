public class Main {
    public static void main(String[] args) {
        System.out.println("=== Strategy Pattern ===\n");

        PaymentContext ctx = new PaymentContext(new CreditCardPayment());
        ctx.executePayment(100);

        ctx.setStrategy(new PayPalPayment());
        ctx.executePayment(50);
    }
}
