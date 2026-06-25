public class TaskManager {

    //  Encapsulates the Node logic so outside classes don't mess with it
    private static class Node {
        Task data;
        Node next;

        Node(Task data) {
            this.data = data;
            this.next = null;
        }
    }

    private Node head;
    private Node tail; // Keeps track of the end of the list

    /**
     * Add Task (Append to end)
     * Time Complexity: O(1) worst-case. 
     */
    public void addTask(Task task) {
        if (task == null) return;

        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode; // Update tail to the new last node
        }
    }

    /**
     * Search Task
     * Time Complexity: O(n) worst-case (must traverse the list node by node).
     */
    public Task searchTask(String taskId) {
        if (taskId == null) return null;

        Node current = head;
        while (current != null) {
            if (current.data.getTaskId().equalsIgnoreCase(taskId)) {
                return current.data;
            }
            current = current.next;
        }
        return null;
    }

    /**
     * Delete Task
     * Time Complexity: O(n) worst-case (must find the node and its predecessor).
     */
    public boolean deleteTask(String taskId) {
        if (head == null || taskId == null) return false;

        // Edge case: The task to delete is at the very front (head)
        if (head.data.getTaskId().equalsIgnoreCase(taskId)) {
            head = head.next;
            if (head == null) {
                tail = null; // List is now completely empty
            }
            return true;
        }

        // Traverse to find the node, keeping track of the previous node
        Node current = head;
        while (current.next != null) {
            if (current.next.data.getTaskId().equalsIgnoreCase(taskId)) {
                // Bypass the deleted node
                current.next = current.next.next;
                
                // Edge case: We deleted the last item, so update the tail
                if (current.next == null) {
                    tail = current;
                }
                return true;
            }
            current = current.next;
        }
        return false;
    }

    /**
     * Traverse and Print
     * Time Complexity: O(n)
     */
    public void printAllTasks() {
        if (head == null) {
            System.out.println("No tasks found.");
            return;
        }
        Node current = head;
        while (current != null) {
            System.out.println(current.data);
            current = current.next;
        }
    }

    public static void main(String[] args) {
        TaskManager manager = new TaskManager();

        manager.addTask(new Task("T01", "Design Database", "In Progress"));
        manager.addTask(new Task("T02", "Write API Endpoints", "Pending"));
        manager.addTask(new Task("T03", "Unit Testing", "Not Started"));

        System.out.println("--- All Tasks ---");
        manager.printAllTasks();

        System.out.println("\n--- Searching for T02 ---");
        System.out.println(manager.searchTask("t02")); // Testing case-insensitivity

        System.out.println("\n--- After Deleting T03 ---");
        manager.deleteTask("T03");
        manager.printAllTasks();
    }
}