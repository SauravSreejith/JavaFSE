public class PdfDocument implements Document {
    private String fileName;

    public PdfDocument(String name) {
        fileName = (name != null && !name.isEmpty()) ? name : "untitled.pdf";
    }

    public void open() { System.out.println("Opening " + fileName); }
    public void save() { System.out.println("Saving " + fileName); }
    public String getType() { return "PDF"; }
    public String toString() { return "PDF[" + fileName + "]"; }
}
