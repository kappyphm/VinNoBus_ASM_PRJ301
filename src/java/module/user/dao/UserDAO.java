/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.dao;

import java.sql.Connection;
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

}
