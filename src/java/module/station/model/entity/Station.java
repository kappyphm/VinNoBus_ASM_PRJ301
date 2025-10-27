package module.station.model.entity;

import java.util.List;

public class Station {

    private int stationId;
    private String stationName;
    private String location;
    private String openTime;
    private String closeTime;
    private List<String> routeNames;

    public Station() {
    }

    public Station(String stationName, String location, String openTime, String closeTime) {
        this.stationName = stationName;
        this.location = location;
        this.openTime = openTime;
        this.closeTime = closeTime;
    }

    public Station(int stationId, String stationName, String location, String openTime, String closeTime) {
        this.stationId = stationId;
        this.stationName = stationName;
        this.location = location;
        this.openTime = openTime;
        this.closeTime = closeTime;
    }

    public Station(int stationId, String stationName, String location, String openTime, String closeTime, List<String> routeNames) {
        this.stationId = stationId;
        this.stationName = stationName;
        this.location = location;
        this.openTime = openTime;
        this.closeTime = closeTime;
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

    public String getOpenTime() {
        return openTime;
    }

    public void setOpenTime(String openTime) {
        this.openTime = openTime;
    }

    public String getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(String closeTime) {
        this.closeTime = closeTime;
    }

    public List<String> getRouteNames() {
        return routeNames;
    }

    public void setRouteNames(List<String> routeNames) {
        this.routeNames = routeNames;
    }

}
