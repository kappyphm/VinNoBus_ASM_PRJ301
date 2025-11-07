/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import module.user.model.dto.CustomerDTO;
import module.user.model.dto.StaffDTO;
import module.user.model.dto.UserDetailDTO;
import module.user.model.entity.User;
import module.user.service.StaffService;
import module.user.service.UserService;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "UserServlet", urlPatterns = {
    //current user
    "/me",
    "/register",
    "/me/update",
    
    //user manage
    "/users",
    "/user",
    "/user/delete",
    //profile manage
    "/profile",
    "/profile/update",
    //customer manage
    "/customer/update",
    //staff manage
    "/staffs",
    "/staff/update",
    "/staff/assign",
    "/staff/delete"

})
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();
    private final StaffService staffService = new StaffService();

    // <editor-fold defaultstate="collapsed" desc="GET Methods">
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {

            case "/user/detail" ->
                showProfile(req, resp);
            case "/profile/update" ->
                showUpdateProfileForm(req, resp);

            case "/user/delete" ->
                deleteUser(req, resp);

            //customer
            case "/customers" ->
                showCustomerList(req, resp);
            case "/customer/detail" ->
                showCustomer(req, resp);
            case "/customer/update" ->
                showCustomerForm(req, resp);

            //staff
            case "/staffs" ->
                showStaffList(req, resp);
            default ->
                resp.sendError(404, "Page not found" + path);
        }
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDetailDTO currentSessionUser = (UserDetailDTO) req.getSession().getAttribute("user");

        Optional<UserDetailDTO> userDetail = userService.getUserDetail(currentSessionUser.getUserId());
        if (userDetail.isPresent()) {
            req.setAttribute("userDetail", userDetail.get());
            req.getRequestDispatcher("/view/user/detail.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Cannot found user detail");
        }

    }

    private void showUpdateProfileForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");

        UserDetailDTO currentSessionUser = (UserDetailDTO) req.getSession().getAttribute("user");

        if (userId == null || userId.isBlank()) {
            userId = currentSessionUser.getUserId();

        }
        Optional<UserDetailDTO> userDetail = userService.getUserDetail(userId);

        req.setAttribute("userDetail", userDetail.get());
        req.setAttribute("action", "update");
        req.setAttribute("editPmt", false);
        req.getRequestDispatcher("/view/user/form.jsp").forward(req, resp);

    }

// </editor-fold>
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {

            //user guest
            case "/user/create" ->
                createProfile(req, resp);
            case "/profile/update" ->
                updateProfile(req, resp);
            case "/user/detele" ->
                deleteUser(req, resp);

            //update for staff
            case "/staff/update" ->
                updateStaff(req, resp);
            case "/customer/update" ->
                updateCustomer(req, resp);

            default ->
                resp.sendError(404, "Page not found");
        }
    }

    private void createProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String avatarUrl = req.getParameter("avatarUrl");
        String address = req.getParameter("address");
        boolean active = req.getParameter("active") != null;
        Date dob = Date.valueOf(req.getParameter("dob"));

        UserDetailDTO userDetail = new UserDetailDTO(userId, active, name, email, phone, avatarUrl, dob, address);
        User u = userService.createUserDetail(userDetail);

        req.getSession().setAttribute("user", userDetail);
        resp.sendRedirect(req.getContextPath() + "/user/detail");
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String avatarUrl = req.getParameter("avatarUrl");
        String address = req.getParameter("address");
        boolean active = req.getParameter("active") != null;
        Date dob = Date.valueOf(req.getParameter("dob"));

        UserDetailDTO userDetail = new UserDetailDTO(userId, active, name, email, phone, avatarUrl, dob, address);
        userService.saveProfile(userDetail);
        resp.sendRedirect(req.getContextPath() + "/user/detail");
    }

    private void updateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String membershipLevel = req.getParameter("membershipLevel");
        int loyaltyPoints = Integer.parseInt(req.getParameter("loyaltyPoints"));

        CustomerDTO customer = new CustomerDTO(membershipLevel, loyaltyPoints);
        userService.saveCustomer(userId, customer);
        resp.sendRedirect(req.getContextPath() + "/user/detail");
    }

    private void updateStaff(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");

        String staffCode = req.getParameter("staffCode");
        String position = req.getParameter("position");
        String department = req.getParameter("department");

        StaffDTO staff = new StaffDTO(staffCode, position, department);
        userService.saveStaff(userId, staff);
        resp.sendRedirect(req.getContextPath() + "/user/detail");
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userId = req.getParameter("id");

        userService.deleteUser(userId);
        resp.sendRedirect(req.getContextPath() + "/customers");
    }

    private void showCustomerList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search"); // từ ô tìm kiếm
        String sort = req.getParameter("sort");     // từ select sắp xếp
        String pageParam = req.getParameter("page"); // trang hiện tại
        int currentPage = 1;
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Ví dụ: gọi service lấy danh sách nhân viên dựa trên search, sort, currentPage
        List<UserDetailDTO> users = userService.getUsers(search, sort, currentPage);

        int totalPages = users.size() / 15;

        // Set attributes để JSP dùng
        req.setAttribute("userDetails", users);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/view/user/customer/list.jsp").forward(req, resp);
    }

    private void showStaffList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String search = req.getParameter("search"); // từ ô tìm kiếm
        String sort = req.getParameter("sort");     // từ select sắp xếp
        String pageParam = req.getParameter("page"); // trang hiện tại
        int currentPage = 1;
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Ví dụ: gọi service lấy danh sách nhân viên dựa trên search, sort, currentPage
        List<UserDetailDTO> users = userService.getUsers(search, sort, currentPage);

        int totalPages = users.size() / 15;

        // Set attributes để JSP dùng
        req.setAttribute("userDetails", users);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/view/user/staff/list.jsp").forward(req, resp);
    }

    private void showCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");

        Optional<UserDetailDTO> userOtp = userService.getUserDetail(userId);
        if (userOtp.isPresent()) {
            req.setAttribute("userDetail", userOtp.get());
            req.getRequestDispatcher("/view/user/customer/detail.jsp").forward(req, resp);
        } else {
            resp.sendError(404, "User not found");
            return;
        }

    }

    private void showCustomerForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");

        Optional<UserDetailDTO> userOtp = userService.getUserDetail(userId);
        if (userOtp.isPresent()) {
            req.setAttribute("userDetail", userOtp.get());
            req.setAttribute("editPmt", true);
            req.setAttribute("action", "update");
            req.getRequestDispatcher("/view/user/customer/form.jsp").forward(req, resp);
        } else {
            resp.sendError(404, "User not found");
            return;
        }

    }

}
