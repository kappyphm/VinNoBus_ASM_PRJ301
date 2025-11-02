
package TripModule.dto;

import java.time.LocalDateTime;
public class TripDTO {
    private int tripId;
    private int routeId;
    private int busId;
    private String driverId;
    private String conductorId;
    private LocalDateTime departuretime;
    private LocalDateTime arrivaltime;
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

    public LocalDateTime getDeparturetime() {
        return departuretime;
    }

    public LocalDateTime getArrivaltime() {
        return arrivaltime;
    }

    public String getStatus() {
        return status;
    }

}
