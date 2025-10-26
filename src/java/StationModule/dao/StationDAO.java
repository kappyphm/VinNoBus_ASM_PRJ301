package StationModule.dao;

import StationModule.model.Station;
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
            SELECT s.station_id, s.station_name, s.location, s.open_time, s.close_time,
                   STRING_AGG(r.route_name, ', ') AS route_names
            FROM Station s
            LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
            LEFT JOIN Route r ON r.route_id = rs.route_id
            GROUP BY s.station_id, s.station_name, s.location, s.open_time, s.close_time
        """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Station s = new Station();
                s.setStationId(rs.getInt("station_id"));
                s.setStationName(rs.getString("station_name"));
                s.setLocation(rs.getString("location"));
                s.setOpenTime(rs.getString("open_time"));
                s.setCloseTime(rs.getString("close_time"));

                String routes = rs.getString("route_names");
                if (routes != null && !routes.isEmpty()) {
                    s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                }
                list.add(s);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách trạm: " + e.getMessage());
        }
        return list;
    }

    @Override
    public Station getById(int id) {
        String sql = """
            SELECT s.station_id, s.station_name, s.location, s.open_time, s.close_time,
                   STRING_AGG(r.route_name, ', ') AS route_names
            FROM Station s
            LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
            LEFT JOIN Route r ON r.route_id = rs.route_id
            WHERE s.station_id = ?
            GROUP BY s.station_id, s.station_name, s.location, s.open_time, s.close_time
        """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Station s = new Station();
                s.setStationId(rs.getInt("station_id"));
                s.setStationName(rs.getString("station_name"));
                s.setLocation(rs.getString("location"));
                s.setOpenTime(rs.getString("open_time"));
                s.setCloseTime(rs.getString("close_time"));
                String routes = rs.getString("route_names");
                if (routes != null && !routes.isEmpty()) {
                    s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                }
                rs.close();
                ps.close();
                return s;
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy trạm theo ID: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Station> getByName(String name) {
        List<Station> list = new ArrayList<>();
        String sql = """
            SELECT s.station_id, s.station_name, s.location, s.open_time, s.close_time,
                   STRING_AGG(r.route_name, ', ') AS route_names
            FROM Station s
            LEFT JOIN Route_Station rs ON s.station_id = rs.station_id
            LEFT JOIN Route r ON r.route_id = rs.route_id
            WHERE s.station_name LIKE ?
            GROUP BY s.station_id, s.station_name, s.location, s.open_time, s.close_time
        """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Station s = new Station();
                s.setStationId(rs.getInt("station_id"));
                s.setStationName(rs.getString("station_name"));
                s.setLocation(rs.getString("location"));
                s.setOpenTime(rs.getString("open_time"));
                s.setCloseTime(rs.getString("close_time"));
                String routes = rs.getString("route_names");
                if (routes != null && !routes.isEmpty()) {
                    s.setRouteNames(Arrays.asList(routes.split(",\\s*")));
                }
                list.add(s);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm trạm theo tên: " + e.getMessage());
        }
        return list;
    }

    @Override
    public boolean create(Station s) {
        String sql = "INSERT INTO Station (station_name, location, open_time, close_time) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, s.getStationName());
            ps.setString(2, s.getLocation());
            ps.setString(3, s.getOpenTime());
            ps.setString(4, s.getCloseTime());
            int rows = ps.executeUpdate();
            ps.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm trạm: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean update(Station s) {
        String sql = "UPDATE Station SET station_name=?, location=?, open_time=?, close_time=? WHERE station_id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, s.getStationName());
            ps.setString(2, s.getLocation());
            ps.setString(3, s.getOpenTime());
            ps.setString(4, s.getCloseTime());
            ps.setInt(5, s.getStationId());
            int rows = ps.executeUpdate();
            ps.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật trạm: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Station WHERE station_id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            ps.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa trạm: " + e.getMessage());
            return false;
        }
    }
}
