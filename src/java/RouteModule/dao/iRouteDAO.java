package RouteModule.dao;

import RouteModule.model.Route;

import java.sql.SQLException;
import java.util.List;

public interface iRouteDAO {

    // ===== CRUD =====
    public boolean addRoute(Route route) throws SQLException;

    public boolean updateRoute(Route route) throws SQLException;

    public boolean deleteRoute(int id) throws SQLException;

    public Route getRouteById(int id) throws SQLException;

    // ===== LISTING (Search, Filter, Sort, Paging) =====
    public List<Route> getAllRoutes(String search, String type, String sortColumn, String sortOrder, int page, int pageSize) throws SQLException;

    public int countRoutes(String search, String type) throws SQLException;

    // ===== VALIDATION =====
    public boolean isDuplicateRoute(Route route) throws SQLException;

    // ===== ROUTE DETAILS =====
    public Route getRouteDetails(int routeId) throws SQLException;

    public int getEstimatedDuration(int routeId) throws SQLException;
}
