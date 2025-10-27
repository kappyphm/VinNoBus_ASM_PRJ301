/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package module.bus.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.List;
import module.bus.model.entity.Bus;
import module.bus.service.BusServices;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BusServlet", urlPatterns = {"/BusServlet"})
public class BusServlet extends HttpServlet {

    BusServices busServices;

    @Override
    public void init() throws ServletException {
        busServices = new BusServices();
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
            out.println("<title>Servlet BusServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BusServlet at " + request.getContextPath() + "</h1>");
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
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteBus(request, response);
                    break;
                case "search":
                    searchBus(request, response);
                    break;
                case "detail":
                    showDetail(request, response);
                    break;
                default:
                    listBus(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi xử lý yêu cầu: " + e.getMessage(), e);
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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        try {
            switch (action) {
                case "add":
                    insertBus(request, response);
                    break;
                case "update":
                    updateBus(request, response);
                    break;
                default:
                    listBus(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi xử lý yêu cầu POST: " + e.getMessage(), e);
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

    private void listBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Bus> list = busServices.getAllBuses(search, sort, page, pageSize);
        int total = busServices.countAllBuses();
        int totalPages = (int) Math.ceil((double) total / pageSize);

        request.setAttribute("busList", list);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/view/Bus/BusList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/Bus/BusAdd.jsp").forward(request, response);
    }

    private void insertBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String plate = request.getParameter("plate_number");
        String capStr = request.getParameter("capacity");

        if (plate == null || plate.trim().isEmpty()) {
            request.setAttribute("error", "Biển số xe không được để trống.");
            request.getRequestDispatcher("/view/Bus/BusAdd.jsp").forward(request, response);
            return;
        }

        int capacity;
        try {
            capacity = Integer.parseInt(capStr);
            if (capacity <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Sức chứa phải là số nguyên lớn hơn 0.");
            request.getRequestDispatcher("/view/Bus/BusAdd.jsp").forward(request, response);
            return;
        }
        Bus bus = new Bus(0, plate.trim(), capacity);
        boolean success = busServices.addBus(bus);

        if (success) {
            request.setAttribute("message", "✅ Thêm xe bus thành công: " + plate);
            listBus(request, response);
        } else {
            request.setAttribute("error", "❌ Thêm xe bus thất bại (có thể trùng biển số).");
            request.getRequestDispatcher("/view/Bus/BusAdd.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Bus bus = busServices.getBusById(id);

        if (bus == null) {
            request.setAttribute("error", "Không tìm thấy xe bus có ID: " + id);
            listBus(request, response);
            return;
        }

        request.setAttribute("bus", bus);
        request.getRequestDispatcher("/view/Bus/BusEditForm.jsp").forward(request, response);
    }

    private void updateBus(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Lấy dữ liệu từ form
        String idStr = request.getParameter("bus_id");
        String plate = request.getParameter("plate_number");
        String capStr = request.getParameter("capacity");

        // Biến giữ dữ liệu để JSP giữ lại khi lỗi
        request.setAttribute("bus_id", idStr);
        request.setAttribute("plate_number", plate);
        request.setAttribute("capacity", capStr);

        int id = 0;
        int capacity = 0;
        boolean hasError = false;

        // Kiểm tra ID hợp lệ
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error_general", "ID xe không hợp lệ.");
            hasError = true;
        }

        // Kiểm tra biển số
        if (plate == null || plate.trim().isEmpty()) {
            request.setAttribute("error_plate", "Biển số xe không được để trống.");
            hasError = true;
        }

        // Kiểm tra capacity
        try {
            capacity = Integer.parseInt(capStr);
            if (capacity <= 0) {
                request.setAttribute("error_capacity", "Sức chứa phải là số nguyên dương.");
                hasError = true;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error_capacity", "Sức chứa phải là số hợp lệ.");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("/view/Bus/BusEditForm.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Bus
        Bus bus = new Bus(id, plate.trim(), capacity);

        try {
            boolean success = busServices.updateBus(bus);

            if (success) {
                request.setAttribute("message", "✅ Cập nhật xe bus thành công: " + plate);
                listBus(request, response);
            } else {
                request.setAttribute("error_general", "❌ Cập nhật thất bại, vui lòng thử lại.");
                request.getRequestDispatcher("/view/Bus/BusEditForm.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            String msg = e.getMessage().toLowerCase();
            if (msg.contains("uq__bus") || msg.contains("duplicate")) {
                request.setAttribute("error_plate", "❌ Biển số xe '" + plate + "' đã tồn tại trong hệ thống.");
            } else {
                request.setAttribute("error_general", "⚠️ Lỗi hệ thống: " + msg);
            }
            request.getRequestDispatcher("/view/Bus/BusEditForm.jsp").forward(request, response);
        }
    }

    private void deleteBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = busServices.deleteBus(id);

        if (success) {
            request.setAttribute("message", "🗑️ Xóa xe bus thành công (ID: " + id + ")");
        } else {
            request.setAttribute("error", "⚠️ Xóa xe bus thất bại. Xe có thể đang được sử dụng trong chuyến đi.");
        }

        listBus(request, response);
    }

    private void searchBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<Bus> list = busServices.searchBusByPlate(keyword);
        request.setAttribute("busList", list);

        if (list.isEmpty()) {
            request.setAttribute("error", "Không tìm thấy xe bus nào phù hợp với từ khóa: " + keyword);
        } else {
            request.setAttribute("message", "🔍 Tìm thấy " + list.size() + " xe bus phù hợp.");
        }
        request.getRequestDispatcher("/view/Bus/BusList.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Bus bus = busServices.getBusById(id);

        if (bus == null) {
            request.setAttribute("error", "Không tìm thấy xe bus có ID: " + id);
            listBus(request, response);
            return;
        }

        request.setAttribute("bus", bus);
        request.getRequestDispatcher("/view/Bus/BusDetail.jsp").forward(request, response);
    }
}
