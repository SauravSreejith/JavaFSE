public class RemoteControl {
    private Command cmd;

    public void setCommand(Command c) {
        cmd = c;
    }

    public void pressButton() {
        if (cmd != null) cmd.execute();
    }
}
