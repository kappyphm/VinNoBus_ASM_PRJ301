package service;

import dal.dao.ProfileDAO;
import dal.dao.UserDAO;
import exception.AuthException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.entity.GoogleUserProfile;
import model.entity.Profile;
import model.entity.User;
import model.input.UserProfileInput;

public class AuthService extends BaseService {

    private final UserDAO userDAO = new UserDAO(getConnection());
    private final ProfileDAO profileDAO = new ProfileDAO(getConnection());

    private static final Logger LOGGER = Logger.getLogger(AuthService.class.getName());

    public Optional<User> handleGoogleLogin(GoogleUserProfile profile) throws AuthException {

        try {

            Optional<User> existingUserOpt = userDAO.findBySub(profile.getSub());

            if (existingUserOpt.isPresent()) {
                LOGGER.log(Level.INFO, "Existing user found for sub: {0}", profile.getSub());
                return existingUserOpt;
            } else {
                LOGGER.log(Level.INFO, "No existing user found. Creating new user for sub: {0}", profile.getSub());
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
            newUser.setSub(profileInput.getSub());
            newUser.setRole("CUSTOMER");

            Optional<Integer> newUserIdOpt = userDAO.insert(newUser);
            if (!newUserIdOpt.isPresent()) {
                throw new AuthException("Failed to create new user.");
            }

            Profile newProfile = new Profile();
            newProfile.setUserId(newUserIdOpt.get());
            newProfile.setFullName(profileInput.getFullName());
            newProfile.setEmail(profileInput.getEmail());
            newProfile.setPhone(profileInput.getPhone());
            newProfile.setAddress(profileInput.getAddress());
            newProfile.setAvatarUrl(profileInput.getAvatarUrl());
            newProfile.setDateOfBirth(Date.valueOf(profileInput.getDateOfBirth()));
            Optional<Integer> newProfileIdOpt = profileDAO.insert(newProfile);
            if (!newProfileIdOpt.isPresent()) {
                throw new AuthException("Failed to create user profile.");
            }

            commitTransaction();
        } catch (SQLException e) {
            rollbackTransaction();
            LOGGER.log(Level.SEVERE, "Error during registration: " + e.getMessage(), e);
            throw new AuthException("Registration failed due to a database error: " + e.getMessage(), e);
        } catch (AuthException e) {
            rollbackTransaction();
            LOGGER.log(Level.SEVERE, "AuthException during registration: " + e.getMessage(), e);
            throw e;
        } catch (Exception e) {
            rollbackTransaction();
            LOGGER.log(Level.SEVERE, "Unexpected error during registration: " + e.getMessage(), e);
            throw new AuthException("Unexpected error during registration: " + e.getMessage(), e);
        }

    }

}
