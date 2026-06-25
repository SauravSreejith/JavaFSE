public class Light {
    private boolean on;

    public void turnOn() {
        on = true;
        System.out.println("Light ON");
    }

    public void turnOff() {
        on = false;
        System.out.println("Light OFF");
    }

    public String toString() {
        return "Light[" + (on ? "on" : "off") + "]";
    }
}
