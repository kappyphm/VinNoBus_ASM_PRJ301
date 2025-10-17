package dal.dao;

import dal.criteria.ProfileCriteria;
import dal.sql.ProfileSQL;
import model.entity.Profile;

import java.sql.*;
import java.util.*;

/**
 * DAO quản lý Profile. Sử dụng AbstractDAO, logging & DataAccessException
 * chuẩn.
 */
public class ProfileDAO extends AbstractDAO<Profile> {

    @Override
    protected Optional<Profile> parse(ResultSet rs) throws SQLException {
        Profile p = new Profile();
        p.setProfileId(rs.getInt("profile_id"));
        p.setUserId(rs.getInt("user_id"));
        p.setFullName(rs.getString("full_name"));
        p.setDateOfBirth(rs.getTimestamp("birth_date"));
        p.setPhone(rs.getString("phone"));
        p.setEmail(rs.getString("email"));
        p.setAddress(rs.getString("address"));
        p.setAvatarUrl(rs.getString("avatar_url"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return Optional.of(p);
    }

    // -------------------------
    // CRUD cơ bản
    // -------------------------
    public Optional<Profile> findById(int id) {
        return findOne(ProfileSQL.FIND_BY_ID, id);
    }

    public Optional<Profile> findByUserId(int userId) {
        return findOne(ProfileSQL.FIND_BY_USER_ID, userId);
    }

    public boolean insert(Profile p) {
        return execute(ProfileSQL.INSERT, p.getUserId(), p.getFullName(), p.getDateOfBirth(),
                p.getPhone(), p.getEmail(), p.getAddress(), p.getAvatarUrl());
    }

    public boolean update(Profile p) {
        return execute(ProfileSQL.UPDATE, p.getFullName(), p.getDateOfBirth(), p.getPhone(),
                p.getEmail(), p.getAddress(), p.getAvatarUrl(), p.getProfileId());
    }

    public boolean delete(int profileId) {
        return execute(ProfileSQL.DELETE, profileId);
    }

    // -------------------------
    // Query có filter + sort + paging
    // -------------------------
    public List<Profile> findAll(ProfileCriteria criteria) {
        return findAllByCriteria(ProfileSQL.BASE_SELECT, criteria);
    }
}
