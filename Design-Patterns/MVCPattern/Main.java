public class Main {
    public static void main(String[] args) {
        System.out.println("=== MVC Pattern ===\n");

        Student s = new Student("Amit", "S101", "B");
        StudentView v = new StudentView();
        StudentController c = new StudentController(s, v);

        c.updateView();
        c.setStudentGrade("A");
        c.updateView();
    }
}
