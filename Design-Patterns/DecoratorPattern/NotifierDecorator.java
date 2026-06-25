public abstract class NotifierDecorator implements Notifier {
    protected Notifier wrapped;

    public NotifierDecorator(Notifier n) {
        wrapped = n;
    }

    public void send(String m) {
        wrapped.send(m);
    }
}
