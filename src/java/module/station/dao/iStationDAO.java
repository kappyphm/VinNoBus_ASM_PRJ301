package module.station.dao;

import module.station.model.entity.Station;
import java.util.List;
import java.sql.*;

public interface iStationDAO {

    public List<Station> getAll() throws SQLException;          // GET /stations

    public Station getById(int stationId) throws SQLException;  // GET /stations/{id}

    public List<Station> getByName(String name) throws SQLException; // GET /stations?name=...

    public boolean create(Station station) throws SQLException; // POST /stations

    public boolean update(Station station) throws SQLException; // PUT /stations/{id}

    public boolean delete(int stationId) throws SQLException;   // DELETE /stations/{id}
}
