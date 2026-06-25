public class Main {
    public static void main(String[] args) {
        System.out.println("=== Proxy Pattern ===\n");

        Image img = new ProxyImage("photo.jpg");
        img.display();
        img.display();
        img.display();
    }
}
