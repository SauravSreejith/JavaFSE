// File: ./EmployeeManagement/Employee.java
public class Employee {
    private String employeeId;
    private String name;
    private String position;
    private double salary;

    public Employee(String employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }

    public String getEmployeeId() { return employeeId; }
    public String getName() { return name; }
    public String getPosition() { return position; }
    
    public double getSalary() { return salary; }
    public void setSalary(double salary) {
        if (salary >= 0) {
            this.salary = salary;
        }
    }

    @Override
    public String toString() {
        return String.format("[%s] %s - %s | Salary: $%.2f", 
                employeeId, name, position, salary);
    }
}