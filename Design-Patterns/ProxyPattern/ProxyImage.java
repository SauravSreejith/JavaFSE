public class ProxyImage implements Image {
    private RealImage real;
    private String fileName;

    public ProxyImage(String f) {
        fileName = f != null ? f : "default.jpg";
    }

    // O(1) after first load
    public void display() {
        if (real == null) {
            real = new RealImage(fileName);
        } else {
            System.out.println("(from cache)");
        }
        real.display();
    }
}
