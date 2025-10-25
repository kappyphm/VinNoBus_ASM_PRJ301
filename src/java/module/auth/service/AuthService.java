package module.auth.service;

import module.core.BaseService;
import module.user.dao.ProfileDAO;
import module.auth.dao.UserDAO;
import exception.AuthException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import module.auth.model.entity.GoogleUserProfile;
import module.user.model.entity.Profile;
import module.auth.model.entity.User;
import module.user.model.input.UserProfileInput;

public class AuthService extends BaseService {

    private final UserDAO userDAO = new UserDAO(getConnection());
    private final ProfileDAO profileDAO = new ProfileDAO(getConnection());

    private static final Logger LOGGER = Logger.getLogger(AuthService.class.getName());

    public Optional<User> handleGoogleLogin(GoogleUserProfile profile) throws AuthException {

        try {

            Optional<User> existingUserOpt = userDAO.findById(profile.getUserId());

            if (existingUserOpt.isPresent()) {
                LOGGER.log(Level.INFO, "Existing user found for sub: {0}", profile.getUserId());
                return existingUserOpt;
            } else {
                LOGGER.log(Level.INFO, "No existing user found. Creating new user for sub: {0}", profile.getUserId());
                return Optional.empty();
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AuthService: " + e.getMessage(), e);
            throw new AuthException("Internal authentication error occurred.", e);
        }
    }

    public void register(UserProfileInput profileInput) throws AuthException {
        try {
            beginTransaction();

            User newUser = new User();
            newUser.setUserId(profileInput.getUserId());
            newUser.setRole("CUSTOMER");

            userDAO.insert(newUser);

            Profile newProfile = new Profile();
            newProfile.setUserId(profileInput.getUserId());
            newProfile.setFullName(profileInput.getFullName());
            newProfile.setEmail(profileInput.getEmail());
            newProfile.setPhone(profileInput.getPhone());
            newProfile.setAddress(profileInput.getAddress());
            newProfile.setAvatarUrl(profileInput.getAvatarUrl());
            newProfile.setDateOfBirth(Date.valueOf(profileInput.getDateOfBirth()));
            profileDAO.insert(newProfile);

            commitTransaction();
        } catch (SQLException e) {
            rollbackTransaction();
            LOGGER.log(Level.SEVERE, "Error during registration: " + e.getMessage(), e);
            throw new AuthException("Registration failed due to a database error: " + e.getMessage(), e);
        } catch (Exception e) {
            rollbackTransaction();
            LOGGER.log(Level.SEVERE, "Unexpected error during registration: " + e.getMessage(), e);
            throw new AuthException("Unexpected error during registration: " + e.getMessage(), e);
        }

    }

}
