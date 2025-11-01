
package TripModule.dto;

import java.time.LocalTime;
public class TripDTO {
    private int tripId;
    private int routeId;
    private int busId;
    private String driverId;
    private String conductorId;
    private LocalTime departuretime;
    private LocalTime arrivaltime;
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

    public String getDriverId() {
        return driverId;
    }

    public String getConductorId() {
        return conductorId;
    }

    public LocalTime getDeparturetime() {
        return departuretime;
    }

    public LocalTime getArrivaltime() {
        return arrivaltime;
    }

    public String getStatus() {
        return status;
    }

}
