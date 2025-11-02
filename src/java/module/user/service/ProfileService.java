/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.service;

import java.util.Date;
import java.util.Optional;
import module.core.BaseService;
import module.user.dao.CustomerDAO;
import module.user.dao.ProfileDAO;
import module.user.model.dto.CustomerDTO;
import module.user.model.dto.ProfileDTO;
import module.user.model.dto.StaffDTO;
import module.user.model.entity.Customer;
import module.user.model.entity.Profile;

/**
 *
 * @author kappyphm
 */
public class ProfileService extends BaseService {

    private final ProfileDAO profileDAO = new ProfileDAO(getConnection());
    private final CustomerDAO customerDAO = new CustomerDAO(getConnection());
    private final StaffDAO staffDAO = new StaffDAO(getConnection());

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

    public CustomerDTO getCustomerProfile(String userId) {
        var customerOpt = customerDAO.findById(userId);
        if (customerOpt.isPresent()) {
            Customer customer = customerOpt.get();
            CustomerDTO dto = new CustomerDTO(
                    customer.getLoyaltyPoints(),
                    customer.getMembershipLevel());
            return dto;
        }
        return null;
    }

    public StaffDTO getStaffProfile(String userId) {
        var staffOpt = staffDAO.findById(userId);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            StaffDTO dto = 
            return dto;
        }
        return null;
    }
}
