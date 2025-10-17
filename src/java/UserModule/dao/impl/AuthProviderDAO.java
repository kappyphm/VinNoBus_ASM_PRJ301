/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UserModule.dao.impl;

import static UserModule.constant.Query.*;
import UserModule.dao.IAuthProviderDAO;
import UserModule.model.entity.AuthProvider;
import dal.DBContext;
import java.sql.*;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


/**
 *
 * @author kappyphm
 */
public class AuthProviderDAO extends DBContext implements IAuthProviderDAO {

    @Override
    public void save(AuthProvider authProvider) throws SQLException {
        String sql = SAVE_AUTH_PROVIDER;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setObject(1, authProvider.getUser());
            stmt.setString(2,  authProvider.getProvider());
            stmt.setString(3, authProvider.getProviderUid());
            stmt.setString(4, authProvider.getPasswordHash());
            stmt.executeUpdate();
        }
        
    }

    @Override
    public void update(AuthProvider authProvider) throws SQLException {
        String  sql = UPDATE_AUTH_PROVIDER;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setObject(1, authProvider.getUser());
            stmt.setString(2,  authProvider.getProvider());
            stmt.setString(3, authProvider.getProviderUid());
            stmt.setString(4, authProvider.getPasswordHash());
            stmt.setInt(5, authProvider.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        String sql = DELETE_AUTH_PROVIDER;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    @Override
    public void deleteByUserId(UUID userId) throws SQLException {
        String sql = DELETE_AUTH_PROVIDERS_BY_USERID;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setObject(1, userId);
            stmt.executeUpdate();
        }
    }



    @Override
    public List<AuthProvider> findByUserId(UUID userId) throws SQLException {
        String sql = FIND_AUTH_PROVIDERS_BY_USERID;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setObject(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                List<AuthProvider> authProviders = new ArrayList<>();
                while (rs.next()) {
                    AuthProvider authProvider = parse(rs);
                    authProviders.add(authProvider);
                }
                return authProviders;
            }
        }
    }

    @Override
    public Optional<AuthProvider> findById(int id) throws SQLException {
        String sql = FIND_AUTH_PROVIDER_BY_ID;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    AuthProvider authProvider = parse(rs);
                    return Optional.of(authProvider);
                }
            }
        }
    }

    @Override
    public Optional<AuthProvider> findByProviderUid(String provider, String providerUid) throws SQLException {
        String sql = FIND_AUTH_PROVIDER_BY_PROVIDER_UID;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, provider);
            stmt.setString(2, providerUid);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    AuthProvider authProvider = parse(rs);
                    return Optional.of(authProvider);
                }
            }
        }
        return Optional.empty();
    }

    private AuthProvider parse(ResultSet rs) throws SQLException {
        AuthProvider authProvider = new AuthProvider();
        authProvider.setId(rs.getInt("id"));
        authProvider.setUser(rs.getObject("user_id", UUID.class));
        authProvider.setProvider(rs.getString("provider"));
        authProvider.setProviderUid(rs.getString("provider_uid"));
        authProvider.setPasswordHash(rs.getString("password_hash"));
        return authProvider;
    }

}
