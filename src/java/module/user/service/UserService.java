/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.service;

import exception.DataAccessException;
import java.sql.SQLException;
import java.util.NoSuchElementException;
import java.util.Optional;
import module.core.BaseService;
import module.user.dao.ProfileDAO;
import module.user.dao.UserDAO;
import module.user.model.dto.UserDetailDTO;
import module.user.model.entity.Profile;
import module.user.model.entity.User;

/**
 *
 * @author kappyphm
 */
public class UserService extends BaseService {
    
    private final ProfileDAO profileDao = new ProfileDAO(connection, Profile.class);
    private final UserDAO userDao = new UserDAO(connection, User.class);
    
    public Optional<UserDetailDTO> getUserDetail(String userId) {
        try {
            
            UserDetailDTO userDetail = new UserDetailDTO();
            
            Optional<User> user = userDao.findById(userId);
            Optional<Profile> profile = profileDao.findById(userId);
            
            if (user.isEmpty()) {
                throw new NoSuchElementException(this.getClass().getName() + ": Cannot find User");
            }
            if (profile.isEmpty()) {
                throw new NoSuchElementException(this.getClass().getName() + ": Cannot find Profile");
            }
            
            userDetail.setUserId(user.get().getUserId());
            userDetail.setActive(user.get().isActive());
            userDetail.setName(profile.get().getName());
            userDetail.setEmail(profile.get().getEmail());
            userDetail.setPhone(profile.get().getPhone());
            userDetail.setAvatarUrl(profile.get().getAvatarUrl());
            userDetail.setAddress(profile.get().getAddress());
            
            return Optional.of(userDetail);
        } catch (SQLException e) {
            throw new DataAccessException("getUserProfile: " + e.getMessage());
        }
    }
    
    public void saveUserDetail(UserDetailDTO userDetail) {
        try {
            Profile profile = new Profile();
            profile.setAddress(userDetail.getAddress());
            profile.setAvatarUrl(userDetail.getAvatarUrl());
            profile.setDob(userDetail.getDob());
            profile.setEmail(userDetail.getEmail());
            profile.setName(userDetail.getName());
            profile.setPhone(userDetail.getPhone());
            profile.setUserId(userDetail.getUserId());
            
            boolean isExist = profileDao.isExist(userDetail.getUserId());
            if (isExist) {
                profileDao.update(profile);
            } else {
                profileDao.insert(profile);
            }
            
        } catch (SQLException e) {
            throw new DataAccessException("SAVE USER ERROR: " + e.getMessage());
        }
    }
    
}
