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
    
    public List<UserDetailDTO> getUsers(String search, String sort, int currentPage) {

        List<UserDetailDTO> result = new ArrayList<>();

        // 1. Khởi tạo AutoCriteria
        AutoCriteria<Profile> criteria = new AutoCriteria<>(Profile.class);

        // 2. Thiết lập tìm kiếm
        if (search != null && !search.isEmpty()) {
            criteria.like("name", search)
                    .like("email", search);
        }

        // 3. Thiết lập phân trang & sắp xếp
        criteria.setPage(currentPage);
        criteria.setPageSize(15);

        if (sort != null && !sort.isEmpty()) {
            criteria.setSortBy(sort);
            criteria.setSortDirection("ASC");
        }

        try {
            // 4. Lấy danh sách Profile theo tiêu chí
            List<Profile> profiles = profileDao.findByCriteria(criteria);

            for (Profile profile : profiles) {
                UserDetailDTO detail = new UserDetailDTO();

                // ------------ Set thông tin PROFILE ------------
                detail.setUserId(profile.getUserId());
                detail.setName(profile.getName());
                detail.setEmail(profile.getEmail());
                detail.setPhone(profile.getPhone());
                detail.setAvatarUrl(profile.getAvatarUrl());
                detail.setAddress(profile.getAddress());
                detail.setDob(profile.getDob());

                String userId = profile.getUserId();

                // ------------ Lấy dữ liệu từ User ------------
                userDao.findById(userId).ifPresent(u -> {
                    detail.setActive(u.isActive());
                });

                // ------------ Lấy dữ liệu Staff (nếu tồn tại) ------------
                staffDao.findById(userId).ifPresent(st -> {
                    detail.setStaff(new StaffDTO(
                            st.getStaffCode(),
                            st.getPosition(),
                            st.getDepartment()
                    ));
                });

                // ------------ Lấy dữ liệu Customer (nếu muốn dùng) ------------
                customerDao.findById(userId).ifPresent(cus -> {
                    detail.setCustomer(new CustomerDTO(
                            cus.getMembershipLevel(),
                            cus.getLoyaltyPoints()
                    ));

                });

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

    public void deleteUser(String userId) {
        try {
            userDao.delete(userId);
        } catch (SQLException e) {
            throw new DataAccessException("CREATE USER ERROR: " + e.getMessage());
        }
    }
    
}
