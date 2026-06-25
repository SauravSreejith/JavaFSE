public class Logger {

    private static Logger instance;  // the one and only

    private int logCount;

    private Logger() {
        logCount = 0;
        System.out.println("Logger created.");
    }

    // double checked for thread safety
    public static Logger getInstance() {
        if (instance == null) {
            synchronized (Logger.class) {
                if (instance == null) {
                    instance = new Logger();
                }
            }
        }
        return instance;
    }

    // O(1)
    public void log(String message) {
        if (message == null || message.trim().isEmpty()) {
            message = "[empty]";
        }
        logCount++;
        System.out.println("[LOG #" + logCount + "] " + message);
    }

    public int getLogCount() {
        return logCount;
    }

    @Override
    public String toString() {
        return "Logger[logs=" + logCount + "]";
    }
}
