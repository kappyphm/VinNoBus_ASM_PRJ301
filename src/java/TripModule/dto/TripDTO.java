package TripModule.dto;

import java.sql.Time;
import java.util.UUID;

public class TripDTO {

    private int tripId;
    private int routeId;
    private int busId;
    private UUID driverId;
    private UUID conductorId;
    private Time departureTime;
    private Time arrivalTime;
    private String status;

    public int getTripId() {
        return tripId;
    }

    public int getRouteId() {
        return routeId;
    }

    public int getBusId() {
        return busId;
    }

    public UUID getDriverId() {
        return driverId;
    }

    public UUID getConductorId() {
        return conductorId;
    }

    public Time getDepartureTime() {
        return departureTime;
    }

    public Time getArrivalTime() {
        return arrivalTime;
    }

    public String getStatus() {
        return status;
    }

    public void setTripId(int tripId) {                                 
        this.tripId = tripId;
    }

    public void setRouteId(int routeId) {
        this.routeId = routeId;
    }

    public void setBusId(int busId) {
        this.busId = busId;
    }

    public void setDriverId(UUID driverId) {
        this.driverId = driverId;
    }

    public void setConductorId(UUID conductorId) {
        this.conductorId = conductorId;
    }

    public void setDepartureTime(Time departureTime) {
        this.departureTime = departureTime;
    }

    public void setArrivalTime(Time arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
