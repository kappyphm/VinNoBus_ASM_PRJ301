package module.trip.service;

import module.trip.model.entity.Trip;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public interface ITripService {

    // CRUD cơ bản
    boolean insertTrip(Trip trip) throws SQLException;

    boolean updateTrip(Trip trip) throws SQLException;

    boolean deleteTrip(int tripId) throws SQLException;

    Trip findTripById(int tripId) throws SQLException;

    // Danh sách & tìm kiếm
    List<Trip> findAllTrips() throws SQLException;

    List<Trip> findTrips(String search, String filter, String sort, int page, int pageSize) throws SQLException;

    int countTrips(String search, String filter) throws SQLException;

    // Chi tiết
    Trip getTripDetail(int tripId) throws SQLException;

    // Phân công
    boolean assignRoute(int tripId, int routeId) throws SQLException;

    boolean assignBus(int tripId, int busId) throws SQLException;

    boolean assignDriver(int tripId, String driverId) throws SQLException;

    boolean assignConductor(int tripId, String conductorId) throws SQLException;

    // Thời gian & trạng thái
    boolean updateTripTime(int tripId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException;

    boolean updateTripStatus(int tripId, String status) throws SQLException;

    // Tìm kiếm theo đối tượng
    List<Trip> findTripsByDriver(String driverId) throws SQLException;

    List<Trip> findTripsByConductor(String conductorId) throws SQLException;

    List<Trip> findTripsByBus(int busId) throws SQLException;

    List<Trip> findTripsByRoute(int routeId) throws SQLException;

    List<Trip> findTripsByTime(LocalDateTime from, LocalDateTime to) throws SQLException;

    // Validation
    boolean checkDriver(String driverId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException;

    boolean checkBus(int busId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException;

    boolean checkConductor(String conductorId, LocalDateTime departureTime, LocalDateTime arrivalTime) throws SQLException;

}
