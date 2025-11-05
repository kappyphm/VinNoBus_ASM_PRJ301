/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.auth.service;

import exception.AuthException;
import java.sql.SQLException;
import java.util.Optional;
import module.auth.model.dto.GoogleUserDTO;
import module.core.BaseService;
import module.user.dao.ProfileDAO;
import module.user.dao.UserDAO;
import module.user.model.entity.Profile;
import module.user.model.entity.User;

/**
 *
 * @author kappyphm
 */
public class AuthService extends BaseService {

    private final UserDAO userDao = new UserDAO(connection, User.class);
    private final ProfileDAO profileDao = new ProfileDAO(connection, Profile.class);

    public Optional<User> handleLogin(GoogleUserDTO googleUser) throws AuthException {
        try {

            return userDao.findById(googleUser.getSub());

        } catch (SQLException e) {
            throw new AuthException("SQL  ERROR: " + e.getMessage());
        }

    }


}
