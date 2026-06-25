public class Computer {
    private final String cpu;
    private final String ram;
    private final String storage;
    private final String gpu;
    private final String motherboard;
    private final boolean hasWifi;

    private Computer(Builder b) {
        cpu = b.cpu;
        ram = b.ram;
        storage = b.storage;
        gpu = b.gpu;
        motherboard = b.motherboard;
        hasWifi = b.hasWifi;
    }

    public String getCpu() { return cpu; }
    public String getRam() { return ram; }
    public String getStorage() { return storage; }
    public String getGpu() { return gpu; }
    public String getMotherboard() { return motherboard; }
    public boolean hasWifi() { return hasWifi; }

    @Override
    public String toString() {
        return "Computer[cpu=" + cpu + ", ram=" + ram + ", storage=" + storage + "]";
    }

    public static class Builder {
        private String cpu, ram, storage, gpu, motherboard;
        private boolean hasWifi;

        public Builder setCpu(String v) { cpu = v; return this; }
        public Builder setRam(String v) { ram = v; return this; }
        public Builder setStorage(String v) { storage = v; return this; }
        public Builder setGpu(String v) { gpu = v; return this; }
        public Builder setMotherboard(String v) { motherboard = v; return this; }
        public Builder setWifi(boolean v) { hasWifi = v; return this; }

        public Computer build() {
            if (cpu == null || ram == null || storage == null)
                throw new IllegalStateException("cpu, ram, storage required");
            return new Computer(this);
        }
    }
}
