public class Main {
    public static void main(String[] args) {
        System.out.println("=== Decorator Pattern ===\n");

        Notifier n = new EmailNotifier("a@b.com");
        n.send("hello");

        Notifier n2 = new SMSNotifierDecorator(new EmailNotifier("x@y.com"));
        n2.send("deploy done");

        Notifier all = new PushNotifierDecorator(new SlackNotifierDecorator(n2));
        all.send("alert!");
    }
}
