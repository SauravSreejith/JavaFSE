public class LightOnCommand implements Command {
    private Light light;

    public LightOnCommand(Light l) { light = l; }

    public void execute() { light.turnOn(); }
}
