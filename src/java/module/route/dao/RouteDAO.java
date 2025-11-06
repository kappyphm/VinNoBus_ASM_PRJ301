package module.route.dao;

import module.route.model.entity.Route;
import module.station.model.entity.Station;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RouteDAO extends DBContext implements iRouteDAO {

    @Override
    public boolean addRoute(Route route) throws SQLException {
        String sql = "INSERT INTO Route (route_name, type, frequency) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, route.getRouteName());
            ps.setString(2, route.getType());
            ps.setInt(3, route.getFrequency());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateRoute(Route route) throws SQLException {
        String sql = "UPDATE Route SET route_name = ?, type = ?, frequency = ? WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, route.getRouteName());
            ps.setString(2, route.getType());
            ps.setInt(3, route.getFrequency());
            ps.setInt(4, route.getRouteId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteRoute(int id) throws SQLException {
        String deleteRouteStationSQL = "DELETE FROM Route_Station WHERE route_id = ?";
        String deleteRouteSQL = "DELETE FROM Route WHERE route_id = ?";

        // Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
        try {
            connection.setAutoCommit(false);

            // Xóa các bản ghi phụ trong Route_Station trước
            try (PreparedStatement ps1 = connection.prepareStatement(deleteRouteStationSQL)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
            }

            // Sau đó xóa Route
            int rowsAffected;
            try (PreparedStatement ps2 = connection.prepareStatement(deleteRouteSQL)) {
                ps2.setInt(1, id);
                rowsAffected = ps2.executeUpdate();
            }

            connection.commit();
            return rowsAffected > 0;

        } catch (SQLException e) {
            connection.rollback(); // Nếu có lỗi thì rollback
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    @Override
    public Route getRouteById(int id) throws SQLException {
        String sql = "SELECT * FROM Route WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Route(
                            rs.getInt("route_id"),
                            rs.getString("route_name"),
                            rs.getString("type"),
                            rs.getInt("frequency")
                    );
                }
            }
        }
        return null;
    }

    @Override
    public List<Route> getAllRoutes(String search, String type, String sortColumn, String sortOrder, int page, int pageSize) throws SQLException {
        List<Route> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Route WHERE 1=1");

        if (search != null && !search.isEmpty()) {
            // Chuyển search thành dạng %A%B%C% để tìm từng ký tự
            StringBuilder fuzzy = new StringBuilder("%");
            for (char c : search.toCharArray()) {
                fuzzy.append(c).append("%");
            }
            sql.append(" AND route_name LIKE ?");
            search = fuzzy.toString();
        }

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
        }

        if (sortColumn != null && !sortColumn.isEmpty()) {
            sql.append(" ORDER BY ").append(sortColumn).append(" ");
            sql.append(sortOrder != null && !sortOrder.isEmpty() ? sortOrder : "ASC");
        } else {
            sql.append(" ORDER BY route_id ASC");
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(index++, search);
            }
            if (type != null && !type.isEmpty()) {
                ps.setString(index++, type);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Route(
                            rs.getInt("route_id"),
                            rs.getString("route_name"),
                            rs.getString("type"),
                            rs.getInt("frequency")
                    ));
                }
            }
        }

        return list;
    }

    @Override
    public int countRoutes(String search, String type) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Route WHERE 1=1");
        if (search != null && !search.isEmpty()) {
            sql.append(" AND route_name LIKE ?");
        }
        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
        }
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (type != null && !type.isEmpty()) {
                ps.setString(index++, type);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    @Override
    public boolean isDuplicateRoute(String name, String type) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Route WHERE UPPER(LTRIM(RTRIM(route_name))) = UPPER(?) AND UPPER(LTRIM(RTRIM(type))) = UPPER(?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name.trim());
            ps.setString(2, type.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public Route getRouteDetails(int route_id) throws SQLException {
        String sql = """
        SELECT 
            r.route_id, r.route_name, r.type, r.frequency,
            s.station_id, s.station_name, s.location,
            rs.estimated_time
        FROM Route r
        LEFT JOIN Route_Station rs ON r.route_id = rs.route_id
        LEFT JOIN Station s ON rs.station_id = s.station_id
        WHERE r.route_id = ?
        ORDER BY rs.station_order
    """;

        Route route = null;
        List<Station> stations = new ArrayList<>();
        int totalTime = 0;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, route_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (route == null) {
                        route = new Route(
                                rs.getInt("route_id"),
                                rs.getString("route_name"),
                                rs.getString("type"),
                                rs.getInt("frequency")
                        );
                    }
                    int stationId = rs.getInt("station_id");
                    if (!rs.wasNull()) {
                        Station station = new Station(
                                stationId,
                                rs.getString("station_name"),
                                rs.getString("location")
                        );
                        stations.add(station);
                        totalTime += rs.getInt("estimated_time");
                    }
                }
            }
        }
        if (route != null) {
            route.setStations(stations);
            route.setEstimatedTime(totalTime);
        }
        return route;
    }

    @Override
    public int getEstimatedDuration(int route_id) throws SQLException {
        String sql = "SELECT frequency FROM Route WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, route_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("frequency");
                }
            }
        }
        return 0;
    }

    @Override
    public boolean isRouteNameExist(String route_name) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Route WHERE UPPER(LTRIM(RTRIM(route_name))) = UPPER(?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, route_name.trim().toUpperCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public boolean isRouteNameExistForOtherId(String route_name, int id) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Route WHERE route_name = ? AND route_id <> ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, route_name);
            ps.setInt(2, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public boolean addStationToRoute(int route_id, int stationId, int stationOrder, int estimatedTime) throws SQLException {
        String sql = "INSERT INTO Route_Station(route_id, station_id, station_order, estimated_time) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, route_id);
            ps.setInt(2, stationId);
            ps.setInt(3, stationOrder);
            ps.setInt(4, estimatedTime);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public Route getRouteWithStations(int route_id) throws SQLException {
        Route route = getRouteById(route_id);
        if (route == null) {
            return null;
        }

        List<Station> stations = new ArrayList<>();
        int totalTime = 0;

        String sql = """
        SELECT s.*, rs.station_order, rs.estimated_time
        FROM Route_Station rs
        JOIN Station s ON rs.station_id = s.station_id
        WHERE rs.route_id = ?
        ORDER BY rs.station_order
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, route_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Station station = new Station(
                        rs.getInt("station_id"),
                        rs.getString("station_name"),
                        rs.getString("location")
                );

                station.setRouteNames(List.of(rs.getInt("station_order") + "|" + rs.getInt("estimated_time")));
                stations.add(station);
                totalTime += rs.getInt("estimated_time");
            }
        }

        route.setStations(stations);
        route.setEstimatedTime(totalTime);
        return route;
    }

    @Override
    public boolean deleteAllStationsFromRoute(int route_id) throws SQLException {
        String sql = "DELETE FROM Route_Station WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, route_id);
            int affectedRows = ps.executeUpdate();
            return affectedRows >= 0; // >=0 vì có thể không có trạm nào nhưng vẫn thành công
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<Route> getRoutesByTwoStations(int stationA, int stationB) throws SQLException {
        List<Route> routes = new ArrayList<>();
        String sql = """
        SELECT DISTINCT r.route_id, r.route_name, r.type, r.frequency
        FROM Route r
        JOIN Route_Station rs1 ON r.route_id = rs1.route_id AND rs1.station_id = ?
        JOIN Route_Station rs2 ON r.route_id = rs2.route_id AND rs2.station_id = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, stationA);
            ps.setInt(2, stationB);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Route r = new Route();
                r.setRouteId(rs.getInt("route_id"));
                r.setRouteName(rs.getString("route_name"));
                r.setType(rs.getString("type"));
                r.setFrequency(rs.getInt("frequency"));
                routes.add(r);
            }
        }

        return routes;
    }
}
