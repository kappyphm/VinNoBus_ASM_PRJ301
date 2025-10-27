package module.route.model.entity;

import module.station.model.entity.Station;
import java.util.List;

public class Route {

    private int routeId;
    private String routeName;
    private String type;
    private int frequency;
    private List<Station> stations;
    private int estimatedTime;

    public Route() {
    }

    public Route(int routeId, String routeName, String type, int frequency) {
        this.routeId = routeId;
        this.routeName = routeName;
        this.type = type;
        this.frequency = frequency;
    }

    public Route(int routeId, String routeName, String type, int frequency, List<Station> stations, int estimatedTime) {
        this.routeId = routeId;
        this.routeName = routeName;
        this.type = type;
        this.frequency = frequency;
        this.stations = stations;
        this.estimatedTime = estimatedTime;
    }

    public int getRouteId() {
        return routeId;
    }

    public String getRouteName() {
        return routeName;
    }

    public String getType() {
        return type;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setRouteId(int routeId) {
        this.routeId = routeId;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public List<Station> getStations() {
        return stations;
    }

    public void setStations(List<Station> stations) {
        this.stations = stations;
    }

    public int getEstimatedTime() {
        return estimatedTime;
    }

    public void setEstimatedTime(int estimatedTime) {
        this.estimatedTime = estimatedTime;
    }

}
