package module.trip.dao;

import dal.DBContext;
import module.trip.model.entity.Trip;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TripDAO extends DBContext implements ITripDAO {

//    @Override
//    public boolean insertTrip(Trip trip) throws SQLException {
//        String sql = "INSERT INTO Trip (route_id, bus_id, driver_id, conductor_id, departure_time, arrival_time, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, trip.getRouteId());
//            ps.setInt(2, trip.getBusId());
//            ps.setString(3, trip.getDriverId());
//            ps.setString(4, trip.getConductorId());
//            ps.setTimestamp(5, trip.getDepartureTime());
//            ps.setTimestamp(6, trip.getArrivalTime());
//            ps.setString(7, trip.getStatus());
//            return ps.executeUpdate() > 0;
//        }
//    }
    @Override
    public Trip insertShellTrip(int routeId) throws SQLException {
        String sql = "INSERT INTO Trip (route_id, status) VALUES (?, ?)";
        String generatedColumns[] = { "trip_id" }; 
        try (PreparedStatement ps = connection.prepareStatement(sql, generatedColumns)) {
            ps.setInt(1, routeId);
            ps.setString(2, "NOT_STARTED"); 
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                 throw new SQLException("Tạo chuyến thất bại, không có dòng nào bị ảnh hưởng.");
            }
            
             try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int newId = rs.getInt(1);
                    return this.findTripById(newId); 
                } else {
                    throw new SQLException("Tạo chuyến thất bại, không lấy được ID.");
                }
            }
        }
    }

    @Override
    public Trip findTripById(int tripId) throws SQLException {
        String sql = "SELECT * FROM Trip WHERE trip_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, tripId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractTrip(rs);
                }
            }
        }
        return null;
    }

    @Override
    public boolean deleteTrip(int tripId) throws SQLException {
        String sql = "DELETE FROM Trip WHERE trip_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateTrip(Trip trip) throws SQLException {
        String sql = "UPDATE Trip SET route_id=?, bus_id=?, driver_id=?, conductor_id=?, departure_time=?, arrival_time=?, status=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, trip.getRouteId());
            
            if (trip.getBusId() > 0) {
                 ps.setInt(2, trip.getBusId());
            } else {
                 ps.setNull(2, Types.INTEGER);
            }
            
            if (trip.getDriverId() != null && !trip.getDriverId().isBlank()) {
                ps.setString(3, trip.getDriverId());
            } else {
                ps.setNull(3, Types.VARCHAR);
            }
            
            if (trip.getConductorId() != null && !trip.getConductorId().isBlank()) {
                ps.setString(4, trip.getConductorId());
            } else {
                ps.setNull(4, Types.VARCHAR);
            }
            
            if (trip.getDepartureTime() != null) {
                ps.setTimestamp(5, trip.getDepartureTime());
            } else {
                 ps.setNull(5, Types.TIMESTAMP);
            }
            
            if (trip.getArrivalTime() != null) {
                ps.setTimestamp(6, trip.getArrivalTime());
            } else {
                 ps.setNull(6, Types.TIMESTAMP);
            }
            
            ps.setString(7, trip.getStatus());
            ps.setInt(8, trip.getTripId());
            
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public List<Trip> findAllTrips() throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip ORDER BY trip_id ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractTrip(rs));
            }
        }
        return list;
    }

    private void addDefaultSearch(StringBuilder sql, List<Object> params, String searchKey) {
        try {
            int id = Integer.parseInt(searchKey);
            sql.append("AND (trip_id = ? OR status LIKE ?) ");
            params.add(id);
            params.add("%" + searchKey + "%");
        } catch (NumberFormatException e) {
            String dbStatus = searchKey; 
            if (searchKey.toLowerCase().contains("chưa")) dbStatus = "NOT_STARTED";
            else if (searchKey.toLowerCase().contains("đang")) dbStatus = "IN_PROCESS";
            else if (searchKey.toLowerCase().contains("hoàn")) dbStatus = "FINISHED";
            else if (searchKey.toLowerCase().contains("hủy")) dbStatus = "CANCELLED";
            
            sql.append("AND status = ? ");
            params.add(dbStatus);
        }
    }
    private String translateStatusSearch(String searchKey) {
        String key = searchKey.toLowerCase();
        if (key.contains("chưa")) return "NOT_STARTED";
        if (key.contains("đang")) return "IN_PROCESS";
        if (key.contains("hoàn")) return "FINISHED";
        if (key.contains("hủy")) return "CANCELLED";
        // Nếu người dùng gõ thẳng ENUM (ví dụ: "NOT_STARTED")
        if (key.equals("not_started") || key.equals("in_process") 
                || key.equals("finished") || key.equals("cancelled")) {
            return searchKey.toUpperCase();
        }
        return searchKey; 
    }


    @Override
    public List<Trip> findAllTrips(String search, String filter, String sortCol, String sortDir, int page, int pageSize) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM Trip WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            String searchKey = search.trim();
            String columnToSearch = "";

            if (filter != null && !filter.trim().isEmpty()) {
                switch (filter) {
                    case "tripId": columnToSearch = "trip_id"; break;
                    case "busId": columnToSearch = "bus_id"; break;
                    case "routeId": columnToSearch = "route_id"; break;
                    case "driverId": columnToSearch = "driver_id"; break;
                    case "conductorId": columnToSearch = "conductor_id"; break;
                    case "status": columnToSearch = "status"; break;
                    default:
                        addDefaultSearch(sql, params, searchKey);
                        break;
                }
            } else {
                addDefaultSearch(sql, params, searchKey);
            }
            
            // 1. Tìm theo ID (dùng =)
            if (columnToSearch.equals("trip_id") || columnToSearch.equals("bus_id") || columnToSearch.equals("route_id")) {
                try {
                    int id = Integer.parseInt(searchKey);
                    sql.append("AND ").append(columnToSearch).append(" = ? ");
                    params.add(id);
                } catch (NumberFormatException e) {
                    return new ArrayList<>(); 
                }
            // 2. Tìm theo Mã Tài xế / Phụ xe 
            } else if (columnToSearch.equals("driver_id") || columnToSearch.equals("conductor_id")) {
                sql.append("AND ").append(columnToSearch).append(" = ? ");
                params.add(searchKey);
            // 3. Tìm theo Trạng thái (
            } else if (columnToSearch.equals("status")) {
                String dbStatus = translateStatusSearch(searchKey);
                sql.append("AND ").append(columnToSearch).append(" = ? ");
                params.add(dbStatus);
            }
        }

        // === Logic Sắp xếp ===
        String sortColumn = "trip_id"; 
        if (sortCol != null && !sortCol.trim().isEmpty()) {
            switch (sortCol) {
                case "departure_time":
                case "arrival_time":
                case "bus_id":
                case "route_id":
                case "driver_id":
                case "conductor_id":
                    sortColumn = sortCol;
                    break;
            }
        }

        String sortDirection = "ASC";
        if (sortDir != null && "desc".equalsIgnoreCase(sortDir.trim())) {
            sortDirection = "DESC";
        }

        sql.append("ORDER BY ").append(sortColumn).append(" ").append(sortDirection).append(" ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        List<Trip> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof String) {
                    ps.setString(i + 1, (String) p);
                } else if (p instanceof Integer) {
                    ps.setInt(i + 1, (Integer) p);
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }

    @Override
    public int countTrips(String search, String filter) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM Trip WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            String searchKey = search.trim();
            String columnToSearch = "";

            if (filter != null && !filter.trim().isEmpty()) {
                switch (filter) {
                    case "tripId": columnToSearch = "trip_id"; break;
                    case "busId": columnToSearch = "bus_id"; break;
                    case "routeId": columnToSearch = "route_id"; break;
                    case "driverId": columnToSearch = "driver_id"; break;
                    case "conductorId": columnToSearch = "conductor_id"; break;
                    case "status": columnToSearch = "status"; break;
                    default:
                        addDefaultSearch(sql, params, searchKey);
                        break;
                }
            } else {
                addDefaultSearch(sql, params, searchKey);
            }

            if (columnToSearch.equals("trip_id") || columnToSearch.equals("bus_id") || columnToSearch.equals("route_id")) {
                try {
                    int id = Integer.parseInt(searchKey);
                    sql.append("AND ").append(columnToSearch).append(" = ? ");
                    params.add(id);
                } catch (NumberFormatException e) {
                    return 0; 
                }
            } else if (columnToSearch.equals("driver_id") || columnToSearch.equals("conductor_id")) {
                sql.append("AND ").append(columnToSearch).append(" = ? ");
                params.add(searchKey);
            } else if (columnToSearch.equals("status")) {
                String dbStatus = translateStatusSearch(searchKey);
                sql.append("AND ").append(columnToSearch).append(" = ? ");
                params.add(dbStatus);
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof String) {
                    ps.setString(i + 1, (String) p);
                } else if (p instanceof Integer) {
                    ps.setInt(i + 1, (Integer) p);
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        }
        return 0;
    }
    @Override
    public Trip getTripDetail(int tripId) throws SQLException {
        return findTripById(tripId);
    }

    @Override
    public boolean assignRoute(int tripId, int routeId) throws SQLException {
        String sql = "UPDATE Trip SET route_id=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            ps.setInt(2, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean assignBus(int tripId, int busId) throws SQLException {
        String sql = "UPDATE Trip SET bus_id=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ps.setInt(2, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean assignDriver(int tripId, String driverId) throws SQLException {
        String sql = "UPDATE Trip SET driver_id=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, driverId);
            ps.setInt(2, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean assignConductor(int tripId, String conductorId) throws SQLException {
        String sql = "UPDATE Trip SET conductor_id=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, conductorId);
            ps.setInt(2, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateTripTime(int tripId, Timestamp departureTime, Timestamp arrivalTime) throws SQLException {
        String sql = "UPDATE Trip SET departure_time=?, arrival_time=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, departureTime);
            ps.setTimestamp(2, arrivalTime);
            ps.setInt(3, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateTripStatus(int tripId, String status) throws SQLException {
        String sql = "UPDATE Trip SET status=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, tripId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public List<Trip> findTripsByDriver(String driverId) throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip WHERE driver_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, driverId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }

    @Override
    public List<Trip> findTripsByConductor(String conductorId) throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip WHERE conductor_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, conductorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }

    @Override
    public List<Trip> findTripsByBus(int busId) throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip WHERE bus_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, busId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }

    @Override
    public List<Trip> findTripsByRoute(int routeId) throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }

    @Override
    public List<Trip> findTripsByTime(Timestamp from, Timestamp to) throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip WHERE departure_time >= ? AND arrival_time <= ? ORDER BY departure_time ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, from);
            ps.setTimestamp(2, to);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }
    @Override
    public boolean checkDriver(String driverId, Timestamp departureTime, Timestamp arrivalTime, int tripId) throws SQLException {
        String sql = """
            SELECT COUNT(*) AS cnt
            FROM Trip
            WHERE driver_id = ?
              AND trip_id <> ?
              AND (
                  (departure_time BETWEEN ? AND ?)
                  OR (arrival_time BETWEEN ? AND ?)
                  OR (? BETWEEN departure_time AND arrival_time)
              )
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, driverId);
            ps.setInt(2, tripId);
            ps.setTimestamp(3, departureTime);
            ps.setTimestamp(4, arrivalTime);
            ps.setTimestamp(5, departureTime);
            ps.setTimestamp(6, arrivalTime);
            ps.setTimestamp(7, departureTime);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt") == 0;
            }
        }
        return false;
    }

    // Check bus không bị trùng ca
    public boolean checkBus(int busId, Timestamp departureTime, Timestamp arrivalTime, int excludeTripId) throws SQLException {
        String sql = """
            SELECT COUNT(*) AS cnt
            FROM Trip
            WHERE bus_id = ?
              AND trip_id <> ?
              AND (
                  (departure_time BETWEEN ? AND ?)
                  OR (arrival_time BETWEEN ? AND ?)
                  OR (? BETWEEN departure_time AND arrival_time)
              )
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ps.setInt(2, excludeTripId);
            ps.setTimestamp(3, departureTime);
            ps.setTimestamp(4, arrivalTime);
            ps.setTimestamp(5, departureTime);
            ps.setTimestamp(6, arrivalTime);
            ps.setTimestamp(7, departureTime);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt") == 0;
            }
        }
        return false;
    }

    // Check conductor không bị trùng ca
    public boolean checkConductor(String conductorId, Timestamp departureTime, Timestamp arrivalTime, int excludeTripId) throws SQLException {
        String sql = """
            SELECT COUNT(*) AS cnt
            FROM Trip
            WHERE conductor_id = ?
              AND trip_id <> ?
              AND (
                  (departure_time BETWEEN ? AND ?)
                  OR (arrival_time BETWEEN ? AND ?)
                  OR (? BETWEEN departure_time AND arrival_time)
              )
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, conductorId);
            ps.setInt(2, excludeTripId);
            ps.setTimestamp(3, departureTime);
            ps.setTimestamp(4, arrivalTime);
            ps.setTimestamp(5, departureTime);
            ps.setTimestamp(6, arrivalTime);
            ps.setTimestamp(7, departureTime);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt") == 0;
            }
        }
        return false;
    }

    private Trip extractTrip(ResultSet rs) throws SQLException {
        
        return new Trip(
                rs.getInt("trip_id"),
                rs.getInt("route_id"),
                rs.getInt("bus_id"),
                (String) rs.getObject("driver_id"),
                (String) rs.getObject("conductor_id"),
                rs.getTimestamp("departure_time"),
                rs.getTimestamp("arrival_time"),
                rs.getString("status")
        );
    }
}
