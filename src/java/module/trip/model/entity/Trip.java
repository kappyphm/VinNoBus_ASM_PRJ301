
package module.trip.model.entity;

import java.time.LocalDateTime;


public class Trip {

    private int tripId;
    private int routeId;
    private int busId;
    private String driverId;
    private String conductorId;
    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;
    private String status;

    public Trip() {
    }

    public Trip(int tripId, int routeId, int busId, String driverId, String conductorId, LocalDateTime departureTime, LocalDateTime arrivalTime, String status) {
        this.tripId = tripId;
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

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getConductorId() {
        return conductorId;
    }

    public void setConductorId(String conductorId) {
        this.conductorId = conductorId;
    }

    public LocalDateTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalDateTime departureTime) {
        this.departureTime = departureTime;
    }

    public LocalDateTime getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(LocalDateTime arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    
}
