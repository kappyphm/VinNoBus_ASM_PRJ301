
package TripModule.dto;

import java.time.LocalTime;
import java.util.UUID;

public class TripDTO {
    private int tripId;
    private int routeId;
    private int busId;
    private UUID driverId;
    private UUID conductorId;
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

    public UUID getDriverId() {
        return driverId;
    }

    public UUID getConductorId() {
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
