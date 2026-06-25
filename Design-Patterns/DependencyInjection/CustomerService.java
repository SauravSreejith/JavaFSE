public class CustomerService {
    private CustomerRepository repo;

    public CustomerService(CustomerRepository r) {
        repo = r;
    }

    public void printCustomer(String id) {
        System.out.println(repo.findCustomerById(id));
    }
}
