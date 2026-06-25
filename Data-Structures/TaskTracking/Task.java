public class Task {
    private String taskId;
    private String taskName;
    private String status;

    public Task(String taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
    }

    // Encapsulation
    public String getTaskId() { return taskId; }
    public String getTaskName() { return taskName; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) {
        // Ensure status is never completely empty
        if (status != null && !status.trim().isEmpty()) {
            this.status = status;
        }
    }

    @Override
    public String toString() {
        return String.format("Task [%s]: %s | Status: %s", taskId, taskName, status);
    }
}