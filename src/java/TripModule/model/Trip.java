
package TripModule.model;

import java.time.LocalTime;
import java.util.UUID;

public class Trip {

    private int tripId;
    private int routeId;
    private int busId;
    private UUID driverId;
    private UUID conductorId;
    private LocalTime departureTime;
    private LocalTime arrivalTime;
    private String status;

    public Trip() {
    }

    public Trip(int tripId, int routeId, int busId, UUID driverId, UUID conductorId, LocalTime departureTime, LocalTime arrivalTime, String status) {
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

    public LocalTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalTime departureTime) {
        this.departureTime = departureTime;
    }

    public LocalTime getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(LocalTime arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
