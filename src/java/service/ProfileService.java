/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.dao.ProfileDAO;
import java.util.Date;
import java.util.Optional;
import model.dto.ProfileDTO;
import model.entity.Profile;

/**
 *
 * @author kappyphm
 */
public class ProfileService extends BaseService {

    private final ProfileDAO profileDAO = new ProfileDAO(getConnection());



    public ProfileDTO getUserProfile(String userId) {
        Optional<Profile> profileOpt = profileDAO.findById(userId);
        if (profileOpt.isPresent()) {
            Profile profile = profileOpt.get();
            ProfileDTO profileDTO = new ProfileDTO();
            profileDTO.setUserId(profile.getUserId());
            profileDTO.setFullName(profile.getFullName());
            profileDTO.setEmail(profile.getEmail());
            profileDTO.setPhone(profile.getPhone());
            profileDTO.setAddress(profile.getAddress());
            profileDTO.setDateOfBirth(new Date(profile.getDateOfBirth().getTime()));
            profileDTO.setAvatarUrl(profile.getAvatarUrl());
            return profileDTO;
        } else {
            return null;
        }
    }
}
