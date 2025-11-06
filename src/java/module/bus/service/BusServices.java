package module.bus.service;

import module.bus.dao.BusDAO;
import module.bus.dao.iBusDAO;
import module.bus.model.entity.Bus;
import java.sql.SQLException;
import java.util.List;
import java.sql.*;

public class BusServices {

    private final iBusDAO busDAO;

    public BusServices() {
        this.busDAO = new BusDAO();
    }

    public List<Bus> getAllBuses() throws SQLException {
        return busDAO.findAll();
    }

    public List<Bus> getAllBuses(String search, String sort, int page, int pageSize) throws SQLException {
        return busDAO.findAll(search, sort, page, pageSize);
    }

    public int countAllBuses() throws SQLException {
        return busDAO.countAll();
    }

    public Bus getBusById(int busId) throws SQLException {
        return busDAO.findBusById(busId);
    }

    public boolean addBus(Bus bus) throws SQLException {
        if (bus == null) {
            return false;
        }
        if (bus.getPlateNumber() == null || bus.getPlateNumber().isBlank()) {
            return false;
        }
        if (bus.getCapacity() <= 0) {
            return false;
        }

        if (busDAO.isPlateNumberExists(bus.getPlateNumber())) {
            System.out.println("Biển số đã tồn tại!");
            return false;
        }
        return busDAO.addBus(bus);
    }

    public boolean updateBus(Bus bus) throws SQLException {
        if (bus == null || bus.getBusId() <= 0) {
            return false;
        }
        if (bus.getPlateNumber() == null || bus.getPlateNumber().isBlank()) {
            return false;
        }
        if (bus.getCapacity() <= 0) {
            return false;
        }

        return busDAO.updateBus(bus);
    }

    public boolean deleteBus(int busId) throws SQLException {
        if (busId <= 0) {
            return false;
        }
        return busDAO.deleteBus(busId);
    }

    public List<Bus> searchBusByPlate(String keyword) throws SQLException {
        if (keyword == null || keyword.isBlank()) {
            return busDAO.findAll(); // Nếu rỗng thì trả về tất cả
        }
        return busDAO.searchBusByPlate(keyword.trim());
    }

    public boolean isPlateNumberExists(String plateNumber) throws SQLException {
        return busDAO.isPlateNumberExists(plateNumber);
    }
}
