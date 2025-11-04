package module.route.service;

import module.route.dao.RouteDAO;
import module.route.model.entity.Route;
import java.sql.SQLException;
import java.util.List;

public class RouteServices {

    private final RouteDAO routeDAO;

    public RouteServices() {
        this.routeDAO = new RouteDAO();
    }

    public boolean addRoute(Route route) throws SQLException {
        // Kiểm tra trùng lặp trước khi thêm
        if (routeDAO.isDuplicateRoute(route.getRouteName(), route.getType())) {
            System.out.println("Tuyến đường đã tồn tại!");
            return false;
        }
        return routeDAO.addRoute(route);
    }

    // Cập nhật tuyến đường
    public boolean updateRoute(Route route) throws SQLException {
        return routeDAO.updateRoute(route);
    }

    // Xóa tuyến đường
    public boolean deleteRoute(int id) throws SQLException {
        return routeDAO.deleteRoute(id);
    }

    // Lấy thông tin tuyến theo ID
    public Route getRouteById(int id) throws SQLException {
        return routeDAO.getRouteById(id);
    }

    // Lấy danh sách tuyến (có thể tìm kiếm, lọc, sắp xếp, phân trang)
    public List<Route> getAllRoutes(String search, String type, String sortColumn,
            String sortOrder, int page, int pageSize) throws SQLException {
        return routeDAO.getAllRoutes(search, type, sortColumn, sortOrder, page, pageSize);
    }

    // Đếm số lượng tuyến (phục vụ cho phân trang)
    public int countRoutes(String search, String type) throws SQLException {
        return routeDAO.countRoutes(search, type);
    }

    // Lấy chi tiết đầy đủ một tuyến
    public Route getRouteDetails(int routeId) throws SQLException {
        return routeDAO.getRouteDetails(routeId);
    }

    // Lấy thời lượng dự kiến của tuyến
    public int getEstimatedDuration(int routeId) throws SQLException {
        return routeDAO.getEstimatedDuration(routeId);
    }

    public boolean isRouteNameExist(String routeName) throws SQLException {
        return routeDAO.isRouteNameExist(routeName);
    }

    public boolean isRouteNameExistForOtherId(String routeName, int id) throws SQLException {
        return routeDAO.isRouteNameExistForOtherId(routeName, id);
    }

    public boolean isDuplicateRoute(String name, String type) throws SQLException {
        return routeDAO.isDuplicateRoute(name, type);
    }

    public boolean addStationToRoute(int routeId, int stationId, int stationOrder, int estimatedTime) throws SQLException {
        return routeDAO.addStationToRoute(routeId, stationId, stationOrder, estimatedTime);
    }

    public Route getRouteWithStations(int routeId) throws SQLException {
        return routeDAO.getRouteWithStations(routeId);
    }

    public boolean deleteAllStationsFromRoute(int routeId) throws SQLException {
        return routeDAO.deleteAllStationsFromRoute(routeId);
    }

}
