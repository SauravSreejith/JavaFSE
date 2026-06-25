import java.util.Arrays;
import java.util.Comparator;

public class LibraryCatalog {

    /**
     * Linear Search
     * Time Complexity: O(n) worst-case.
     */
    public static Book findBookLinear(Book[] catalog, String searchTitle) {
        if (catalog == null || searchTitle == null) return null;

        for (Book book : catalog) {
            if (book != null && book.getTitle().equalsIgnoreCase(searchTitle)) {
                return book;
            }
        }
        return null;
    }

    /**
     * Binary Search
     * Time Complexity: O(log n) worst-case.
     */
    public static Book findBookBinary(Book[] sortedCatalog, String searchTitle) {
        if (sortedCatalog == null || searchTitle == null) return null;

        int left = 0;
        int right = sortedCatalog.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            // check for null elements inside the array
            if (sortedCatalog[mid] == null) {
                return null; 
            }

            int comparison = sortedCatalog[mid].getTitle().compareToIgnoreCase(searchTitle);

            if (comparison == 0) {
                return sortedCatalog[mid]; // Found the exact match
            } else if (comparison < 0) {
                left = mid + 1; // Search the right half
            } else {
                right = mid - 1; // Search the left half
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Book[] library = {
            new Book("B01", "The Pragmatic Programmer", "Andrew Hunt"),
            new Book("B02", "Clean Code", "Robert C. Martin"),
            new Book("B03", "Design Patterns", "Erich Gamma"),
            new Book("B04", "Refactoring", "Martin Fowler")
        };

        System.out.println("--- Linear Search (Unsorted Array) ---");
        Book found1 = findBookLinear(library, "clean code");
        System.out.println(found1 != null ? found1 : "Book not found.");

        System.out.println("\n--- Binary Search (Sorted Array) ---");
        // Create a copy and sort it to satisfy the Binary Search prerequisite
        Book[] sortedLibrary = library.clone();
        Arrays.sort(sortedLibrary, Comparator.comparing(Book::getTitle, String.CASE_INSENSITIVE_ORDER));
        
        Book found2 = findBookBinary(sortedLibrary, "refactoring");
        System.out.println(found2 != null ? found2 : "Book not found.");
    }
}