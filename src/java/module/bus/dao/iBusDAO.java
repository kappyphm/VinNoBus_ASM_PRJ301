package module.bus.dao;

import module.bus.model.entity.Bus;
import java.util.List;
import java.sql.*;

public interface iBusDAO {

    public boolean addBus(Bus bus) throws SQLException;

    public Bus findBusById(int busId) throws SQLException;

    public boolean deleteBus(int busId) throws SQLException;

    public boolean updateBus(Bus bus) throws SQLException;

    public List<Bus> findAll() throws SQLException;

    public List<Bus> findAll(String search, String sort, int page, int pageSize) throws SQLException;

    public int countAll() throws SQLException;

    public boolean assignBusToTrip(int busId, int tripId) throws SQLException;

    public boolean isPlateNumberExists(String plateNumber) throws SQLException;

    public List<Bus> searchBusByPlate(String keyword) throws SQLException;
}
