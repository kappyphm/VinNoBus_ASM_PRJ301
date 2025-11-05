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
import java.io.PrintWriter;
import java.sql.*;
import java.util.List;
import module.route.dao.RouteDAO;
import module.route.model.entity.Route;
import module.route.service.RouteServices;
import module.station.dao.StationDAO;
import module.station.model.entity.Station;
import module.station.service.StationServices;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RouteServlet", urlPatterns = {"/RouteServlet"})
public class RouteServlet extends HttpServlet {

    private RouteServices routeServices;
    private StationServices stationServices;

    @Override
    public void init() throws ServletException {
        routeServices = new RouteServices();
        stationServices = new StationServices();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RouteServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RouteServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // mặc định
        }
        try {
            StationDAO stationDAO = new StationDAO();
            List<Station> stations = stationDAO.getAll();
            request.setAttribute("stations", stations);

            switch (action) {
                case "list":
                    listRoutes(request, response);
                    break;
                case "details":
                    showDetails(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteRoute(request, response);
                    break;
                case "assign":
                    showAssignForm(request, response);
                    break;
                case "search":
                    searchRoutesByStations(request, response);
                    break;
                default:
                    response.sendError(404, "Page not found");
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/view/route/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "⚠️ Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("/view/route/list.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addRoute(request, response);
                    break;
                case "update":
                    updateRoute(request, response);
                    break;
                case "saveAssignedStations":
                    saveAssignedStations(request, response);
                    break;
                default:
                    listRoutes(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Lỗi thao tác với cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/view/route/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "⚠️ Lỗi không xác định: " + e.getMessage());
            request.getRequestDispatcher("/view/route/list.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void listRoutes(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String search = request.getParameter("search");
        String type = request.getParameter("type");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");

        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Route> list = routeServices.getAllRoutes(search, type, sortColumn, sortOrder, page, pageSize);
        int total = routeServices.countRoutes(search, type);

        // ✅ Tính số trang
        int totalPages = (int) Math.ceil((double) total / pageSize);

        // ✅ Gửi sang JSP
        request.setAttribute("listRoutes", list);
        request.setAttribute("totalRoutes", total);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("type", type);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortOrder", sortOrder);

        // ✅ Đảm bảo đường dẫn đúng cấu trúc /view/Route/
        request.getRequestDispatcher("/view/route/list.jsp").forward(request, response);
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
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Lỗi cơ sở dữ liệu: " + e.getMessage());
        }
        request.getRequestDispatcher("/view/route/detail.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Lấy tuyến kèm trạm để edit
            Route route = routeServices.getRouteWithStations(id);

            if (route == null) {
                request.setAttribute("errorMessage", "⚠️ Không tìm thấy tuyến có ID: " + id);
            } else {
                request.setAttribute("route", route);
                // Gửi danh sách trạm sang JSP để edit thứ tự hoặc thêm/xóa trạm
                request.setAttribute("stations", route.getStations());
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ ID không hợp lệ khi chỉnh sửa tuyến!");
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Lỗi cơ sở dữ liệu: " + e.getMessage());
        }
        request.getRequestDispatcher("/view/route/edit.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/route/add.jsp").forward(request, response);
    }

    private void addRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            String name = request.getParameter("routeName");
            String type = request.getParameter("type");
            String freqStr = request.getParameter("frequency");
            String[] stationIds = request.getParameterValues("stationIds"); // danh sách stationId từ form

            // ===== VALIDATION =====
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "⚠️ Tên tuyến không được để trống!");
                request.getRequestDispatcher("/view/route/add.jsp").forward(request, response);
                return;
            }

            name = name.trim();
            type = type != null ? type.trim() : "";

            // Kiểm tra trùng tên tuyến
            if (routeServices.isDuplicateRoute(name, type)) {
                request.setAttribute("errorMessage", "❌ Tuyến \"" + name + "\" (" + type + ") đã tồn tại trong hệ thống!");
                request.getRequestDispatcher("/view/route/add.jsp").forward(request, response);
                return;
            }

            // Chuyển frequency sang int và kiểm tra số nguyên dương
            int frequency;
            try {
                frequency = Integer.parseInt(freqStr);
                if (frequency <= 0) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "⚠️ Tần suất phải là số nguyên dương!");
                request.getRequestDispatcher("/view/route/add.jsp").forward(request, response);
                return;
            }

            // ===== TẠO TUYẾN =====
            Route route = new Route(0, name, type, frequency);
            boolean success = routeServices.addRoute(route);

            if (success) {
                // ===== THÊM TRẠM CHO TUYẾN =====
                if (stationIds != null) {
                    int order = 1;
                    for (String sid : stationIds) {
                        int stationId = Integer.parseInt(sid);
                        routeServices.addStationToRoute(route.getRouteId(), stationId, order++, 0);
                    }
                }

                // Thông báo thành công
                request.getSession().setAttribute("message", "✅ Thêm tuyến \"" + name + "\" thành công!");
                response.sendRedirect("RouteServlet?action=list");
            } else {
                request.setAttribute("errorMessage", "❌ Thêm thất bại! Có thể tuyến đã tồn tại.");
                request.getRequestDispatcher("/view/route/add.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "⚠️ Có lỗi xảy ra, vui lòng thử lại.");
            request.getRequestDispatcher("/view/route/add.jsp").forward(request, response);
        }
    }

    private void updateRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            int routeId = Integer.parseInt(request.getParameter("routeId"));
            String name = request.getParameter("routeName");
            String type = request.getParameter("type");
            String freqStr = request.getParameter("frequency");
            String[] stationIds = request.getParameterValues("stationIds"); // danh sách stationId mới từ form

            // ===== VALIDATION =====
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "⚠️ Tên tuyến không được để trống!");
                request.getRequestDispatcher("/view/route/edit.jsp").forward(request, response);
                return;
            }

            name = name.trim();
            type = type != null ? type.trim() : "";

            // Chuyển frequency sang int và kiểm tra số nguyên dương
            int frequency;
            try {
                frequency = Integer.parseInt(freqStr);
                if (frequency <= 0) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "⚠️ Tần suất phải là số nguyên dương!");
                request.getRequestDispatcher("/view/route/edit.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trùng tên (trừ chính tuyến đang cập nhật)
            if (routeServices.isRouteNameExistForOtherId(name, routeId)) {
                request.setAttribute("errorMessage", "❌ Tuyến \"" + name + "\" đã tồn tại trong hệ thống!");
                request.getRequestDispatcher("/view/route/edit.jsp").forward(request, response);
                return;
            }

            // ===== CẬP NHẬT TUYẾN =====
            Route route = new Route(routeId, name, type, frequency);
            boolean updated = routeServices.updateRoute(route);

            if (updated) {
                // ===== CẬP NHẬT TRẠM =====
                if (stationIds != null) {
                    // Xóa tất cả trạm cũ trước khi thêm mới
                    routeServices.deleteAllStationsFromRoute(routeId);
                    int order = 1;
                    for (String sid : stationIds) {
                        int stationId = Integer.parseInt(sid);
                        routeServices.addStationToRoute(routeId, stationId, order++, 0);
                    }
                }
                // Thông báo thành công
                request.getSession().setAttribute("message", "✅ Cập nhật tuyến \"" + name + "\" thành công!");
                response.sendRedirect("RouteServlet?action=list");
            } else {
                request.setAttribute("errorMessage", "⚠️ Không thể cập nhật. Tuyến không tồn tại hoặc dữ liệu trùng!");
                request.getRequestDispatcher("/view/route/edit.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ ID tuyến không hợp lệ!");
            request.getRequestDispatcher("/view/route/edit.jsp").forward(request, response);
        }
    }

    private void deleteRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            // 🔹 Lấy thông tin tuyến trước khi xóa
            Route route = routeServices.getRouteById(id);
            if (route == null) {
                request.getSession().setAttribute("errorMessage", "⚠️ Không tìm thấy tuyến có ID " + id + "!");
            } else {
                boolean deleted = routeServices.deleteRoute(id);
                if (deleted) {
                    request.getSession().setAttribute("message",
                            "🗑️ Xóa tuyến \"" + route.getRouteName() + "\" (ID: " + id + ") thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage",
                            "❌ Không thể xóa tuyến \"" + route.getRouteName() + "\"! Có thể đang được tham chiếu ở bảng khác.");
                }
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "⚠️ ID tuyến không hợp lệ, không thể xóa!");
        }
        response.sendRedirect("RouteServlet?action=list");
    }

    public void showAssignForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        try {
            int routeId = Integer.parseInt(request.getParameter("id"));
            Route route = routeServices.getRouteWithStations(routeId);
            List<Station> allStations = stationServices.getAllStations();
            request.setAttribute("route", route);
            request.setAttribute("allStations", allStations);
            request.getRequestDispatcher("/view/route/assign.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ ID tuyến không hợp lệ!");
            request.getRequestDispatcher("/view/route/list.jsp").forward(request, response);
        }
    }

    private void saveAssignedStations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int routeId = Integer.parseInt(request.getParameter("routeId"));
        String[] stationIds = request.getParameterValues("stationIds");

        if (stationIds != null) {
            // Xóa hết trạm cũ
            routeServices.deleteAllStationsFromRoute(routeId);

            for (String sid : stationIds) {
                try {
                    // Lấy index tương ứng
                    int index = Integer.parseInt(request.getParameter("index_of_" + sid));

                    // Lấy thứ tự và thời gian dự kiến từ input tương ứng index
                    int order = Integer.parseInt(request.getParameter("stationOrder_" + index));
                    int time = Integer.parseInt(request.getParameter("estimatedTime_" + index));

                    routeServices.addStationToRoute(routeId, Integer.parseInt(sid), order, time);
                } catch (NumberFormatException e) {
                    // bỏ qua nếu có lỗi số
                }
            }
        }

        request.getSession().setAttribute("message", "✅ Cập nhật danh sách trạm cho tuyến thành công!");
        response.sendRedirect("RouteServlet?action=details&id=" + routeId);
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

}
