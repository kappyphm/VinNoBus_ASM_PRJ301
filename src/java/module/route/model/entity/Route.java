package module.route.model.entity;

import java.util.List;
import module.station.model.dto.StationOnRouteDTO;

public class Route {

    private int routeId;
    private String routeName;
    private String type;
    private int frequency;

    // ✅ Danh sách trạm theo thứ tự (DTO đúng chuẩn)
    private List<StationOnRouteDTO> stations;

    // ✅ Tổng thời gian dự kiến của tuyến (phút)
    private int estimatedTime;

    public Route() {
    }

    public Route(int routeId, String routeName, String type, int frequency) {
        this.routeId = routeId;
        this.routeName = routeName;
        this.type = type;
        this.frequency = frequency;
    }

    public Route(int routeId, String routeName, String type, int frequency,
            List<StationOnRouteDTO> stations, int estimatedTime) {
        this.routeId = routeId;
        this.routeName = routeName;
        this.type = type;
        this.frequency = frequency;
        this.stations = stations;
        this.estimatedTime = estimatedTime;
    }

    // ===== GETTER / SETTER =====
    public int getRouteId() {
        return routeId;
    }

    public void setRouteId(int routeId) {
        this.routeId = routeId;
    }

    public String getRouteName() {
        return routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public List<StationOnRouteDTO> getStations() {
        return stations;
    }

    public void setStations(List<StationOnRouteDTO> stations) {
        this.stations = stations;
    }

    public int getEstimatedTime() {
        return estimatedTime;
    }

    public void setEstimatedTime(int estimatedTime) {
        this.estimatedTime = estimatedTime;
    }
}
