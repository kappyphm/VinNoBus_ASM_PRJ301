/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;
import model.entity.User;

/**
 *
 * @author kappyphm
 */
public class UserDAO extends AbstractDAO<User, Integer> {

    public UserDAO(Connection connection) {
        super(connection);
    }

    public Optional<User> findBySub(String sub) {
        return findByColumn("sub", sub);
    }

    @Override
    protected User mapResultSetToEntity(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setSub(rs.getString("sub"));
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
        String sql = "INSERT INTO " + getTableName() + " (sub, role) "
                + "OUTPUT inserted." + getPrimaryKeyColumn() + " "
                + "VALUES (?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, entity.getSub());
        stmt.setString(2, entity.getRole());
        return stmt;
    }

    @Override
    protected PreparedStatement prepareUpdateStatement(User entity, Connection conn) throws SQLException {
        String sql = "UPDATE " + getTableName() + " SET sub = ?, role = ?, is_active = ? WHERE " + getPrimaryKeyColumn() + " = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, entity.getSub());
        stmt.setString(2, entity.getRole());
        stmt.setBoolean(3, entity.isActive());
        stmt.setInt(4, entity.getUserId());
        return stmt;
    }

    @Override
protected Integer extractGeneratedKey(ResultSet rs) throws SQLException {
    if (rs.next()) {
        return rs.getInt("user_id"); // hoặc rs.getInt("user_id")
    }
    return null;
}


}
