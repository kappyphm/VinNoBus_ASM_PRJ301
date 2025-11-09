// File: module/trip/controller/TripServlet.java
package module.trip.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors; // Cần dùng

// === IMPORT SERVICE THẬT ===
import module.trip.model.entity.Trip;
import module.trip.service.ITripService;
import module.trip.service.TripService;
import module.user.model.dto.UserDetailDTO;
import module.user.service.UserService;
import module.route.model.entity.Route;
import module.route.service.RouteServices;
import module.bus.model.entity.Bus;
import module.bus.service.BusServices;
// === KẾT THÚC IMPORT ===


@WebServlet("/TripServlet")
public class TripServlet extends HttpServlet {

    private ITripService tripService;
    
    // === KHAI BÁO CÁC SERVICE THẬT ===
    private RouteServices routeService;
    private BusServices busService;
    private UserService userService;
    

    @Override
    public void init() throws ServletException {
        tripService = new TripService();
        
        // === KHỞI TẠO CÁC SERVICE THẬT ===
        routeService = new RouteServices();
        busService = new BusServices();
        userService = new UserService();
    }
    
    /**
     * Tải danh sách Tuyến (chỉ cho form tạo)
     */
    private void loadCreateFormDependencies(HttpServletRequest request) throws ServletException {
        try {
            // Lấy 1000 tuyến đầu tiên
            List<Route> routes = routeService.getAllRoutes(null, null, "route_id", "ASC", 1, 1000); //
            request.setAttribute("routesList", routes);
        } catch (Exception e) {
            throw new ServletException("Không thể tải danh sách tuyến", e);
        }
    }
    
    /**
     * Tải TẤT CẢ danh sách cho form Edit (Tuyến, Xe, Tài xế, Phụ xe)
     */
    private void loadEditFormDependencies(HttpServletRequest request) throws ServletException {
         try {
            List<Route> routes = routeService.getAllRoutes(null, null, "route_id", "ASC", 1, 1000); //
            List<Bus> buses = busService.getAllBuses(); //
            List<UserDetailDTO> allStaff = userService.getAllStaffDetails(); // Hàm mới

            // Phân loại Staff
            List<UserDetailDTO> drivers = allStaff.stream()
                .filter(s -> s.getStaff() != null && "DRIVER".equalsIgnoreCase(s.getStaff().getPosition()))
                .collect(Collectors.toList());
                
            List<UserDetailDTO> conductors = allStaff.stream()
                .filter(s -> s.getStaff() != null && "CONDUCTOR".equalsIgnoreCase(s.getStaff().getPosition()))
                .collect(Collectors.toList());

            request.setAttribute("routesList", routes);
            request.setAttribute("busesList", buses);
            request.setAttribute("driversList", drivers);
            request.setAttribute("conductorsList", conductors);
            
        } catch (Exception e) {
            throw new ServletException("Không thể tải dữ liệu cho form", e);
        }
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
                    showAddForm(request, response); // Bước 1: Mở form tạo
                case "edit" ->
                    showEditForm(request, response); // Bước 2: Mở form sửa (để gán)
                case "detail" ->
                    showTripDetail(request, response);
                case "list" ->
                    listTrips(request, response);
                default ->
                    response.sendError(404);
            }
        } catch (ServletException | IOException e) {
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
                case "createShell": // Bước 1: Xử lý tạo
                    createShellTrip(request, response);
                    break;
                case "update": // Bước 2: Xử lý cập nhật
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

    // ======================  HANDLERS (ĐÃ CẬP NHẬT) ======================
    
    private void listTrips(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // (Giữ nguyên code listTrips của bạn)
        try {
            String search = request.getParameter("search");
            String filter = request.getParameter("filter");
            String sortCol = request.getParameter("sortCol");
            String sortDir = request.getParameter("sortDir");

            int page = 1;
            int pageSize = 10;
            try {
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
            } catch (NumberFormatException ignored) {}

            List<Trip> trips = tripService.findTrips(search, filter, sortCol, sortDir, page, pageSize);
            int total = tripService.countTrips(search, filter);

            request.setAttribute("trips", trips);
            request.setAttribute("total", total);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);

            request.getRequestDispatcher("/view/trip/tripList.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "❌ Không thể tải danh sách chuyến xe: " + e.getMessage());
            request.getRequestDispatcher("/view/trip/tripList.jsp").forward(request, response);
        }
    }

    // (BƯỚC 1) Hiển thị form tạo chuyến (chỉ tải tuyến)
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadCreateFormDependencies(request);
        request.getRequestDispatcher("/view/trip/tripForm.jsp").forward(request, response);
    }

    // (BƯỚC 2) Hiển thị form sửa/cập nhật (tải tất cả)
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            Trip trip = tripService.findTripById(tripId);
            
            if (trip == null) {
                request.setAttribute("errorMessage", "❌ Không tìm thấy chuyến xe với ID: " + tripId);
                listTrips(request, response);
                return;
            }
            
            request.setAttribute("trip", trip);
            loadEditFormDependencies(request);
            
            request.getRequestDispatcher("/view/trip/tripEditForm.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "❌ Không thể tải thông tin chuyến xe để chỉnh sửa: " + e.getMessage());
            listTrips(request, response);
        }
    }

    // (BƯỚC 1) Xử lý tạo chuyến "vỏ"
    private void createShellTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String routeIdStr = request.getParameter("routeId");
        int routeId = 0;
        List<String> errors = new ArrayList<>();

        try {
            routeId = Integer.parseInt(routeIdStr);
        } catch (NumberFormatException e) {
            errors.add("Mã tuyến không hợp lệ. Vui lòng chọn từ danh sách.");
        }
        
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("routeId", routeIdStr);
            loadCreateFormDependencies(request); // Tải lại danh sách tuyến
            request.getRequestDispatcher("/view/trip/tripForm.jsp").forward(request, response);
            return;
        }
        
        try {
            Trip newTrip = tripService.insertShellTrip(routeId);
            
            if (newTrip != null) {
                // CHUYỂN HƯỚNG SANG TRANG EDIT
                response.sendRedirect("TripServlet?action=edit&tripId=" + newTrip.getTripId());
            } else {
                errors.add("❌ Không thể tạo chuyến xe.");
                request.setAttribute("errors", errors);
                request.setAttribute("routeId", routeIdStr);
                loadCreateFormDependencies(request);
                request.getRequestDispatcher("/view/trip/tripForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            errors.add("Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.setAttribute("errors", errors);
            request.setAttribute("routeId", routeIdStr);
            loadCreateFormDependencies(request);
            request.getRequestDispatcher("/view/trip/tripForm.jsp").forward(request, response);
        }
    }


    // (BƯỚC 2) Xử lý cập nhật đầy đủ
    private void updateTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<String> errors = new ArrayList<>();
        int tripId = 0;
        Trip updatedTrip = null; // Dùng để lưu lại dữ liệu nếu có lỗi

        try {
            tripId = Integer.parseInt(request.getParameter("tripId"));
            int routeId = Integer.parseInt(request.getParameter("routeId"));
            
            // Xử lý các trường có thể rỗng (mới tạo)
            int busId = 0; // Mặc định là 0
            if (request.getParameter("busId") != null && !request.getParameter("busId").isBlank()) {
                try {
                    busId = Integer.parseInt(request.getParameter("busId"));
                } catch (NumberFormatException e) {
                    errors.add("Mã xe buýt không hợp lệ.");
                }
            }
            
            String driverId = request.getParameter("driverId");
            String conductorId = request.getParameter("conductorId");
            
            // Xử lý thời gian (có thể rỗng)
            String departureStr = request.getParameter("departureTime");
            String arrivalStr = request.getParameter("arrivalTime");
            Timestamp departureTime = null;
            Timestamp arrivalTime = null;

            try {
                 if (departureStr != null && !departureStr.isEmpty()) {
                    departureTime = Timestamp.valueOf(departureStr.replace("T", " ") + ":00");
                 }
                 if (arrivalStr != null && !arrivalStr.isEmpty()) {
                    arrivalTime = Timestamp.valueOf(arrivalStr.replace("T", " ") + ":00");
                 }
                 
                 if (departureTime != null && arrivalTime != null && departureTime.after(arrivalTime)) {
                     errors.add("Giờ khởi hành phải trước giờ kết thúc.");
                 }
            } catch (IllegalArgumentException e) {
                 errors.add("Định dạng ngày giờ không hợp lệ.");
            }
            
            String status = request.getParameter("status");
            
            // Gói dữ liệu lại để gửi về form nếu lỗi
             updatedTrip = new Trip(
                    tripId, routeId, busId, driverId, conductorId, departureTime, arrivalTime, status
            );

            // Kiểm tra lỗi validation
             if (!errors.isEmpty()) {
                 request.setAttribute("errors", errors);
                 request.setAttribute("trip", updatedTrip);
                 loadEditFormDependencies(request); // Tải lại danh sách
                 request.getRequestDispatcher("/view/trip/tripEditForm.jsp").forward(request, response);
                 return;
             }
             
            // Mọi thứ OK, tiến hành cập nhật (Service sẽ lo validation)
            boolean success = tripService.updateTrip(updatedTrip);
            
            if (success) {
                request.setAttribute("success", "✅ Cập nhật chuyến xe thành công!");
                request.setAttribute("trip", updatedTrip); 
                loadEditFormDependencies(request); // Tải lại danh sách
                request.getRequestDispatcher("/view/trip/tripEditForm.jsp").forward(request, response);
            } else {
                 errors.add("❌ Không thể cập nhật. Dữ liệu không hợp lệ (ví dụ: Tài xế, Phụ xe, hoặc Xe buýt đã bị trùng lịch).");
                 request.setAttribute("errors", errors);
                 request.setAttribute("trip", updatedTrip);
                 loadEditFormDependencies(request); // Tải lại danh sách
                 request.getRequestDispatcher("/view/trip/tripEditForm.jsp").forward(request, response);
            }

        } catch (Exception e) {
            errors.add("❌ Lỗi nghiêm trọng khi cập nhật: " + e.getMessage());
            request.setAttribute("errors", errors);
             
            if (updatedTrip == null && tripId > 0) {
                 try { request.setAttribute("trip", tripService.findTripById(tripId)); } catch (SQLException ex) {}
            } else {
                 request.setAttribute("trip", updatedTrip);
            }
            
            loadEditFormDependencies(request);
            request.getRequestDispatcher("/view/trip/tripEditForm.jsp").forward(request, response);
        }
    }
    
    // (Hàm addTrip gốc đã bị xóa, thay bằng createShellTrip)
    
    private void deleteTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // (Giữ nguyên code deleteTrip của bạn)
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
        // (Giữ nguyên code showTripDetail của bạn)
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            Trip trip = tripService.getTripDetail(tripId);
            request.setAttribute("trip", trip);
            request.getRequestDispatcher("/view/trip/tripDetail.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "❌ Không thể tải chi tiết chuyến xe: " + e.getMessage());
            listTrips(request, response);
        }
    }
}