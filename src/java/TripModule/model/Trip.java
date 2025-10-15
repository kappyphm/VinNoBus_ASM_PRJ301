package TripModule.model;

import java.sql.Time;
import java.util.UUID;

public class Trip {

    private int tripId;
    private int routeId;
    private int busId;
    private UUID driverId;
    private UUID conductorId;
    private Time departureTime;
    private Time arrivalTime;
    private String status;

    public Trip() {
    }

    public Trip(int tripId, int routeId, int busId, UUID driverId, UUID conductorId, Time departureTime, Time arrivalTime, String status) {
        this.tripId = tripId;
        this.routeId = routeId;
        this.busId = busId;
        this.driverId = driverId;
        this.conductorId = conductorId;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.status = status;
    }

    public Trip(int routeId, int busId, UUID driverId, UUID conductorId, Time departureTime, Time arrivalTime, String status) {
        this.routeId = routeId;
        this.busId = busId;
        this.driverId = driverId;
        this.conductorId = conductorId;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.status = status;
    }

    public int getTripId() {
        return tripId;
    }

    public void setTripId(int tripId) {
        this.tripId = tripId;
    }

    public int getRouteId() {
        return routeId;
    }

    public void setRouteId(int routeId) {
        this.routeId = routeId;
    }

    public int getBusId() {
        return busId;
    }

    public void setBusId(int busId) {
        this.busId = busId;
    }

    public UUID getDriverId() {
        return driverId;
    }

    public void setDriverId(UUID driverId) {
        this.driverId = driverId;
    }

    public UUID getConductorId() {
        return conductorId;
    }

    public void setConductorId(UUID conductorId) {
        this.conductorId = conductorId;
    }

    public Time getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Time departureTime) {
        this.departureTime = departureTime;
    }

    public Time getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Time arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
