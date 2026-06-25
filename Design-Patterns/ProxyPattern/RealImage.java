public class RealImage implements Image {
    private String fileName;

    public RealImage(String f) {
        fileName = f != null ? f : "img";
        System.out.println("Loading " + fileName + " from server...");
    }

    public void display() {
        System.out.println("Showing " + fileName);
    }
}
