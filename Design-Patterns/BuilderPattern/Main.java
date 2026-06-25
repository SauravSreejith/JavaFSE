public class Main {
    public static void main(String[] args) {
        System.out.println("=== Builder Pattern ===\n");

        Computer basic = new Computer.Builder()
                .setCpu("i3").setRam("8GB").setStorage("256GB")
                .build();
        System.out.println(basic);

        Computer good = new Computer.Builder()
                .setCpu("ryzen").setRam("32GB").setStorage("1TB")
                .setGpu("rtx").setWifi(true)
                .build();
        System.out.println(good);

        try {
            new Computer.Builder().setCpu("i5").build();
        } catch (Exception e) {
            System.out.println("Caught: " + e.getMessage());
        }
    }
}
