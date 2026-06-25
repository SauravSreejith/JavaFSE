public class LightOffCommand implements Command {
    private Light light;

    public LightOffCommand(Light l) { light = l; }

    public void execute() { light.turnOff(); }
}
