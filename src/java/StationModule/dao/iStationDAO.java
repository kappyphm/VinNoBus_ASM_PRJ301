package StationModule.dao;

import StationModule.model.Station;
import java.util.List;

public interface iStationDAO {

    public List<Station> getAll();          // GET /stations

    public Station getById(int stationId);  // GET /stations/{id}

    public List<Station> getByName(String name); // GET /stations?name=...

    public boolean create(Station station); // POST /stations

    public boolean update(Station station); // PUT /stations/{id}

    public boolean delete(int stationId);   // DELETE /stations/{id}
}
