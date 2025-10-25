/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.entity.Profile;

/**
 *
 * @author kappyphm
 */
public class ProfileDAO extends AbstractDAO<Profile, String> {

    public ProfileDAO(Connection connection) {
        super(connection);
    }

    @Override
    protected Profile mapResultSetToEntity(ResultSet rs) throws SQLException {
        Profile profile = new Profile();
        profile.setUserId(rs.getString("user_id"));
        profile.setFullName(rs.getString("full_name"));
        profile.setEmail(rs.getString("email"));
        profile.setPhone(rs.getString("phone"));
        profile.setAddress(rs.getString("address"));
        profile.setDateOfBirth(rs.getDate("birth_date"));
        profile.setAvatarUrl(rs.getString("avatar_url"));
        profile.setCreatedAt(rs.getTimestamp("created_at"));
        profile.setUpdatedAt(rs.getTimestamp("updated_at"));
        return profile;
    }

    @Override
    protected String extractGeneratedKey(ResultSet rs) throws SQLException {
        if (rs.next()) {
            return rs.getString(getPrimaryKeyColumn());
        }
        return null;
    }

    @Override
    protected String getTableName() {
        return "profile";
    }

    @Override
    protected String getPrimaryKeyColumn() {
        return "user_id";
    }

    @Override
    protected PreparedStatement prepareInsertStatement(Profile entity, Connection conn) throws SQLException {

        //String sql = "INSERT INTO " + getTableName() + " (user_id, full_name, email, phone, address, birth_date, avatar_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sql = "INSERT INTO " + getTableName() + " (user_id, full_name, email, phone, address, birth_date, avatar_url) "
                + "OUTPUT inserted." + getPrimaryKeyColumn() + " "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        stmt.setString(1, entity.getUserId());
        stmt.setString(2, entity.getFullName());
        stmt.setString(3, entity.getEmail());
        stmt.setString(4, entity.getPhone());
        stmt.setString(5, entity.getAddress());
        stmt.setDate(6, entity.getDateOfBirth());
        stmt.setString(7, entity.getAvatarUrl());
        return stmt;
    }

    @Override
    protected PreparedStatement prepareUpdateStatement(Profile entity, Connection conn) throws SQLException {
        // String sql = "UPDATE " + getTableName() + " SET user_id = ?, full_name = ?, email = ?, phone = ?, address = ?, birth_date = ?, avatar_url = ? WHERE " + getPrimaryKeyColumn() + " = ?";
        String sql = "UPDATE " + getTableName() + " SET full_name = ?, email = ?, phone = ?, address = ?, birth_date = ?, avatar_url = ? WHERE " + getPrimaryKeyColumn() + " = ?" + " OUTPUT INSERTED." + getPrimaryKeyColumn();
        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, entity.getFullName());
        stmt.setString(2, entity.getEmail());
        stmt.setString(3, entity.getPhone());
        stmt.setString(4, entity.getAddress());
        stmt.setDate(5, (Date) entity.getDateOfBirth());
        stmt.setString(6, entity.getAvatarUrl());
        stmt.setString(7, entity.getUserId());
        return stmt;
    }

}
