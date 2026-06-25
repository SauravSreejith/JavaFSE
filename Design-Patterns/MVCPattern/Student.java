public class Student {
    private String name, id, grade;

    public Student(String n, String i, String g) {
        name = n; id = i; grade = g;
    }

    public String getName() { return name; }
    public void setName(String n) { if (n != null) name = n; }

    public String getId() { return id; }
    public void setId(String i) { if (i != null) id = i; }

    public String getGrade() { return grade; }
    public void setGrade(String g) { if (g != null) grade = g.toUpperCase(); }

    public String toString() {
        return name + " (" + id + ") - " + grade;
    }
}
