public class WordDocument implements Document {
    private String fileName;

    public WordDocument(String name) {
        fileName = (name != null && !name.isEmpty()) ? name : "untitled.docx";
    }

    public void open() { System.out.println("Opening " + fileName); }
    public void save() { System.out.println("Saving " + fileName); }
    public String getType() { return "DOCX"; }

    public String toString() { return "Word[" + fileName + "]"; }
}
