// File: module/trip/dao/ITripDAO.java
package module.trip.dao;

import module.trip.model.entity.Trip;
import java.sql.*;
import java.util.List;

public interface ITripDAO {

    //CRUD
    // boolean insertTrip(Trip trip) throws SQLException; // XÓA
    Trip insertShellTrip(int routeId) throws SQLException; // THÊM

    boolean updateTrip(Trip trip) throws SQLException;

    boolean deleteTrip(int tripId) throws SQLException;

    public Trip findTripById(int tripID) throws SQLException;

    //List & Filter
    public List<Trip> findAllTrips() throws SQLException;

    public List<Trip> findAllTrips(String search, String filter, String sortCol, String sortDir, int page, int pageSize) throws SQLException;

    public int countTrips(String search, String filter) throws SQLException;

    //Detail view
    public Trip getTripDetail(int tripId) throws SQLException;

    //Assignment
    public boolean assignRoute(int tripId, int routeId) throws SQLException;

    public boolean assignBus(int tripId, int busId) throws SQLException;

    public boolean assignDriver(int tripId, String driverId) throws SQLException;

    public boolean assignConductor(int tripId, String conductorId) throws SQLException;

    //Status & Time
    public boolean updateTripTime(int tripId, Timestamp departureTimeTime, Timestamp arrivalTimeTime) throws SQLException;

    public boolean updateTripStatus(int tripId, String status) throws SQLException;

    //Find
    List<Trip> findTripsByDriver(String driverId) throws SQLException;

    List<Trip> findTripsByConductor(String conductorId) throws SQLException;

    List<Trip> findTripsByBus(int busId) throws SQLException;

    List<Trip> findTripsByRoute(int routeId) throws SQLException;

    List<Trip> findTripsByTime(Timestamp from, Timestamp to) throws SQLException;

    //Validation
    public boolean checkDriver(String driverId, Timestamp departureTime, Timestamp arrivalTime,int tripId) throws SQLException;

    public boolean checkBus(int busId, Timestamp departureTime, Timestamp arrivalTime, int tripId) throws SQLException;

    public boolean checkConductor(String conductorId, Timestamp departureTime, Timestamp arrivalTime, int tripId) throws SQLException;//kiem tra validation o service
}