package TripModule.controller;

import TripModule.model.Trip;
import TripModule.service.ITripService;
import TripModule.service.TripService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/trip")
public class TripController extends HttpServlet {

    private ITripService tripService;

    @Override
    public void init() throws ServletException {
        tripService = new TripService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

        try {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "detail":
                    showTripDetail(request, response);
                    break;
                case "search":
                    searchTrips(request, response);
                    break;
                default:
                    listTrips(request, response);
                    break;
            }
        } catch (Exception e) {
            handleError(request, response, e, "Error when processing GET action: " + action);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

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
            handleError(request, response, e, "Error when processing POST action: " + action);
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
                if (request.getParameter("page") != null)
                    page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }

            List<Trip> trips = tripService.findTrips(search, filter, sort, page, pageSize);
            int total = tripService.countTrips(search, filter);

            request.setAttribute("trips", trips);
            request.setAttribute("total", total);
            request.getRequestDispatcher("TripList.jsp").forward(request, response);

        } catch (SQLException e) {
            handleError(request, response, e, "Cannot load trip list from database.");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("AddTrip.jsp").forward(request, response);
    }

    private void addTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String> error = new ArrayList<>();

        String routeIdStr = request.getParameter("routeId");
        String busIdStr = request.getParameter("busId");
        String driverIdStr = request.getParameter("driverId");
        String conductorIdStr = request.getParameter("conductorId");
        String departureStr = request.getParameter("departureTime");
        String arrivalStr = request.getParameter("arrivalTime");

        int routeId = 0, busId = 0;
        UUID driverId = null, conductorId = null;
        LocalTime departure = null, arrival = null;

        // ===== VALIDATION =====
        try {
            routeId = Integer.parseInt(routeIdStr);
            if (routeId <= 0)
                error.add("Route ID must be a positive integer.");
        } catch (NumberFormatException e) {
            error.add("Route ID must be a valid number.");
        }

        try {
            busId = Integer.parseInt(busIdStr);
            if (busId <= 0)
                error.add("Bus ID must be a positive integer.");
        } catch (NumberFormatException e) {
            error.add("Bus ID must be a valid number.");
        }

        try {
            driverId = UUID.fromString(driverIdStr);
        } catch (Exception e) {
            error.add("Invalid Driver ID format.");
        }

        try {
            conductorId = UUID.fromString(conductorIdStr);
        } catch (Exception e) {
            error.add("Invalid Conductor ID format.");
        }

        try {
            departure = LocalTime.parse(departureStr);
            arrival = LocalTime.parse(arrivalStr);
            if (arrival.isBefore(departure))
                error.add("Arrival time cannot be earlier than departure time.");
        } catch (Exception e) {
            error.add("Departure or Arrival time must be in HH:mm:ss format.");
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("AddTrip.jsp").forward(request, response);
            return;
        }

        // ===== BUSINESS =====
        Trip trip = new Trip();
        trip.setRouteId(routeId);
        trip.setBusId(busId);
        trip.setDriverId(driverId);
        trip.setConductorId(conductorId);
        trip.setDepartureTime(departure);
        trip.setArrivalTime(arrival);
        trip.setStatus("NOT_STARTED");

        try {
            boolean success = tripService.insertTrip(trip);
            if (success) {
                response.sendRedirect("trip?action=list");
            } else {
                error.add("Failed to add trip due to database error.");
                request.setAttribute("error", error);
                request.getRequestDispatcher("AddTrip.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            handleError(request, response, e, "Database error while adding trip.");
        }
    }

    private void updateTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<String> error = new ArrayList<>();
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            String status = request.getParameter("status");

            if (status == null || status.isBlank()) {
                error.add("Status cannot be empty.");
            }

            if (!error.isEmpty()) {
                request.setAttribute("error", error);
                showEditForm(request, response);
                return;
            }

            boolean success = tripService.updateTripStatus(tripId, status);
            if (success) {
                response.sendRedirect("trip?action=list");
            } else {
                error.add("Update failed: invalid trip ID or no data changed.");
                request.setAttribute("error", error);
                showEditForm(request, response);
            }

        } catch (NumberFormatException e) {
            error.add("Trip ID must be a valid number.");
            request.setAttribute("error", error);
            showEditForm(request, response);
        } catch (SQLException e) {
            handleError(request, response, e, "Database error while updating trip.");
        }
    }

    private void deleteTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            boolean success = tripService.deleteTrip(tripId);
            if (!success)
                throw new SQLException("Trip not found or cannot be deleted.");
            response.sendRedirect("trip?action=list");
        } catch (NumberFormatException e) {
            handleError(request, response, e, "Trip ID must be a valid number.");
        } catch (SQLException e) {
            handleError(request, response, e, "Error deleting trip: " + e.getMessage());
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            Trip trip = tripService.findTripById(tripId);
            if (trip == null)
                throw new SQLException("Trip not found.");
            request.setAttribute("trip", trip);
            request.getRequestDispatcher("EditTrip.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, e, "Error loading edit form.");
        }
    }

    private void showTripDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            Trip trip = tripService.getTripDetail(tripId);
            if (trip == null)
                throw new SQLException("Trip not found.");
            request.setAttribute("trip", trip);
            request.getRequestDispatcher("TripDetail.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, e, "Error loading trip detail.");
        }
    }

    private void searchTrips(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        listTrips(request, response); // dùng cùng hàm list có search/filter/sort
    }

    // ======================  ERROR HANDLER ======================
    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e, String message)
            throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("errorMessage", message + " → " + e.getMessage());
        request.getRequestDispatcher("Error.jsp").forward(request, response);
    }
}
