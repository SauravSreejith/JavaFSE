public class WebApp implements Observer {
    @Override
    public void update(String symbol, double price) {
        System.out.println("  [web] " + symbol + " = $" + price);
    }
}
