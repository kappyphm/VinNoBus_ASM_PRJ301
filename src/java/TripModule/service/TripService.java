package TripModule.service;

import TripModule.dao.ITripDAO;
import TripModule.dao.TripDAO;
import TripModule.model.Trip;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class TripService implements ITripService {

    private final ITripDAO tripDAO = new TripDAO();

    // --- CRUD cơ bản ---
    @Override
    public boolean insertTrip(Trip trip) throws SQLException {
        // 🧠 Nghiệp vụ: kiểm tra hợp lệ trước khi thêm
        if (trip == null) {
            return false;
        }
        if (trip.getDepartureTime().isAfter(trip.getArrivalTime())) {
            return false;
        }

        // Kiểm tra trùng lịch
        if (!tripDAO.checkDriver(trip.getDriverId(), trip.getDepartureTime(), trip.getArrivalTime())) {
            return false;
        }
        if (!tripDAO.checkBus(trip.getBusId(), trip.getDepartureTime(), trip.getArrivalTime())) {
            return false;
        }
        if (!tripDAO.checkConductor(trip.getConductorId(), trip.getDepartureTime(), trip.getArrivalTime())) {
            return false;
        }

        return tripDAO.insertTrip(trip);
    }

    @Override
    public boolean updateTrip(Trip trip) throws SQLException {
        // 🧠 Nghiệp vụ: đảm bảo giờ hợp lệ và không trùng chuyến khác
        if (trip == null) {
            return false;
        }
        if (trip.getDepartureTime().isAfter(trip.getArrivalTime())) {
            return false;
        }

        if (!tripDAO.checkDriver(trip.getDriverId(), trip.getDepartureTime(), trip.getArrivalTime())) {
            return false;
        }
        if (!tripDAO.checkBus(trip.getBusId(), trip.getDepartureTime(), trip.getArrivalTime())) {
            return false;
        }
        if (!tripDAO.checkConductor(trip.getConductorId(), trip.getDepartureTime(), trip.getArrivalTime())) {
            return false;
        }

        return tripDAO.updateTrip(trip);
    }

    @Override
    public boolean deleteTrip(int tripId) throws SQLException {
        return tripDAO.deleteTrip(tripId);
    }

    @Override
    public Trip findTripById(int tripId) throws SQLException {
        return tripDAO.findTripById(tripId);
    }

    // --- Danh sách & tìm kiếm ---
    @Override
    public List<Trip> findAllTrips() throws SQLException {
        return tripDAO.findAllTrips();
    }

    @Override
    public List<Trip> findTrips(String search, String filter, String sort, int page, int pageSize) throws SQLException {
        return tripDAO.findTrips(search, filter, sort, page, pageSize);
    }

    @Override
    public int countTrips(String search, String filter) throws SQLException {
        return tripDAO.countTrips(search, filter);
    }

    // --- Chi tiết ---
    @Override
    public Trip getTripDetail(int tripId) throws SQLException {
        return tripDAO.getTripDetail(tripId);
    }

    // --- Phân công ---
    @Override
    public boolean assignRoute(int tripId, int routeId) throws SQLException {
        return tripDAO.assignRoute(tripId, routeId);
    }

    @Override
    public boolean assignBus(int tripId, int busId) throws SQLException {
        return tripDAO.assignBus(tripId, busId);
    }

    @Override
    public boolean assignDriver(int tripId, String driverId) throws SQLException {
        return tripDAO.assignDriver(tripId, driverId);
    }

    @Override
    public boolean assignConductor(int tripId, String conductorId) throws SQLException {
        return tripDAO.assignConductor(tripId, conductorId);
    }

    // --- Thời gian & trạng thái ---
    @Override
    public boolean updateTripTime(int tripId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException {
        if (departureTime.isAfter(arrivalTime)) {
            return false;
        }
        return tripDAO.updateTripTime(tripId, departureTime, arrivalTime);
    }

    @Override
    public boolean updateTripStatus(int tripId, String status) throws SQLException {
        if (status == null || status.isBlank()) {
            return false;
        }
        return tripDAO.updateTripStatus(tripId, status);
    }

    // --- Tìm kiếm theo đối tượng ---
    @Override
    public List<Trip> findTripsByDriver(String driverId) throws SQLException {
        return tripDAO.findTripsByDriver(driverId);
    }

    @Override
    public List<Trip> findTripsByConductor(String conductorId) throws SQLException {
        return tripDAO.findTripsByConductor(conductorId);
    }

    @Override
    public List<Trip> findTripsByBus(int busId) throws SQLException {
        return tripDAO.findTripsByBus(busId);
    }

    @Override
    public List<Trip> findTripsByRoute(int routeId) throws SQLException {
        return tripDAO.findTripsByRoute(routeId);
    }

    @Override
    public List<Trip> findTripsByTime(LocalDateTime from, LocalDateTime to) throws SQLException {
        return tripDAO.findTripsByTime(from, to);
    }

    // --- Validation ---
    @Override
    public boolean checkDriver(String driverId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException {
        return tripDAO.checkDriver(driverId, departureTime, arrivalTime);
    }

    @Override
    public boolean checkBus(int busId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException {
        return tripDAO.checkBus(busId, departureTime, arrivalTime);
    }

    @Override
    public boolean checkConductor(String conductorId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException {
        return tripDAO.checkConductor(conductorId, departureTime, arrivalTime);
    }
}
