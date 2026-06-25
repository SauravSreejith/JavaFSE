import java.util.Arrays;

public class StockMarket implements Stock {

    private Observer[] observers = new Observer[2];
    private int size;
    private String symbol;
    private double price;

    // register - O(1) most times, O(n) on resize
    @Override
    public void registerObserver(Observer o) {
        if (o == null) return;

        // no duplicates
        for (int i = 0; i < size; i++) {
            if (observers[i] == o) return;
        }

        if (size == observers.length) {
            observers = Arrays.copyOf(observers, observers.length * 2); // resize O(n)
            System.out.println("  (resized)");
        }
        observers[size++] = o;
    }

    @Override
    public void deregisterObserver(Observer o) {
        for (int i = 0; i < size; i++) {
            if (observers[i] == o) {
                for (int j = i; j < size - 1; j++) {
                    observers[j] = observers[j + 1];
                }
                observers[--size] = null;
                return;
            }
        }
    }

    // O(n)
    @Override
    public void notifyObservers() {
        for (int i = 0; i < size; i++) {
            observers[i].update(symbol, price);
        }
    }

    public void setPrice(String sym, double p) {
        this.symbol = (sym != null) ? sym.toUpperCase() : "UNK";
        this.price = p;
        System.out.println("\nPrice updated: " + symbol + " = $" + price);
        notifyObservers();
    }

    public int getObserverCount() {
        return size;
    }
}
