public class Main {
    public static void main(String[] args) {
        System.out.println("=== Factory Method ===\n");

        DocumentFactory f1 = new WordDocumentFactory();
        Document d1 = f1.createDocument("report.docx");
        d1.open();
        d1.save();

        Document d2 = new PdfDocumentFactory().createDocument("manual.pdf");
        d2.open();

        Document d3 = new ExcelDocumentFactory().createDocument(null);
        System.out.println("Type: " + d3.getType());
    }
}
