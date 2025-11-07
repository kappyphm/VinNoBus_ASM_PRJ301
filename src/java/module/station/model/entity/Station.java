package module.station.model.entity;

import java.util.List;

public class Station {

    private int stationId;
    private String stationName;
    private String location;
    private List<String> routeNames;
    private int stationOrder;     // Thứ tự trên tuyến
    private int estimatedTime;    // Thời gian dự kiến giữa các trạm

    public Station() {
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

    public Station(int stationId, String stationName, String location,
            int stationOrder, int estimatedTime) {
        this.stationId = stationId;
        this.stationName = stationName;
        this.location = location;
        this.stationOrder = stationOrder;
        this.estimatedTime = estimatedTime;
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

    public int getStationOrder() {
        return stationOrder;
    }

    public void setStationOrder(int stationOrder) {
        this.stationOrder = stationOrder;
    }

    public int getEstimatedTime() {
        return estimatedTime;
    }

    public void setEstimatedTime(int estimatedTime) {
        this.estimatedTime = estimatedTime;
    }
}
