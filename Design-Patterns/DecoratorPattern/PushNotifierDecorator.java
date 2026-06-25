public class PushNotifierDecorator extends NotifierDecorator {
    public PushNotifierDecorator(Notifier n) { super(n); }

    public void send(String m) {
        super.send(m);
        System.out.println("PUSH: " + m);
    }
}
