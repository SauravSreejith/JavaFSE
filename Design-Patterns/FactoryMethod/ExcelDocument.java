public class ExcelDocument implements Document {
    private String fileName;

    public ExcelDocument(String name) {
        fileName = (name != null && !name.isEmpty()) ? name : "untitled.xlsx";
    }

    public void open() { System.out.println("Opening " + fileName); }
    public void save() { System.out.println("Saving " + fileName); }
    public String getType() { return "XLSX"; }
    public String toString() { return "Excel[" + fileName + "]"; }
}
