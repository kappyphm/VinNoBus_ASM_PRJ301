package module.station.model.entity;

import java.util.List;

public class Station {

    private int stationId;
    private String stationName;
    private String location;
    private List<String> routeNames;

    public Station() {
    }

    public Station(String stationName, String location) {
        this.stationName = stationName;
        this.location = location;
    }

    public Station(int stationId, String stationName, String location) {
        this.stationId = stationId;
        this.stationName = stationName;
        this.location = location;
    }

    public Station(int stationId, String stationName, String location, List<String> routeNames) {
        this.stationId = stationId;
        this.stationName = stationName;
        this.location = location;
        this.routeNames = routeNames;
    }

    public int getStationId() {
        return stationId;
    }

    public void setStationId(int stationId) {
        this.stationId = stationId;
    }

    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public List<String> getRouteNames() {
        return routeNames;
    }

    public void setRouteNames(List<String> routeNames) {
        this.routeNames = routeNames;
    }

}
