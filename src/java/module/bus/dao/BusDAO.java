package module.bus.dao;

import module.bus.model.entity.Bus;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BusDAO extends DBContext implements iBusDAO {

    @Override
    public boolean addBus(Bus bus) throws SQLException {
        String sql = "INSERT INTO Bus (plate_number, capacity, current_status) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bus.getPlateNumber());
            ps.setInt(2, bus.getCapacity());
            ps.setString(3, bus.getCurrentStatus());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public Bus findBusById(int busId) throws SQLException {
        String sql = "SELECT * FROM Bus WHERE bus_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, busId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Bus(
                            rs.getInt("bus_id"),
                            rs.getString("plate_number"),
                            rs.getInt("capacity"),
                            rs.getString("current_status")
                    );
                }
            }
        }
        return null;
    }

    @Override
    public boolean deleteBus(int busId) throws SQLException {
        String sql = "DELETE FROM Bus WHERE bus_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, busId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateBus(Bus bus) throws SQLException {
        String sql = "UPDATE Bus SET plate_number=?, capacity=?, current_status=? WHERE bus_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bus.getPlateNumber());
            ps.setInt(2, bus.getCapacity());
            ps.setString(3, bus.getCurrentStatus());
            ps.setInt(4, bus.getBusId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Bắt lỗi trùng khóa duy nhất
            if (e.getMessage().contains("UNIQUE KEY constraint")) {
                throw new SQLException("Biển số xe đã tồn tại trong hệ thống.");
            }
            throw e; // ném lại lỗi khác
        }
    }

    @Override
    public List<Bus> findAll() throws SQLException {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT * FROM Bus ORDER BY bus_id ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Bus(
                        rs.getInt("bus_id"),
                        rs.getString("plate_number"),
                        rs.getInt("capacity"),
                        rs.getString("current_status")
                ));
            }
        }
        return list;
    }

    @Override
    public List<Bus> findAll(String search, String sort, int page, int pageSize) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM Bus WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND plate_number LIKE ? ");
            params.add("%" + search + "%");
        }

        if (sort == null || sort.isEmpty()) {
            sort = "bus_id ASC";
        }
        sql.append("ORDER BY ").append(sort).append(" ");

        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        List<Bus> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Bus(
                            rs.getInt("bus_id"),
                            rs.getString("plate_number"),
                            rs.getInt("capacity"),
                            rs.getString("current_status")
                    ));
                }
            }
        }
        return list;
    }

    @Override
    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM Bus";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    @Override
    public boolean isPlateNumberExists(String plateNumber) throws SQLException {
        String sql = "SELECT 1 FROM Bus WHERE plate_number = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, plateNumber);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    @Override
    public List<Bus> searchBusByPlate(String keyword) throws SQLException {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT * FROM Bus WHERE TRIM(plate_number) LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%"); // trim đã thực hiện ở Servlet/Service
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Bus(
                            rs.getInt("bus_id"),
                            rs.getString("plate_number").trim(),
                            rs.getInt("capacity"),
                            rs.getString("current_status")
                    ));
                }
            }
        }
        return list;
    }
}
