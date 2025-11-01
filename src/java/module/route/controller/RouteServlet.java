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
import module.route.model.entity.Route;
import module.route.service.RouteServices;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RouteServlet", urlPatterns = {"/RouteServlet"})
public class RouteServlet extends HttpServlet {

    private RouteServices routeServices;

    @Override
    public void init() throws ServletException {
        routeServices = new RouteServices();
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
                default:
                    listRoutes(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/view/Route/RouteList.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "⚠️ Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("/view/Route/RouteList.jsp").forward(request, response);
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
                default:
                    listRoutes(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Lỗi thao tác với cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/view/Route/RouteList.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "⚠️ Lỗi không xác định: " + e.getMessage());
            request.getRequestDispatcher("/view/Route/RouteList.jsp").forward(request, response);
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
        request.getRequestDispatcher("/view/Route/RouteList.jsp").forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Route route = routeServices.getRouteDetails(id);

            if (route == null) {
                request.setAttribute("errorMessage", "⚠️ Không tìm thấy thông tin tuyến xe có ID: " + id);
            } else {
                request.setAttribute("route", route);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ ID tuyến xe không hợp lệ!");
        }
        request.getRequestDispatcher("/view/Route/RouteDetails.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Route route = routeServices.getRouteById(id);

            if (route == null) {
                request.setAttribute("errorMessage", "⚠️ Không tìm thấy tuyến có ID: " + id);
            } else {
                request.setAttribute("route", route);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ ID không hợp lệ khi chỉnh sửa tuyến!");
        }
        request.getRequestDispatcher("/view/Route/RouteForm.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/Route/RouteAdd.jsp").forward(request, response);
    }

    private void addRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("routeName");
        String type = request.getParameter("type");
        String freqStr = request.getParameter("frequency");

        // Kiểm tra tên trống
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "⚠️ Tên tuyến không được để trống!");
            request.getRequestDispatcher("/view/Route/RouteAdd.jsp").forward(request, response);
            return;
        }

        // ✅ Kiểm tra trùng tên tuyến trước khi thêm
        if (routeServices.isRouteNameExist(name.trim())) {
            request.setAttribute("errorMessage", "❌ Tuyến \"" + name.trim() + "\" đã tồn tại trong hệ thống!");
            request.getRequestDispatcher("/view/Route/RouteAdd.jsp").forward(request, response);
            return;  
        }

        // Chuyển frequency sang int
        int frequency;
        try {
            frequency = Integer.parseInt(freqStr);
            if (frequency <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ Tần suất phải là số nguyên dương!");
            request.getRequestDispatcher("/view/Route/RouteAdd.jsp").forward(request, response);
            return;
        }

        Route route = new Route(0, name.trim(), type, frequency);
        boolean success = routeServices.addRoute(route);

        if (success) {
            request.getSession().setAttribute("message", "✅ Thêm tuyến \"" + name + "\" thành công!");
            response.sendRedirect("RouteServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "❌ Thêm thất bại! Có thể tuyến đã tồn tại.");
            request.getRequestDispatcher("/view/Route/RouteAdd.jsp").forward(request, response);
        }
    }

    private void updateRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("routeId"));
            String name = request.getParameter("routeName");
            String type = request.getParameter("type");
            int frequency = Integer.parseInt(request.getParameter("frequency"));

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "⚠️ Tên tuyến không được để trống!");
                request.getRequestDispatcher("/view/Route/RouteForm.jsp").forward(request, response);
                return;
            }
            // Kiểm tra trùng tên trước khi cập nhật (trừ chính tuyến đang chỉnh sửa)
            if (routeServices.isRouteNameExistForOtherId(name.trim(), id)) {
                request.setAttribute("errorMessage", "❌ Tuyến \"" + name.trim() + "\" đã tồn tại trong hệ thống!");
                request.getRequestDispatcher("/view/Route/RouteForm.jsp").forward(request, response);
                return;
            }

            Route route = new Route(id, name.trim(), type, frequency);
            boolean updated = routeServices.updateRoute(route);

            if (updated) {
                request.getSession().setAttribute("message", "✅ Cập nhật tuyến \"" + name + "\" thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "⚠️ Không thể cập nhật. Tuyến không tồn tại hoặc dữ liệu trùng!");
            }
            response.sendRedirect("RouteServlet?action=list");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "⚠️ Dữ liệu nhập vào không hợp lệ!");
            request.getRequestDispatcher("/view/Route/RouteForm.jsp").forward(request, response);
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
}
