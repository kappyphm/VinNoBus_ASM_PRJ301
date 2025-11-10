/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package module.route.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import module.route.dao.RouteDAO;
import module.route.model.entity.Route;
import module.route.service.RouteServices;
import module.station.dao.StationDAO;
import module.station.model.entity.Station;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "Wellcome", urlPatterns = {"/search"})
public class Wellcome extends HttpServlet {

    private RouteServices routeServices = new RouteServices();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null) {
                searchRoutesByStations(req, resp);
            }
            switch (action) {

                case "details" ->
                    showDetails(req, resp);

                default ->
                    searchRoutesByStations(req, resp);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Wellcome.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void searchRoutesByStations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int stationA = 0, stationB = 0;
        if (request.getParameter("a") != null && !request.getParameter("a").isEmpty()) {
            stationA = Integer.parseInt(request.getParameter("a"));
        }
        if (request.getParameter("b") != null && !request.getParameter("b").isEmpty()) {
            stationB = Integer.parseInt(request.getParameter("b"));
        }

        // 🔹 Luôn nạp danh sách trạm
        StationDAO stationDAO = new StationDAO();
        List<Station> stations = stationDAO.getAll();
        request.setAttribute("stations", stations);

        // 🔹 Nếu có chọn cả 2 trạm → tìm tuyến
        if (stationA > 0 && stationB > 0) {
            RouteDAO routeDAO = new RouteDAO();
            List<Route> routes = routeDAO.getRoutesByTwoStations(stationA, stationB);
            request.setAttribute("routes", routes);

            // ✅ Lấy tên 2 trạm đã chọn để hiển thị trong thông báo
            String stationAName = null;
            String stationBName = null;
            for (Station s : stations) {
                if (s.getStationId() == stationA) {
                    stationAName = s.getStationName();
                }
                if (s.getStationId() == stationB) {
                    stationBName = s.getStationName();
                }
            }

            // ✅ Nếu không có tuyến nào
            if (routes == null || routes.isEmpty()) {
                String message = "Không có tuyến nào đi qua 2 trạm: " + stationAName + " và " + stationBName + ".";
                request.setAttribute("errorMessage", message);
            }
        }

        // 🔹 Gửi dữ liệu tới trang JSP
        request.getRequestDispatcher("/view/route/search.jsp").forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Lấy tuyến kèm trạm
            Route route = routeServices.getRouteWithStations(id);

            if (route == null) {
                request.setAttribute("errorMessage", "⚠️ Không tìm thấy thông tin tuyến xe có ID: " + id);
            } else {
                request.setAttribute("route", route);
                // Nếu muốn, có thể gửi danh sách trạm sang JSP
                request.setAttribute("stations", route.getStations());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ ID tuyến xe không hợp lệ!");
        }
        request.getRequestDispatcher("/view/route/detail.jsp").forward(request, response);
    }
}
