public class SlackNotifierDecorator extends NotifierDecorator {
    public SlackNotifierDecorator(Notifier n) { super(n); }

    public void send(String m) {
        super.send(m);
        System.out.println("SLACK: " + m);
    }
}
