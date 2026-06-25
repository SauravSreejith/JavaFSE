public class StudentController {
    private Student student;
    private StudentView view;

    public StudentController(Student s, StudentView v) {
        student = s; view = v;
    }

    public void setStudentName(String n) { student.setName(n); }
    public void setStudentGrade(String g) { student.setGrade(g); }

    public void updateView() {
        view.displayStudentDetails(student.getName(), student.getId(), student.getGrade());
    }
}
