/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UserModule.dao.impl;

import static UserModule.constant.Query.ADD_ROLE;
import static UserModule.constant.Query.DELETE_ROLE;
import static UserModule.constant.Query.DELETE_USER_ROLE;
import static UserModule.constant.Query.FIND_ALL_ROLE;
import static UserModule.constant.Query.FIND_ROLES_BY_USER_ID;
import static UserModule.constant.Query.FIND_ROLE_BY_ID;
import static UserModule.constant.Query.FIND_ROLE_BY_NAME;
import static UserModule.constant.Query.UPDATE_ROLE;
import dal.DBContext;
import UserModule.dao.IRoleDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import UserModule.model.entity.Role;

/**
 *
 * @author kappyphm
 */
public class RoleDAO extends DBContext implements IRoleDAO {

    

    public Connection getConnection() {
        return connection;
    }

    @Override
    public void save(Role role) throws SQLException {
        try (var st = connection.prepareStatement(ADD_ROLE)) {
            st.setString(1, role.getRoleName());
            st.executeUpdate();

        }

    }

    @Override
    public void update(Role role) throws SQLException {
        try (var st = connection.prepareStatement(UPDATE_ROLE)) {
            st.setString(1, role.getRoleName());
            st.setInt(2, role.getId());
            st.executeUpdate();

        }
    }

    @Override
    public void delete(int id) throws SQLException {
        try (var st = connection.prepareStatement(DELETE_ROLE)) {
            st.setInt(1, id);
            st.executeUpdate();

        }
    }

    @Override
    public Optional<Role> findById(int id) throws SQLException {

        try (var st = connection.prepareStatement(FIND_ROLE_BY_ID)) {
            st.setInt(1, id);
            try (var rs = st.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(parse(rs));
                }
            }
        }
        return Optional.empty();

    }

    @Override
    public Optional<Role> findByName(String roleName) throws SQLException {
        try (var st = connection.prepareStatement(FIND_ROLE_BY_NAME)) {
            st.setString(1, roleName);
            try (var rs = st.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(parse(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Role> findAll() throws SQLException {
        try (var st = connection.prepareStatement(FIND_ALL_ROLE)) {
            List<Role> roles = new ArrayList();
            try (var rs = st.executeQuery()) {
                while (rs.next()) {
                    roles.add(parse(rs));
                }
                return roles;
            }
        }
    }

    @Override
    public void updateUserRoles(UUID userId, List<Role> roles) throws SQLException {
        PreparedStatement deleteStm = null;
        PreparedStatement insertStm = null;

        connection.setAutoCommit(false);
        try {
            deleteStm = connection.prepareStatement(DELETE_USER_ROLE);
            deleteStm.setObject(1, userId);
            deleteStm.executeUpdate();

            if (roles != null && !roles.isEmpty()) {
                for (Role role : roles) {
                    insertStm.setObject(1, userId);
                    insertStm.setInt(2, role.getId());
                    insertStm.addBatch();
                }
                insertStm.executeBatch();

            }
            connection.commit();
        } catch (SQLException e) {
            if (connection != null) {
                connection.rollback();
            }
            throw e;
        } finally {
            if (deleteStm != null) {
                deleteStm.close();
            }
            if (insertStm != null) {
                insertStm.close();
            }
            connection.setAutoCommit(true);
        }

    }

    @Override
    public List<Role> findRolesByUserId(UUID userId) throws SQLException {
        try (var st = connection.prepareStatement(FIND_ROLES_BY_USER_ID)) {
            st.setObject(1, userId);
            try (var rs = st.executeQuery()) {
                List<Role> roles = new ArrayList();
                while (rs.next()) {
                    roles.add(parse(rs));
                }
                return roles;
            }

        }
    }

    private Role parse(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setId(rs.getInt("role_id"));
        role.setRoleName(rs.getString("role_name"));
        return role;
    }

}
