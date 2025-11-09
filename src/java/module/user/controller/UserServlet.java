package module.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.Optional;
import module.user.model.dto.StaffDTO;
import module.user.model.dto.UserDetailDTO;
import module.user.service.UserService;
import util.StaffUtil;

@WebServlet(name = "UserServlet", urlPatterns = {
    // current user
    "/me",
    "/register",
    "/me/update",
    // user manage
    "/users",
    "/user",
    "/user/delete",
    // profile manage
    "/profile",
    "/profile/update",
    // customer manage
    "/customer/update",
    // staff manage
    "/staffs",
    "/staff/update",
    "/staff/assign",
    "/staff/delete",
    "/adminReg"
})
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/me" ->
                showCurrentUserInfo(req, resp);

            case "/me/update" ->
                showCurrentUserUpdateForm(req, resp);
            case "/users" ->
                listUsers(req, resp);

            case "/user" ->
                showUserDetail(req, resp);

            case "/user/delete" ->
                handleUserDelete(req, resp);
            case "/profile" ->
                showProfileDetail(req, resp);

            case "/profile/update" ->
                showProfileUpdateForm(req, resp);
            case "/customer/update" ->
                showCustomerUpdateForm(req, resp);
            case "/staffs" ->
                listStaffs(req, resp);

            case "/staff/update" ->
                showStaffUpdateForm(req, resp);

            case "/staff/assign" ->
                showStaffAssignForm(req, resp);

            case "/staff/delete" ->
                handleStaffDelete(req, resp);

            case "/adminReg" ->
                showAdminReg(req, resp);

            default ->
                resp.sendError(404, "Not Found");
        }
        // current user
        // user manage
        // profile manage
        // customer manage
        // staff manage
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/register" ->
                handleRegister(req, resp);

            case "/me/update" ->
                handleCurrentUserUpdate(req, resp);
            case "/user" ->
                createOrUpdateUser(req, resp);
            case "/profile/update" ->
                handleProfileUpdate(req, resp);
            case "/customer/update" ->
                handleCustomerUpdate(req, resp);
            case "/staff/update" ->
                handleStaffUpdate(req, resp);

            case "/staff/assign" ->
                handleStaffAssign(req, resp);
            case "/adminReg" ->
                handleAdminRegister(req, resp);
            default ->
                resp.sendError(404, "Not Found");
        }
        // current user
        // user manage
        // profile manage
        // customer manage
        // staff manage
    }

    // ===========================
    // Handler methods placeholder
    // ===========================
    private void showCurrentUserInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDetailDTO currentUser = (UserDetailDTO) req.getSession().getAttribute("user");
        req.setAttribute("userDetail", currentUser);
        req.getRequestDispatcher("/view/user/me.jsp").forward(req, resp);
    }

    private void showCurrentUserUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDetailDTO currentUser = (UserDetailDTO) req.getSession().getAttribute("user");
        req.setAttribute("userDetail", currentUser);
        req.getRequestDispatcher("/view/user/me_update.jsp").forward(req, resp);
    }

    private void handleCurrentUserUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String avatarUrl = req.getParameter("avatarUrl");
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dob = req.getParameter("dob"); // dạng String yyyy-MM-dd
        String address = req.getParameter("address");
        boolean active = req.getParameter("active").equals("true");

        UserDetailDTO userDetail = new UserDetailDTO(userId, active, name, email, phone, avatarUrl, Date.valueOf(dob), address);
        userService.saveProfile(userDetail);

        userDetail = userService.getUserDetail(userId).get();

        req.getSession().setAttribute("user", userDetail);
        resp.sendRedirect(req.getContextPath() + "/me");
        return;
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String avatarUrl = req.getParameter("avatarUrl");
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dob = req.getParameter("dob"); // dạng String yyyy-MM-dd
        String address = req.getParameter("address");

        UserDetailDTO userDetail = new UserDetailDTO(userId, true, name, email, phone, avatarUrl, Date.valueOf(dob), address);
        userService.createUserDetail(userDetail);

        userDetail = userService.getUserDetail(userId).get();

        req.getSession().setAttribute("user", userDetail);
        resp.sendRedirect(req.getContextPath() + "/me");
        return;

    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String search = req.getParameter("search");

        List<UserDetailDTO> users = userService.getUsers(search);
        req.setAttribute("search", search);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/view/user/users.jsp").forward(req, resp);
    }

    private void showUserDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        Optional<UserDetailDTO> userDetail = userService.getUserDetail(userId);
        if (userDetail.isPresent()) {
            req.setAttribute("userDetail", userDetail.get());
            req.getRequestDispatcher("/view/user/user_detail.jsp").forward(req, resp);
        } else {
            resp.sendError(404, "Cannot found any user with this ID");
            return;
        }
    }

    private void createOrUpdateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void handleUserDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        userService.deleteUser(userId);
        resp.sendRedirect(req.getContextPath() + "/users");
    }

    private void showProfileDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void showProfileUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        Optional<UserDetailDTO> userDetail = userService.getUserDetail(userId);
        if (userDetail.isPresent()) {
            req.setAttribute("userDetail", userDetail.get());
            req.getRequestDispatcher("/view/user/profile/profile_update.jsp").forward(req, resp);
        } else {
            resp.sendError(404, "Cannot found any user with this ID");
            return;
        }
    }

    private void handleProfileUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String avatarUrl = req.getParameter("avatarUrl");
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dob = req.getParameter("dob"); // dạng String yyyy-MM-dd
        String address = req.getParameter("address");
        boolean active = req.getParameter("active") != null;

        UserDetailDTO userDetail = new UserDetailDTO(userId, active, name, email, phone, avatarUrl, Date.valueOf(dob), address);
        userService.saveProfile(userDetail);

        userDetail = userService.getUserDetail(userId).get();

        req.getSession().setAttribute("user", userDetail);
        resp.sendRedirect(req.getContextPath() + "/user?id=" + userId);
        return;
    }

    private void showCustomerUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void handleCustomerUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void listStaffs(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<UserDetailDTO> staffs = userService.getStaffs();
        req.setAttribute("staffs", staffs);
        req.getRequestDispatcher("/view/user/staff/staffs.jsp").forward(req, resp);
    }

    private void showStaffUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void handleStaffUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    private void showStaffAssignForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        req.setAttribute("userId", userId);
        req.getRequestDispatcher("/view/user/staff/staff_assign.jsp").forward(req, resp);
    }

    private void handleStaffAssign(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String position = req.getParameter("position");
        String department = req.getParameter("department");

        StaffDTO staff = new StaffDTO(StaffUtil.generateStaffCode(department, position, userId), position, department);
        userService.saveStaff(userId, staff);
        resp.sendRedirect(req.getContextPath() + "/user?id=" + userId);
        return;
    }

    private void handleStaffDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        userService.deleteStaff(userId);
        resp.sendRedirect(req.getContextPath() + "/staffs");
    }

    private void handleAdminRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDetailDTO user = (UserDetailDTO) req.getSession().getAttribute("user");

        String userId = user.getUserId();
        String position = req.getParameter("position");
        String department = req.getParameter("department");

        StaffDTO staff = new StaffDTO(StaffUtil.generateStaffCode(department, position, userId), position, department);
        userService.saveStaff(userId, staff);
        resp.sendRedirect(req.getContextPath() + "/me");
        return;

    }

    private void showAdminReg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setAttribute("action", "adminReg");
        req.getRequestDispatcher("/view/user/staff/staff_assign.jsp").forward(req, resp);
    }
}
