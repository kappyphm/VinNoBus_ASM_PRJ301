package module.trip.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import module.trip.model.entity.Trip;
import module.trip.service.ITripService;
import module.trip.service.TripService;
import java.sql.Timestamp;

@WebServlet("/TripServlet")
public class TripServlet extends HttpServlet {

    private ITripService tripService;

    @Override
    public void init() throws ServletException {
        tripService = new TripService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        try {
            switch (action) {
                case "add" ->
                    showAddForm(request, response);
                case "edit" ->
                    showEditForm(request, response);
                case "detail" ->
                    showTripDetail(request, response);
                case "search" ->
                    searchTrips(request, response);
                case "list" ->
                    listTrips(request, response);
                default ->
                    response.sendError(404);
            }
        } catch (ServletException | IOException e) {
//            response.sendError(500,e.getMessage());
            request.setAttribute("errorMessage", "❌ Lỗi khi xử lý yêu cầu: " + e.getMessage());
            listTrips(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    addTrip(request, response);
                    break;
                case "update":
                    updateTrip(request, response);
                    break;
                case "delete":
                    deleteTrip(request, response);
                    break;
                default:
                    listTrips(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "❌ Lỗi khi xử lý hành động: " + e.getMessage());
            listTrips(request, response);
        }
    }

    // ======================  HANDLERS ======================
    private void listTrips(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String search = request.getParameter("search");
            String filter = request.getParameter("filter");
            String sort = request.getParameter("sort");

            int page = 1;
            int pageSize = 10;
            try {
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
            } catch (NumberFormatException ignored) {
            }

            List<Trip> trips = tripService.findTrips(search, filter, sort, page, pageSize);
            int total = tripService.countTrips(search, filter);

            request.setAttribute("trips", trips);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/view/Trip/tripList.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Không thể tải danh sách chuyến xe: " + e.getMessage());
            request.getRequestDispatcher("/view/Trip/tripList.jsp").forward(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/Trip/tripForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            Trip trip = tripService.findTripById(tripId);
            request.setAttribute("trip", trip);
            request.getRequestDispatcher("/view/Trip/tripEditForm.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "❌ Không thể tải thông tin chuyến xe để chỉnh sửa: " + e.getMessage());
            listTrips(request, response);
        }
    }

    private void addTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> errors = new ArrayList<>();

        String tripIdStr = request.getParameter("tripId");
        String routeIdStr = request.getParameter("routeId");
        String busIdStr = request.getParameter("busId");
        String driverId = request.getParameter("driverId");
        String conductorId = request.getParameter("conductorId");
        String departureStr = request.getParameter("departureTime");
        String arrivalStr = request.getParameter("arrivalTime");

        int tripId = 0, routeId = 0, busId = 0;
        Timestamp departureTime = null, arrivalTime = null;

        // Validation dữ liệu nhập
        try {
            routeId = Integer.parseInt(routeIdStr);
            if (routeId <= 0) {
                errors.add("Mã tuyến phải là số dương.");
            }
        } catch (NumberFormatException e) {
            errors.add("Mã tuyến không hợp lệ, vui lòng nhập số.");
        }

        try {
            busId = Integer.parseInt(busIdStr);
            if (busId <= 0) {
                errors.add("Mã xe buýt phải là số dương.");
            }
        } catch (NumberFormatException e) {
            errors.add("Mã xe buýt không hợp lệ, vui lòng nhập số.");
        }

        // Kiểm tra tên tài xế
        if (driverId == null || driverId.trim().isBlank()) {
            errors.add("Mã tài xế không được để trống.");
        }
// Kiểm tra tên phụ xe
        if (conductorId == null || conductorId.trim().isBlank()) {
            errors.add("Mã phụ xe không được để trống.");
        }
        try {
            departureTime = Timestamp.valueOf(departureStr);
            arrivalTime = Timestamp.valueOf(arrivalStr);
            if (departureTime.after(arrivalTime)) {
                errors.add("Giờ khởi hành phải trước giờ kết thúc.");
            }
        } catch (Exception e) {
            errors.add("Định dạng giờ không hợp lệ (đúng định dạng HH:mm).");
        }

        // Nếu có lỗi → trả về form cùng dữ liệu cũ
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("tripId", tripIdStr);
            request.setAttribute("routeId", routeIdStr);
            request.setAttribute("busId", busIdStr);
            request.setAttribute("driverId", driverId);
            request.setAttribute("conductorId", conductorId);
            request.setAttribute("departureTime", departureStr);
            request.setAttribute("arrivalTime", arrivalStr);
            request.getRequestDispatcher("/view/Trip/tripForm.jsp").forward(request, response);
            return;
        }

        Trip trip = new Trip(
                tripId,
                routeId,
                busId,
                driverId,
                conductorId,
                departureTime,
                arrivalTime,
                "NOT_STARTED"
        );

        try {
            if (tripService.insertTrip(trip)) {
                request.setAttribute("success", "✅ Thêm chuyến xe thành công!");
                listTrips(request, response);
                return;
            } else {
                errors.add("❌ Không thể thêm chuyến xe. Có thể trùng dữ liệu.");
                request.setAttribute("errors", errors);

                request.getRequestDispatcher("/view/Trip/tripForm.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            errors.add("Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/view/Trip/tripForm.jsp").forward(request, response);
        }
    }

    private void updateTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            int routeId = Integer.parseInt(request.getParameter("routeId"));
            int busId = Integer.parseInt(request.getParameter("busId"));
            String driverId = request.getParameter("driverId");
            String conductorId = request.getParameter("conductorId");
            String departureStr = request.getParameter("departureTime").replace("T", " ") + ":00";
            String arrivalStr = request.getParameter("arrivalTime").replace("T", " ") + ":00";
            Timestamp departureTime = Timestamp.valueOf(departureStr);
            Timestamp arrivalTime = Timestamp.valueOf(arrivalStr);

            String status = request.getParameter("status");

            Trip updatedTrip = new Trip(
                    tripId, routeId, busId, driverId, conductorId, departureTime, arrivalTime, status
            );

            boolean success = tripService.updateTrip(updatedTrip);
            if (success) {
                request.setAttribute("success", "✅ Cập nhật chuyến xe thành công!");
                listTrips(request, response);
                return;
            } else {
                errors.add("❌ Không thể cập nhật chuyến xe. Kiểm tra lại dữ liệu.");
                request.setAttribute("errors", errors);
            }

        } catch (Exception e) {
            errors.add("❌ Lỗi khi cập nhật: " + e.getMessage());
            request.setAttribute("errors", errors);
        }

        listTrips(request, response);
    }

    private void deleteTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            if (tripService.deleteTrip(tripId)) {
                request.setAttribute("success", "✅ Xóa chuyến xe thành công!");
            } else {
                request.setAttribute("errorMessage", "❌ Không thể xóa chuyến xe này.");
            }
            listTrips(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "❌ Lỗi khi xóa chuyến xe: " + e.getMessage());
            listTrips(request, response);
        }
    }

    private void showTripDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            Trip trip = tripService.getTripDetail(tripId);
            request.setAttribute("trip", trip);
            request.getRequestDispatcher("/view/Trip/tripDetail.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "❌ Không thể tải chi tiết chuyến xe: " + e.getMessage());
            listTrips(request, response);
        }
    }

    private void searchTrips(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        listTrips(request, response);
    }
}
