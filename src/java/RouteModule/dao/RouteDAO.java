package RouteModule.dao;

import RouteModule.model.Route;
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
        String sql = "DELETE FROM Route WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
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
            sql.append(" AND route_name LIKE ?");
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
                ps.setString(index++, "%" + search + "%");
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
    public boolean isDuplicateRoute(Route route) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Route WHERE route_name = ? AND type = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, route.getRouteName());
            ps.setString(2, route.getType());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public Route getRouteDetails(int routeId) throws SQLException {
        // Có thể mở rộng: join với bảng khác để lấy thêm thông tin
        return getRouteById(routeId);
    }

    @Override
    public int getEstimatedDuration(int routeId) throws SQLException {
        // Giả sử tạm thời dùng frequency như thời lượng dự kiến
        String sql = "SELECT frequency FROM Route WHERE route_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("frequency");
                }
            }
        }
        return 0;
    }
}
