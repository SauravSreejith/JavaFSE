public class Main {
    public static void main(String[] args) {
        System.out.println("=== Command Pattern ===\n");

        Light light = new Light();
        RemoteControl rc = new RemoteControl();

        rc.setCommand(new LightOnCommand(light));
        rc.pressButton();

        rc.setCommand(new LightOffCommand(light));
        rc.pressButton();
    }
}
