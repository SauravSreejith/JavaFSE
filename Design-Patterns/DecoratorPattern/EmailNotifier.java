public class EmailNotifier implements Notifier {
    private String to;

    public EmailNotifier(String to) {
        this.to = (to != null) ? to : "default@ex.com";
    }

    public void send(String msg) {
        if (msg == null) msg = "";
        System.out.println("EMAIL: " + msg);
    }
}
