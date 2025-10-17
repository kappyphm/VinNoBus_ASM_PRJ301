package dal.dao;

import dal.criteria.StaffCriteria;
import dal.sql.StaffSQL;
import model.entity.Staff;

import java.sql.*;
import java.util.*;

/**
 * DAO quản lý Staff. Sử dụng AbstractDAO, logging & DataAccessException chuẩn.
 */
public class StaffDAO extends AbstractDAO<Staff> {

    @Override
    protected Optional<Staff> parse(ResultSet rs) throws SQLException {
        Staff s = new Staff();
        s.setStaffId(rs.getInt("staff_id"));
        s.setUserId(rs.getInt("user_id"));
        s.setStaffCode(rs.getString("staff_code"));
        s.setPosition(rs.getString("position"));
        s.setDepartment(rs.getString("department"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        s.setUpdatedAt(rs.getTimestamp("updated_at"));
        return Optional.of(s);
    }

    // -------------------------
    // CRUD cơ bản
    // -------------------------
    public Optional<Staff> findById(int id) {
        return findOne(StaffSQL.FIND_BY_ID, id);
    }

    public Optional<Staff> findByUserId(int userId) {
        return findOne(StaffSQL.FIND_BY_USER_ID, userId);
    }

    public boolean insert(Staff s) {
        return execute(StaffSQL.INSERT, s.getUserId(), s.getStaffCode(), s.getPosition(), s.getDepartment());
    }

    public boolean update(Staff s) {
        return execute(StaffSQL.UPDATE, s.getStaffCode(), s.getPosition(), s.getDepartment(), s.getStaffId());
    }

    public boolean delete(int staffId) {
        return execute(StaffSQL.DELETE, staffId);
    }

    // -------------------------
    // Query có filter + sort + paging
    // -------------------------
    public List<Staff> findAll(StaffCriteria criteria) {
        return findAllByCriteria(StaffSQL.BASE_SELECT, criteria);
    }
}
