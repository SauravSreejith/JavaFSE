public class WordDocumentFactory extends DocumentFactory {
    public Document createDocument(String name) {
        return new WordDocument(name);
    }
}
