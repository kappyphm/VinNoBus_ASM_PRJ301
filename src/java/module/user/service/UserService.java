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
import java.util.logging.Level;
import java.util.logging.Logger;
import module.core.AutoCriteria;
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

    public List<UserDetailDTO> getUsers(String search) {

        List<UserDetailDTO> result = new ArrayList<>();

        // 1. Khởi tạo AutoCriteria
        AutoCriteria<Profile> criteria = new AutoCriteria<>(Profile.class);

        // 2. Thiết lập tìm kiếm
        if (search != null && !search.isEmpty()) {
            criteria.like("name", search)
                    .orlike("email", search)
                    .orlike("phone", search);
        }

        try {
            // 4. Lấy danh sách Profile theo tiêu chí
            List<Profile> profiles = profileDao.findByCriteria(criteria);

            for (Profile profile : profiles) {

                UserDetailDTO detail = getUserDetail(profile.getUserId()).get();
                // Thêm vào danh sách kết quả
                result.add(detail);
            }

        } catch (SQLException ex) {
            throw new DataAccessException("CANNOT FIND PROFILE: " + ex.getMessage());
        }

        return result;
    }

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
            } else {
                userDetail.setStaff(null);
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
            throw new DataAccessException("getUserProfile: " + e.getLocalizedMessage());
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

    public void deleteUser(String userId) {
        try {
            userDao.delete(userId);
        } catch (SQLException e) {
            throw new DataAccessException("CREATE USER ERROR: " + e.getMessage());
        }
    }

    public void saveProfile(UserDetailDTO userDetail) {
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

            userDao.updateUserActive(userDetail.getUserId(), userDetail.isActive());

            commitTransaction();

        } catch (SQLException e) {
            rollbackTransaction();
            throw new DataAccessException("SAVE USER ERROR: " + e.getMessage());
        }

    }

    public void saveCustomer(String userId, CustomerDTO customer) {
        try {
            beginTransaction();

            Customer cus = new Customer(userId, customer.getMembershipLevel(), customer.getLoyaltyPoints());
            customerDao.update(cus);

            commitTransaction();

        } catch (SQLException e) {
            rollbackTransaction();
            throw new DataAccessException("SAVE CUSTOMER ERROR: " + e.getMessage());
        }
    }

    public void saveStaff(String userId, StaffDTO staff) {
        try {
            beginTransaction();

            Staff st = new Staff(
                    userId,
                    staff.getStaffCode(),
                    staff.getPosition(),
                    staff.getDepartment()
            );

            if (!staffDao.isExist(userId)) {
                staffDao.insert(st);
            } else {
                staffDao.update(st);
            }

            commitTransaction();

        } catch (SQLException e) {
            rollbackTransaction();
            throw new DataAccessException("SAVE STAFF ERROR: " + e.getMessage());
        }
    }

    public List<UserDetailDTO> getStaffs() {
        try {
            List<Staff> staffs = staffDao.findAll();

            return staffs.stream().map(st -> {
                Optional<UserDetailDTO> detail = getUserDetail(st.getUserId());
                return detail.get();
            }).toList();

        } catch (SQLException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new ArrayList<>();
    }

    public void deleteStaff(String userId) {
        try {
            staffDao.delete(userId);
        } catch (SQLException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public List<UserDetailDTO> getOperator() {
        List<UserDetailDTO> res = new ArrayList();
        try {
            List<Staff> staffs = staffDao.findAllBy("department", "OPERATOR");
            for (Staff st : staffs) {
                String userId = st.getUserId();
                Optional<UserDetailDTO> userOtp = getUserDetail(userId);
                if (userOtp.isPresent()) {
                    UserDetailDTO u = userOtp.get();
                    res.add(u);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (res.isEmpty()) {
            throw new RuntimeException("đm đéo có tài xế");
        }
        return res;
    }

}
