public class Main {
    public static void main(String[] args) {
        System.out.println("=== Singleton Pattern Test ===\n");

        Logger log1 = Logger.getInstance();
        log1.log("App started");

        Logger log2 = Logger.getInstance();
        log2.log(null);

        Logger log3 = Logger.getInstance();
        log3.log("User logged in");

        System.out.println();
        System.out.println("Same instance? " + (log1 == log2 && log2 == log3));
        System.out.println("Total logs: " + log1.getLogCount());

        System.out.println("\nDone.");
    }
}
