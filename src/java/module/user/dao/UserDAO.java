/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.dao;

import java.sql.*;
import module.core.AbstractDAO;
import module.user.model.entity.User;

/**
 *
 * @author kappyphm
 */
public class UserDAO extends AbstractDAO<User, String> {

    public UserDAO(Connection connection) {
        super(connection, User.class);
    }

    public void updateUserActive(String userId, boolean active) throws SQLException {
        String sql = "UPDATE [user] SET is_active = ? WHERE user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, active);
            st.setString(2, userId);
            st.executeUpdate();
        }
    }

}
