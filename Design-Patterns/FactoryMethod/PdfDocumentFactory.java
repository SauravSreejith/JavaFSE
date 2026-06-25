public class PdfDocumentFactory extends DocumentFactory {
    public Document createDocument(String name) { return new PdfDocument(name); }
}
