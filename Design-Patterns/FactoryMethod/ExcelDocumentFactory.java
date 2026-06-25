public class ExcelDocumentFactory extends DocumentFactory {
    public Document createDocument(String name) { return new ExcelDocument(name); }
}
