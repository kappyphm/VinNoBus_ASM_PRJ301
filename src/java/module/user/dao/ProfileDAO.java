/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.dao;

import java.sql.Connection;
import module.core.AbstractDAO;
import module.user.model.entity.Profile;

/**
 *
 * @author kappyphm
 */
public class ProfileDAO extends AbstractDAO<Profile, String> {

    public ProfileDAO(Connection connection) {
        super(connection, Profile.class);
    }

}
