package module.station.model.dto;

import java.util.List;

public class StationDTO {

    private int stationId;
    private String stationName;
    private String location;
    private String openTime;
    private String closeTime;
    private List<String> routeNames;

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
