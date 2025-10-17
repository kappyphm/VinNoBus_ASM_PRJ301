package service.impl;

import dal.criteria.UserCriteria;
import dal.dao.ProfileDAO;
import dal.dao.UserDAO;
import java.util.List;
import java.util.Optional;
import model.entity.Profile;
import model.entity.User;
import service.IUserService;

public class UserServiceImpl implements IUserService {

    private final UserDAO userDAO = new UserDAO();
    private final ProfileDAO profileDAO = new ProfileDAO();

    @Override
    public Optional<User> findById(int userId) {
        return userDAO.findById(userId);
    }

    @Override
    public Optional<User> findByFirebaseUid(String firebaseUid) {
        return userDAO.findByFirebaseUid(firebaseUid);
    }

    @Override
    public boolean createUser(User user) {
        boolean isCreated = userDAO.insert(user);
        if(isCreated && user.getProfile().isPresent()) {
            Profile profile = user.getProfile().get();
            profile.setUserId(user.getUserId());
            // Assuming ProfileDAO and its insert method exist
            return profileDAO.insert(profile);
        }
        else {
            return isCreated;

        }
    }

    @Override
    public boolean updateUser(User user) {
        return userDAO.update(user);
    }

    @Override
    public boolean updateUserProfile(User user) {
        if (user.getProfile().isPresent()) {
            Profile profile = user.getProfile().get();
            return profileDAO.update(profile);
        }
        return false;
    }

    @Override
    public boolean deleteUser(int userId) {
        return userDAO.delete(userId);
    }

    @Override
    public boolean activateUser(int userId) {
        Optional<User> uOpt = userDAO.findById(userId);
        if (uOpt.isPresent() && !uOpt.get().isActive()) {
            User u = uOpt.get();
            u.setActive(true);
            return userDAO.update(u);
        }
        return false;
    }

    @Override
    public boolean deactivateUser(int userId) {
        Optional<User> uOpt = userDAO.findById(userId);
        if (uOpt.isPresent() && uOpt.get().isActive()) {
            User u = uOpt.get();
            u.setActive(false);
            return userDAO.update(u);
        }
        return false;
    }

    @Override
    public List<User> findUsersByRole(String role, UserCriteria criteria) {
        criteria.setRole(role);
        return userDAO.findAll(criteria);
    }

    @Override
    public Optional<Profile> loadProfile(User user) {
        return userDAO.loadProfile(user);
    }
}
