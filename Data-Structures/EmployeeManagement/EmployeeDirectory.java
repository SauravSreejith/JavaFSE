import java.util.Arrays;

public class EmployeeDirectory {
    private Employee[] directory;
    private int activeCount; 

    public EmployeeDirectory(int initialCapacity) {
        //  check to ensure we don't initialize a negative array
        int safeCapacity = Math.max(initialCapacity, 1);
        this.directory = new Employee[safeCapacity];
        this.activeCount = 0;
    }

    /**
     * Add Employee
     * Time Complexity: O(1) amortized. O(n) worst-case if resizing is triggered.
     */
    public void addEmployee(Employee emp) {
        if (emp == null) return;

        // Dynamic Resizing: If the array is full, double its size.
        if (activeCount == directory.length) {
            directory = Arrays.copyOf(directory, directory.length * 2);
        }
        
        directory[activeCount] = emp;
        activeCount++;
    }

    /**
     * Search Employee
     * Time Complexity: O(n) worst-case.
     */
    public Employee searchEmployee(String employeeId) {
        if (employeeId == null) return null;

        for (int i = 0; i < activeCount; i++) {
            if (directory[i].getEmployeeId().equalsIgnoreCase(employeeId)) {
                return directory[i];
            }
        }
        return null;
    }

    /**
     * Delete Employee
     * Time Complexity: O(n) worst-case because we have to shift elements left to fill the gap.
     */
    public boolean deleteEmployee(String employeeId) {
        if (employeeId == null) return false;

        for (int i = 0; i < activeCount; i++) {
            if (directory[i].getEmployeeId().equalsIgnoreCase(employeeId)) {
                // Shift remaining elements to the left to close the gap
                for (int j = i; j < activeCount - 1; j++) {
                    directory[j] = directory[j + 1];
                }
                
                // Clear the last element and reduce count
                directory[activeCount - 1] = null;
                activeCount--;
                return true;
            }
        }
        return false;
    }

    /**
     * Traverse Employees
     * Time Complexity: O(n)
     */
    public void printDirectory() {
        if (activeCount == 0) {
            System.out.println("Directory is empty.");
            return;
        }
        for (int i = 0; i < activeCount; i++) {
            System.out.println(directory[i]);
        }
    }

    public static void main(String[] args) {
        // Start with a small capacity to force our dynamic resize logic to trigger
        EmployeeDirectory system = new EmployeeDirectory(2);
        
        system.addEmployee(new Employee("EMP01", "Alice", "Engineer", 90000));
        system.addEmployee(new Employee("EMP02", "Bob", "HR Manager", 75000));
        
        system.addEmployee(new Employee("EMP03", "Charlie", "Director", 120000));

        System.out.println("--- Full Directory ---");
        system.printDirectory();

        System.out.println("\n--- Search Result ---");
        System.out.println(system.searchEmployee("emp02")); // Testing case-insensitivity

        System.out.println("\n--- After Deleting EMP01 ---");
        system.deleteEmployee("EMP01");
        system.printDirectory();
    }
}