package service;

import dal.criteria.UserCriteria;
import java.util.List;
import java.util.Optional;
import model.entity.Profile;
import model.entity.User;

public interface IUserService {

    Optional<User> findById(int userId);

    Optional<User> findByFirebaseUid(String firebaseUid);

    boolean createUser(User user);

    boolean updateUser(User user);
    
    public boolean updateUserProfile(User user);

    boolean deleteUser(int userId);

    boolean activateUser(int userId);

    boolean deactivateUser(int userId);

    List<User> findUsersByRole(String role, UserCriteria criteria);

    Optional<Profile> loadProfile(User user);
}
