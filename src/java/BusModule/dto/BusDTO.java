package BusModule.dto;

public class BusDTO {

    private int busId;
    private String plateNumber;
    private int capacity;

    public int getBusId() {
        return busId;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setBusId(int busId) {
        this.busId = busId;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

}
