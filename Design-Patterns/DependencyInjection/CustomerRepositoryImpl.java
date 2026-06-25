public class CustomerRepositoryImpl implements CustomerRepository {
    public String findCustomerById(String id) {
        if ("C001".equals(id)) return "Priya (Gold)";
        if ("C002".equalsIgnoreCase(id)) return "Arjun (Silver)";
        return "Unknown customer";
    }
}
