/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.auth.dao;

import module.core.AbstractDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import module.auth.model.entity.User;

/**
 *
 * @author kappyphm
 */
public class UserDAO extends AbstractDAO<User, String> {

    public UserDAO(Connection connection) {
        super(connection);
    }

    @Override
    protected User mapResultSetToEntity(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getString("user_id"));
        user.setRole(rs.getString("role"));
        user.setActive(rs.getBoolean("is_active"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }

    @Override
    protected String getTableName() {
        return "dbo.[user]";
    }

    @Override
    protected String getPrimaryKeyColumn() {
        return "user_id";
    }

    @Override
    protected PreparedStatement prepareInsertStatement(User entity, Connection conn) throws SQLException {
        String sql = "INSERT INTO " + getTableName() + " (user_id, role) "
                + "OUTPUT inserted." + getPrimaryKeyColumn() + " "
                + "VALUES (?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, entity.getUserId());
        stmt.setString(2, entity.getRole());
        return stmt;
    }

    @Override
    protected PreparedStatement prepareUpdateStatement(User entity, Connection conn) throws SQLException {
        String sql = "UPDATE " + getTableName() + " SET role = ?, is_active = ? WHERE " + getPrimaryKeyColumn() + " = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, entity.getRole());
        stmt.setBoolean(2, entity.isActive());
        stmt.setString(3, entity.getUserId());
        return stmt;
    }

    @Override
    protected String extractGeneratedKey(ResultSet rs) throws SQLException {
        if (rs.next()) {
            return rs.getString("user_id"); // hoặc rs.getInt("user_id")
        }
        return null;
    }

}
