package module.station.dao;

import module.station.model.entity.Station;
import java.util.List;
import java.sql.*;

public interface iStationDAO {

    public List<Station> getAll();          // GET /stations

    public Station getById(int stationId);  // GET /stations/{id}

    public List<Station> getByName(String name); // GET /stations?name=...

    public boolean create(Station station); // POST /stations

    public boolean update(Station station); // PUT /stations/{id}

    public boolean delete(int stationId);   // DELETE /stations/{id}

    public List<Station> getStationsByPageWithRoutes(int page, int pageSize);

    public List<Station> getAllStationsWithRoutes();

    public List<Station> getStationsByPage(int page, int pageSize);

    public int getTotalStations();

    public List<Station> searchExactByName(String name);

    public int countExactByName(String name);
}
