
package module.trip.model.dto;

import java.sql.Timestamp;
public class TripDTO {
    private int tripId;
    private int routeId;
    private int busId;
    private String driverId;
    private String conductorId;
    private Timestamp departuretime;
    private Timestamp arrivaltime;
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

    public Timestamp getDeparturetime() {
        return departuretime;
    }

    public Timestamp getArrivaltime() {
        return arrivaltime;
    }

    public String getStatus() {
        return status;
    }

}
