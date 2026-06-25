public class Main {
    public static void main(String[] args) {
        System.out.println("=== Dependency Injection ===\n");

        CustomerService svc = new CustomerService(new CustomerRepositoryImpl());
        svc.printCustomer("C001");
        svc.printCustomer("c002");
    }
}
