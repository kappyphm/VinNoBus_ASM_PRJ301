// File: module/trip/service/TripService.java
package module.trip.service;

import module.trip.dao.ITripDAO;
import module.trip.dao.TripDAO;
import module.trip.model.entity.Trip;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class TripService implements ITripService {

    private final ITripDAO tripDAO = new TripDAO();

    @Override
    public Trip insertShellTrip(int routeId) throws SQLException {
        if (routeId <= 0) {
            return null;
        }
        return tripDAO.insertShellTrip(routeId);
    }
    @Override
    public boolean updateTrip(Trip trip) throws SQLException {
        if (trip == null) {
            return false;
        }
        if (trip.getDepartureTime() != null && trip.getArrivalTime() != null) {
            if (trip.getDepartureTime().after(trip.getArrivalTime())) {
                System.out.println("⚠️ Giờ đi sau giờ đến!");
                return false;
            }
            
            if (trip.getDriverId() != null && !trip.getDriverId().isBlank()) {
                if (!tripDAO.checkDriver(trip.getDriverId(), trip.getDepartureTime(), trip.getArrivalTime(), trip.getTripId())) {
                    System.out.println("⚠️ Driver trùng lịch!");
                    return false;
                }
            }
            
            if (trip.getBusId() > 0) {
                 if (!tripDAO.checkBus(trip.getBusId(), trip.getDepartureTime(), trip.getArrivalTime(), trip.getTripId())) {
                    System.out.println("⚠️ Bus trùng lịch!");
                    return false;
                }
            }
            
            if (trip.getConductorId() != null && !trip.getConductorId().isBlank()) {
                if (!tripDAO.checkConductor(trip.getConductorId(), trip.getDepartureTime(), trip.getArrivalTime(), trip.getTripId())) {
                    System.out.println("⚠️ Conductor trùng lịch!");
                    return false;
                }
            }
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

    @Override
    public List<Trip> findTrips() throws SQLException {
        return tripDAO.findAllTrips();
    }

    @Override
    public List<Trip> findTrips(String search, String filter, String sortCol, String sortDir, int page, int pageSize) throws SQLException {
        return tripDAO.findAllTrips(search, filter, sortCol, sortDir, page, pageSize);
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
    public boolean updateTripTime(int tripId, Timestamp departureTime, Timestamp arrivalTime) throws SQLException {
        if (departureTime.after(arrivalTime)) {
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
    public List<Trip> findTripsByTime(Timestamp from, Timestamp to) throws SQLException {
        return tripDAO.findTripsByTime(from, to);
    }

    // --- Validation ---
    @Override
    public boolean checkDriver(String driverId, Timestamp departureTime, Timestamp arrivalTime, int tripId) throws SQLException {
        return tripDAO.checkDriver(driverId, departureTime, arrivalTime,tripId);
    }

    @Override
    public boolean checkBus(int busId, Timestamp departureTime, Timestamp arrivalTime, int tripId) throws SQLException {
        return tripDAO.checkBus(busId, departureTime, arrivalTime, tripId);
    }

    @Override
    public boolean checkConductor(String conductorId, Timestamp departureTime, Timestamp arrivalTime, int tripId) throws SQLException {
        return tripDAO.checkConductor(conductorId, departureTime, arrivalTime, tripId);
    }
}