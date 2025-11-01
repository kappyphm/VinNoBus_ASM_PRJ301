
package TripModule.dao;

import TripModule.model.Trip;
import java.sql.*;
import java.time.LocalTime;
import java.util.List;

public interface ITripDAO {

    //CRUD
    public boolean insertTrip(Trip trip) throws SQLException;

    public boolean updateTrip(Trip trip) throws SQLException;

    public boolean deleteTrip(int tripId) throws SQLException;

    public Trip findTripById(int tripID) throws SQLException;

    //List & Filter
    public List<Trip> findAllTrips() throws SQLException;

    public List<Trip> findTrips(String search, String filter, String sort, int page, int pageSize) throws SQLException;

    public int countTrips(String search, String filter) throws SQLException;

    //Detail view
    public Trip getTripDetail(int tripId) throws SQLException;

    //Assignment
    public boolean assignRoute(int tripId, int routeId) throws SQLException;

    public boolean assignBus(int tripId, int busId) throws SQLException;

    public boolean assignDriver(int tripId, String driverId) throws SQLException;

    public boolean assignConductor(int tripId, String conductorId) throws SQLException;

    //Status & Time
    public boolean updateTripTime(int tripId, LocalTime departureTime, LocalTime arrivalTime) throws SQLException;

    public boolean updateTripStatus(int tripId, String status) throws SQLException;

    //Find
    List<Trip> findTripsByDriver(String driverId) throws SQLException;

    List<Trip> findTripsByConductor(String conductorId) throws SQLException;

    List<Trip> findTripsByBus(int busId) throws SQLException;

    List<Trip> findTripsByRoute(int routeId) throws SQLException;

    List<Trip> findTripsByTime(LocalTime from, LocalTime to) throws SQLException;

    //Validation
    public boolean checkDriver(String driverId, LocalTime departure, LocalTime arrival) throws SQLException;

    public boolean checkBus(int busId, LocalTime departure, LocalTime arrival) throws SQLException;

    public boolean checkConductor(String conductorId, LocalTime departure, LocalTime arrival) throws SQLException;//kiem tra validation o service
}
