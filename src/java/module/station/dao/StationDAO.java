package module.station.dao;

import module.station.model.entity.Station;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class StationDAO extends DBContext implements iStationDAO {

    @Override
    public List<Station> getAll() {
        List<Station> list = new ArrayList<>();
        String sql = """
           SELECT s.station_id, s.station_name, s.location,
                  STRING_AGG(r.route_name, ', ') AS route_names
           FROM Station s
           LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
           LEFT JOIN Route r ON r.route_id = rs.route_id
           GROUP BY s.station_id, s.station_name, s.location
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Station s = new Station();
                s.setStationId(rs.getInt("station_id"));
                s.setStationName(rs.getString("station_name"));
                s.setLocation(rs.getString("location"));

                String routes = rs.getString("route_names");
                if (routes != null && !routes.isEmpty()) {
                    s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                }
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách trạm: " + e.getMessage());
        }
        return list;
    }

    @Override
    public Station getById(int id) {
        String sql = """
           SELECT s.station_id, s.station_name, s.location,
                  STRING_AGG(r.route_name, ', ') AS route_names
           FROM Station s
           LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
           LEFT JOIN Route r ON r.route_id = rs.route_id
           WHERE s.station_id = ?
           GROUP BY s.station_id, s.station_name, s.location
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Station s = new Station();
                    s.setStationId(rs.getInt("station_id"));
                    s.setStationName(rs.getString("station_name"));
                    s.setLocation(rs.getString("location"));

                    String routes = rs.getString("route_names");
                    if (routes != null && !routes.isEmpty()) {
                        s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                    }
                    return s;
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy trạm theo ID: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Station> getByName(String name) {
        List<Station> list = new ArrayList<>();
        String sql = """
           SELECT s.station_id, s.station_name, s.location,
                  STRING_AGG(r.route_name, ', ') AS route_names
           FROM Station s
           LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
           LEFT JOIN Route r ON r.route_id = rs.route_id
           WHERE s.station_name LIKE ?
           GROUP BY s.station_id, s.station_name, s.location
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Station s = new Station();
                    s.setStationId(rs.getInt("station_id"));
                    s.setStationName(rs.getString("station_name"));
                    s.setLocation(rs.getString("location"));

                    String routes = rs.getString("route_names");
                    if (routes != null && !routes.isEmpty()) {
                        s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                    }
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm trạm theo tên: " + e.getMessage());
        }
        return list;
    }

    @Override
    public boolean create(Station s) {
        String sql = "INSERT INTO Station (station_name, location) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, s.getStationName());
            ps.setString(2, s.getLocation());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm trạm: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean update(Station s) {
        String sql = "UPDATE Station SET station_name=?, location=? WHERE station_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, s.getStationName());
            ps.setString(2, s.getLocation());
            ps.setInt(3, s.getStationId());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật trạm: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Station WHERE station_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa trạm: " + e.getMessage());
            return false;
        }
    }

    public List<Station> getStationsByPage(int page, int pageSize) {
        List<Station> list = new ArrayList<>();
        String sql = """
            SELECT s.station_id, s.station_name, s.location,
                   STRING_AGG(r.route_name, ', ') AS route_names
            FROM Station s
            LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
            LEFT JOIN Route r ON r.route_id = rs.route_id
            GROUP BY s.station_id, s.station_name, s.location
            ORDER BY s.station_id
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Station s = new Station();
                    s.setStationId(rs.getInt("station_id"));
                    s.setStationName(rs.getString("station_name"));
                    s.setLocation(rs.getString("location"));

                    String routes = rs.getString("route_names");
                    if (routes != null && !routes.isEmpty()) {
                        s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                    }
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi phân trang trạm: " + e.getMessage());
        }
        return list;
    }

    public int getTotalStations() {
        String sql = "SELECT COUNT(*) FROM Station";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi đếm số lượng trạm: " + e.getMessage());
        }
        return 0;
    }

    @Override
    public List<Station> searchStationsByNameFuzzy(String name) {
        List<Station> list = new ArrayList<>();
        if (name == null || name.trim().isEmpty()) {
            return list;
        }
        StringBuilder fuzzy = new StringBuilder("%");
        for (char c : name.trim().toCharArray()) {
            fuzzy.append(c).append("%");
        }

        String sql = """
       SELECT s.station_id, s.station_name, s.location,
              STRING_AGG(r.route_name, ', ') AS route_names
       FROM Station s
       LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
       LEFT JOIN Route r ON r.route_id = rs.route_id
       WHERE s.station_name LIKE ?
       GROUP BY s.station_id, s.station_name, s.location
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fuzzy.toString());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Station s = new Station();
                    s.setStationId(rs.getInt("station_id"));
                    s.setStationName(rs.getString("station_name"));
                    s.setLocation(rs.getString("location"));

                    String routes = rs.getString("route_names");
                    if (routes != null && !routes.isEmpty()) {
                        s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                    }
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm trạm theo tên fuzzy: " + e.getMessage());
        }

        return list;
    }

}
