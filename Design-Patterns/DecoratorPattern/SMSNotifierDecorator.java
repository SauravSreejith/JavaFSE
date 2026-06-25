public class SMSNotifierDecorator extends NotifierDecorator {
    public SMSNotifierDecorator(Notifier n) { super(n); }

    public void send(String m) {
        super.send(m);
        System.out.println("SMS: " + m);
    }
}
