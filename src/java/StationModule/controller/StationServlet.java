/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StationModule.controller;

import StationModule.model.Station;
import StationModule.services.StationServices;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "StationServlet", urlPatterns = {"/StationServlet"})
public class StationServlet extends HttpServlet {

    private StationServices stationServices;

    @Override
    public void init() throws ServletException {
        stationServices = new StationServices(); // Khởi tạo Service khi servlet được load
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
            out.println("<title>Servlet StationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StationServlet at " + request.getContextPath() + "</h1>");
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
        switch (action) {
            case "list":
                listStations(request, response);
                break;
            case "view":
                viewStation(request, response);
                break;
            case "new":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStation(request, response);
                break;
            default:
                request.setAttribute("error", "⚠️ Hành động không hợp lệ: " + action);
                listStations(request, response);
                break;
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
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createStation(request, response);
                break;
            case "update":
                updateStation(request, response);
                break;
            default:
                request.setAttribute("error", "⚠️ Hành động POST không hợp lệ: " + action);
                listStations(request, response);
                break;
        }
    }

    private void listStations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Station> stations = stationServices.getAllStations();
        if (stations == null || stations.isEmpty()) {
            request.setAttribute("message", "📭 Hiện chưa có trạm xe nào trong hệ thống.");
        }
        request.setAttribute("stations", stations);
        request.getRequestDispatcher("/WEB-INF/Station/StationList.jsp").forward(request, response);
    }

    private void viewStation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            request.setAttribute("error", "❌ Bạn chưa chọn trạm để xem chi tiết.");
            listStations(request, response);
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            Station station = stationServices.getStationById(id);
            if (station == null) {
                request.setAttribute("error", "❌ Không tìm thấy trạm có mã ID = " + id + ".");
                listStations(request, response);
                return;
            }
            request.setAttribute("station", station);
            request.getRequestDispatcher("/WEB-INF/Station/StationDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "❌ Mã trạm phải là một số hợp lệ. Bạn đã nhập: " + idStr);
            listStations(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Station/StationAdd.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            request.setAttribute("error", "❌ Thiếu mã trạm để chỉnh sửa.");
            listStations(request, response);
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            Station station = stationServices.getStationById(id);
            if (station == null) {
                request.setAttribute("error", "❌ Không tìm thấy trạm có ID = " + id + " để chỉnh sửa.");
                listStations(request, response);
                return;
            }
            request.setAttribute("station", station);
            request.getRequestDispatcher("/WEB-INF/Station/StationEdit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "❌ ID trạm phải là số. Bạn đã nhập: " + idStr);
            listStations(request, response);
        }
    }

    private void deleteStation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            request.setAttribute("error", "Thiếu mã trạm để xóa.");
            request.getRequestDispatcher("/WEB-INF/Station/StationList.jsp").forward(request, response);
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            boolean success = stationServices.deleteStation(id);
            if (!success) {
                request.setAttribute("error", "Không thể xóa trạm (ID: " + id + "). Có thể trạm không tồn tại.");
                request.getRequestDispatcher("/WEB-INF/Station/StationList.jsp").forward(request, response);
                return;
            }
            response.sendRedirect("StationServlet?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID trạm phải là số hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/Station/StationList.jsp").forward(request, response);
        }
    }

    private void createStation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String name = request.getParameter("stationName");
            String location = request.getParameter("location");
            String openTime = request.getParameter("openTime");
            String closeTime = request.getParameter("closeTime");
            if (name == null || name.isEmpty()) {
                request.setAttribute("error", "Tên trạm không được để trống.");
                request.getRequestDispatcher("/WEB-INF/Station/StationAdd.jsp").forward(request, response);
                return;
            }
            Station newStation = new Station(0, name, location, openTime, closeTime, null);
            boolean created = stationServices.createStation(newStation);
            if (!created) {
                request.setAttribute("error", "Không thể thêm trạm mới. Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/Station/StationAdd.jsp").forward(request, response);
                return;
            }
            response.sendRedirect("StationServlet?action=list");
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi khi thêm trạm: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Station/StationAdd.jsp").forward(request, response);
        }
    }

    private void updateStation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("stationId"));
            String name = request.getParameter("stationName");
            String location = request.getParameter("location");
            String openTime = request.getParameter("openTime");
            String closeTime = request.getParameter("closeTime");
            if (name == null || name.isEmpty()) {
                request.setAttribute("error", "Tên trạm không được để trống.");
                request.getRequestDispatcher("/WEB-INF/Station/StationEdit.jsp").forward(request, response);
                return;
            }
            Station updated = new Station(id, name, location, openTime, closeTime, null);
            boolean success = stationServices.updateStation(updated);
            if (!success) {
                request.setAttribute("error", "Không thể cập nhật trạm (ID: " + id + ").");
                request.getRequestDispatcher("/WEB-INF/Station/StationEdit.jsp").forward(request, response);
                return;
            }
            response.sendRedirect("StationServlet?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID trạm không hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/Station/StationEdit.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật trạm: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/Station/StationEdit.jsp").forward(request, response);
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

}
