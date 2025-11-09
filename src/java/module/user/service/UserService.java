/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.service;

import exception.DataAccessException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import module.core.BaseService;
import module.user.dao.CustomerDAO;
import module.user.dao.ProfileDAO;
import module.user.dao.StaffDAO;
import module.user.dao.UserDAO;
import module.user.model.dto.CustomerDTO;
import module.user.model.dto.StaffDTO;
import module.user.model.dto.UserDetailDTO;
import module.user.model.entity.Customer;
import module.user.model.entity.Profile;
import module.user.model.entity.Staff;
import module.user.model.entity.User;

/**
 *
 * @author kappyphm
 */
public class UserService extends BaseService {

    private final ProfileDAO profileDao = new ProfileDAO(connection);
    private final UserDAO userDao = new UserDAO(connection);
    private final StaffDAO staffDao = new StaffDAO(connection);
    private final CustomerDAO customerDao = new CustomerDAO(connection);

    public Optional<UserDetailDTO> getUserDetail(String userId) {
        try {

            UserDetailDTO userDetail = new UserDetailDTO();

            Optional<User> user = userDao.findById(userId);
            Optional<Profile> profile = profileDao.findById(userId);

            // Nếu thiếu 1 trong 2 thì trả về Optional.empty()
            if (user.isEmpty() || profile.isEmpty()) {
                return Optional.empty();
            }

            userDetail.setUserId(user.get().getUserId());
            userDetail.setActive(user.get().isActive());
            userDetail.setName(profile.get().getName());
            userDetail.setEmail(profile.get().getEmail());
            userDetail.setPhone(profile.get().getPhone());
            userDetail.setAvatarUrl(profile.get().getAvatarUrl());
            userDetail.setAddress(profile.get().getAddress());
            userDetail.setDob(profile.get().getDob());

            Optional<Staff> staff = staffDao.findById(userId);

            if (staff.isPresent()) {
                Staff st = staff.get();
                StaffDTO staffDto = new StaffDTO(st.getStaffCode(), st.getPosition(), st.getDepartment());
                userDetail.setStaff(staffDto);
            }

            Optional<Customer> customer = customerDao.findById(userId);
            if (customer.isPresent()) {
                Customer cs = customer.get();
                CustomerDTO customerDto = new CustomerDTO(cs.getMembershipLevel(), cs.getLoyaltyPoints());
                userDetail.setCustomer(customerDto);
            } else {

                customerDao.insert(new Customer(userId, "STANDARD", 0));
                userDetail.setCustomer(new CustomerDTO("STANDARD", 0));

            }

            return Optional.of(userDetail);
        } catch (SQLException e) {
            throw new DataAccessException("getUserProfile: " + e.getMessage());
        }
    }

    public void saveUserDetail(UserDetailDTO userDetail) {
        try {
            beginTransaction();
            Profile profile = new Profile();
            profile.setAddress(userDetail.getAddress());
            profile.setAvatarUrl(userDetail.getAvatarUrl());
            profile.setDob((Date) userDetail.getDob());
            profile.setEmail(userDetail.getEmail());
            profile.setName(userDetail.getName());
            profile.setPhone(userDetail.getPhone());
            profile.setUserId(userDetail.getUserId());

            profileDao.update(profile);

            commitTransaction();

        } catch (SQLException e) {
            rollbackTransaction();
            throw new DataAccessException("SAVE USER ERROR: " + e.getMessage());
        }

    }

    public User createUserDetail(UserDetailDTO userDetail) {
        try {
            beginTransaction();

            User user = new User();
            user.setUserId(userDetail.getUserId());
            user.setActive(false);

            userDao.insert(user);

            Profile profile = new Profile();
            profile.setAddress(userDetail.getAddress());
            profile.setAvatarUrl(userDetail.getAvatarUrl());
            profile.setDob((Date) userDetail.getDob());
            profile.setEmail(userDetail.getEmail());
            profile.setName(userDetail.getName());
            profile.setPhone(userDetail.getPhone());
            profile.setUserId(userDetail.getUserId());

            profileDao.insert(profile);

            Customer customer = new Customer(userDetail.getUserId(), "STANDARD", 0);
            customerDao.insert(customer);

            commitTransaction();
            return userDao.findById(userDetail.getUserId()).get();

        } catch (SQLException e) {
            rollbackTransaction();
            throw new DataAccessException("CREATE USER ERROR: " + e.getMessage());
        }

    }
    public List<UserDetailDTO> getAllStaffDetails() {
        try {
            List<Staff> allStaff = staffDao.findAll();
            
            List<UserDetailDTO> staffDetailsList = new ArrayList<>();

            for (Staff staff : allStaff) {
                Optional<Profile> profile = profileDao.findById(staff.getUserId());
                
                if (profile.isPresent()) {
                    UserDetailDTO dto = new UserDetailDTO();
                    dto.setUserId(staff.getUserId());
                    dto.setName(profile.get().getName());
                    
                    StaffDTO staffDto = new StaffDTO(staff.getStaffCode(), staff.getPosition(), staff.getDepartment());
                    dto.setStaff(staffDto);
                    
                    staffDetailsList.add(dto);
                }
            }
            
            return staffDetailsList;
            
        } catch (SQLException e) {
            throw new DataAccessException("getAllStaffDetails (An toàn): " + e.getMessage());
        }
    }
    

}
