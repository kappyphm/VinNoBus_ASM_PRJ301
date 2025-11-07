package module.station.service;

import module.station.dao.StationDAO;
import module.station.model.entity.Station;
import java.util.List;

public class StationServices {

    private final StationDAO stationDAO;

    public StationServices() {
        this.stationDAO = new StationDAO();
    }

    // Lấy toàn bộ danh sách trạm
    public List<Station> getAllStations() {
        return stationDAO.getAll();
    }

    // Lấy thông tin trạm theo ID
    public Station getStationById(int id) {
        return stationDAO.getById(id);
    }

    // Tìm trạm theo tên
    public List<Station> findStationsByName(String name) {
        return stationDAO.getByName(name);
    }

    // Thêm trạm mới
    public boolean createStation(Station station) {
        return stationDAO.create(station);
    }

    // Cập nhật trạm
    public boolean updateStation(Station station) {
        return stationDAO.update(station);
    }

    // Xóa trạm
    public boolean deleteStation(int id) {
        return stationDAO.delete(id);
    }

    public List<Station> getStationsByPage(int page, int pageSize) {
        return stationDAO.getStationsByPage(page, pageSize);
    }

    public int getTotalStations() {
        return stationDAO.getTotalStations();
    }

    public List<Station> searchStationsByNameFuzzy(String name) {
        return stationDAO.searchStationsByNameFuzzy(name);
    }

    public List<Station> getStationsWithLatestRoutes() {
        return stationDAO.getAllStationsWithRoutes();
    }

    public List<Station> getStationsByPageWithRoutes(int page, int pageSize) {
        return stationDAO.getStationsByPageWithRoutes(page, pageSize);
    }

}
