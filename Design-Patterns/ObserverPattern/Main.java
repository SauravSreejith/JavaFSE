public class Main {
    public static void main(String[] args) {
        System.out.println("=== Observer Pattern ===\n");

        StockMarket market = new StockMarket();

        market.registerObserver(new MobileApp("phone1"));
        market.registerObserver(new MobileApp("phone2"));
        market.registerObserver(new WebApp());

        // this should cause a resize
        market.registerObserver(new MobileApp("tablet"));

        market.setPrice("AAPL", 214.75);
        market.setPrice("GOOG", 178.3);

        market.deregisterObserver(new WebApp()); // note: different object, won't match

        System.out.println("\nObservers now: " + market.getObserverCount());
    }
}
