package TripModule.dao;

import dal.DBContext;
import TripModule.model.Trip;
import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class TripDAO extends DBContext implements ITripDAO {

    @Override
    public boolean insertTrip(Trip trip) throws SQLException {
        String sql = "INSERT INTO Trip (route_id, bus_id, driver_id, conductor_id, departure_time, arrival_time, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, trip.getRouteId());
            ps.setInt(2, trip.getBusId());
            ps.setString(3, trip.getDriverId());
            ps.setString(4, trip.getConductorId());
            ps.setTime(5, Time.valueOf(trip.getDepartureTime()));
            ps.setTime(6, Time.valueOf(trip.getArrivalTime()));
            ps.setString(7, trip.getStatus());
            return ps.executeUpdate() > 0;
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
            ps.setInt(2, trip.getBusId());
            ps.setString(3, trip.getDriverId());
            ps.setString(4, trip.getConductorId());
            ps.setTime(5, Time.valueOf(trip.getDepartureTime()));
            ps.setTime(6, Time.valueOf(trip.getArrivalTime()));
            ps.setString(7, trip.getStatus());
            ps.setInt(8, trip.getTripId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public List<Trip> findAllTrips() throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip ORDER BY trip_id ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractTrip(rs));
            }
        }
        return list;
    }

    @Override
    public List<Trip> findTrips(String search, String filter, String sort, int page, int pageSize) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM Trip WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (status LIKE ? OR CAST(trip_id AS NVARCHAR) LIKE ?) ");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        if (filter != null && !filter.trim().isEmpty()) {
            sql.append("AND status = ? ");
            params.add(filter);
        }

        if (sort == null || sort.isEmpty()) {
            sort = "trip_id ASC";
        }
        sql.append("ORDER BY ").append(sort).append(" ");

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
            sql.append("AND (status LIKE ? OR CAST(trip_id AS NVARCHAR) LIKE ?) ");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        if (filter != null && !filter.trim().isEmpty()) {
            sql.append("AND status = ? ");
            params.add(filter);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, (String) params.get(i));
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
    public boolean updateTripTime(int tripId, LocalTime departure, LocalTime arrival) throws SQLException {
        String sql = "UPDATE Trip SET departure_time=?, arrival_time=? WHERE trip_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTime(1, Time.valueOf(departure));
            ps.setTime(2, Time.valueOf(arrival));
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
    public List<Trip> findTripsByTime(LocalTime from, LocalTime to) throws SQLException {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM Trip WHERE departure_time >= ? AND arrival_time <= ? ORDER BY departure_time ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTime(1, Time.valueOf(from));
            ps.setTime(2, Time.valueOf(to));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractTrip(rs));
                }
            }
        }
        return list;
    }

    @Override
    public boolean checkDriver(String driverId, LocalTime departure, LocalTime arrival) throws SQLException {
        String sql = """
        SELECT COUNT(*) AS cnt
        FROM Trip
        WHERE driver_id = ?
          AND (
              (departure_time BETWEEN ? AND ?)
              OR (arrival_time BETWEEN ? AND ?)
              OR (? BETWEEN departure_time AND arrival_time)
          )
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, driverId);
            ps.setTime(2, Time.valueOf(departure));
            ps.setTime(3, Time.valueOf(arrival));
            ps.setTime(4, Time.valueOf(departure));
            ps.setTime(5, Time.valueOf(arrival));
            ps.setTime(6, Time.valueOf(departure));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt") == 0; // true nếu không có trùng thời gian
            }
        }
        return false;
    }

    @Override
    public boolean checkBus(int busId, LocalTime departure, LocalTime arrival) throws SQLException {
        String sql = """
        SELECT COUNT(*) AS cnt
        FROM Trip
        WHERE bus_id = ?
          AND (
              (departure_time BETWEEN ? AND ?)
              OR (arrival_time BETWEEN ? AND ?)
              OR (? BETWEEN departure_time AND arrival_time)
          )
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ps.setTime(2, Time.valueOf(departure));
            ps.setTime(3, Time.valueOf(arrival));
            ps.setTime(4, Time.valueOf(departure));
            ps.setTime(5, Time.valueOf(arrival));
            ps.setTime(6, Time.valueOf(departure));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt") == 0;
            }
        }
        return false;
    }

    @Override
    public boolean checkConductor(String conductorId, LocalTime departure, LocalTime arrival) throws SQLException {
        String sql = """
        SELECT COUNT(*) AS cnt
        FROM Trip
        WHERE conductor_id = ?
          AND (
              (departure_time BETWEEN ? AND ?)
              OR (arrival_time BETWEEN ? AND ?)
              OR (? BETWEEN departure_time AND arrival_time)
          )
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, conductorId);
            ps.setTime(2, Time.valueOf(departure));
            ps.setTime(3, Time.valueOf(arrival));
            ps.setTime(4, Time.valueOf(departure));
            ps.setTime(5, Time.valueOf(arrival));
            ps.setTime(6, Time.valueOf(departure));

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
                rs.getTime("departure_time").toLocalTime(),
                rs.getTime("arrival_time").toLocalTime(),
                rs.getString("status")
        );
    }
}
