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
import java.util.Optional;
import module.user.model.dto.UserDetailDTO;
import module.user.model.entity.User;
import module.user.service.UserService;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "UserServlet", urlPatterns = {
    "/user/detail", 
    "/user/update", 
    "/user/create",
    "/user/detete",
    
    "/staffs",
    "/staff/detail",
    "/staff/update",
    "/staff/create",
    "/staff/delete",
    
    "/customers",
    "/customer/detail",
    "/customer/update",
    "/customer/create",
    "/customer/delete",
    
    

})
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    // <editor-fold defaultstate="collapsed" desc="GET Methods">
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {

            case "/user/detail" ->
                showProfile(req, resp);
            case "/user/update" ->
                showUpdateProfileForm(req, resp);
            default ->
                resp.sendError(404, "Page not found" + path);
        }
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentSessionUser = (User) req.getSession().getAttribute("user");

        Optional<UserDetailDTO> userDetail = userService.getUserDetail(currentSessionUser.getUserId());
        if (userDetail.isPresent()) {
            req.setAttribute("userDetail", userDetail.get());
            req.getRequestDispatcher("/view/user/detail.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Cannot found user detail");
        }

    }

    private void showUpdateProfileForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentSessionUser = (User) req.getSession().getAttribute("user");
        Optional<UserDetailDTO> userDetail = userService.getUserDetail(currentSessionUser.getUserId());

        req.setAttribute("userDetail", userDetail.get());
        req.setAttribute("action", "update");
        req.getRequestDispatcher("/view/user/form.jsp").forward(req, resp);

    }

// </editor-fold>
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {

            case "/user/create" ->
                createProfile(req, resp);
            case "/user/update" ->
                updateProfile(req, resp);
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
        req.getSession().setAttribute("user", u);
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
        userService.saveUserDetail(userDetail);
        resp.sendRedirect(req.getContextPath() + "/user/detail");
    }

}
