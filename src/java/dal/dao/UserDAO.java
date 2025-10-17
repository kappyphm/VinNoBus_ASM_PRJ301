package dal.dao;

import dal.criteria.UserCriteria;
import dal.exception.DataAccessException;
import dal.sql.UserSQL;
import java.sql.*;
import java.util.*;
import model.entity.Profile;
import model.entity.User;

/**
 * DAO quản lý User. Sử dụng AbstractDAO, logging & DataAccessException chuẩn.
 * Hỗ trợ lazy-loading Profile khi cần.
 */
public class UserDAO extends AbstractDAO<User> {

    private final ProfileDAO profileDAO = new ProfileDAO(); // để load profile khi cần

    @Override
    protected Optional<User> parse(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFirebaseUid(rs.getString("firebase_uid"));
        u.setRole(rs.getString("role"));
        u.setActive(rs.getBoolean("is_active"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        u.setUpdatedAt(rs.getTimestamp("updated_at"));
        // profile giữ Optional.empty() theo weak association
        u.setProfile(Optional.empty());
        return Optional.of(u);
    }

    // -------------------------
    // CRUD cơ bản
    // -------------------------
    public Optional<User> findById(int id) {
        return findOne(UserSQL.FIND_BY_ID, id);
    }

    public Optional<User> findByFirebaseUid(String firebaseUid) {
        return findOne(UserSQL.FIND_BY_FIREBASE_UID, firebaseUid);
    }

    public boolean insert(User u) {
        return execute(UserSQL.INSERT, u.getFirebaseUid(), u.getRole(), u.isActive());
    }

    public boolean update(User u) {
        return execute(UserSQL.UPDATE, u.getRole(), u.isActive(), u.getUserId());
    }

    public boolean delete(int userId) {
        return execute(UserSQL.DELETE, userId);
    }

    // -------------------------
    // Query có filter + sort + paging
    // -------------------------
    public List<User> findAll(UserCriteria criteria) {
        return findAllByCriteria(UserSQL.BASE_SELECT, criteria);
    }

    // -------------------------
    // Lazy load profile
    // -------------------------
    public Optional<Profile> loadProfile(User u) {
        if (u.getProfile().isPresent()) {
            return u.getProfile();
        }
        try {
            Optional<Profile> profile = profileDAO.findByUserId(u.getUserId());
            u.setProfile(profile);
            return profile;
        } catch (DataAccessException e) {
            logger.warning("Failed to load profile for userId=" + u.getUserId());
            return Optional.empty();
        }
    }
}
