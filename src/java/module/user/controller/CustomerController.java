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
import java.util.logging.Level;
import java.util.logging.Logger;
import module.auth.model.entity.User;
import module.user.model.dto.CustomerDTO;
import module.user.model.dto.ProfileDTO;
import module.user.model.dto.StaffDTO;
import module.user.service.ProfileService;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {
    "customer/profile",
    "staff/profile",})
public class CustomerController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CustomerController.class.getName());
    private final ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        switch (path) {
            case "/customer/profile" ->
                customerView(req, resp);
            case "/staff/profile" ->
                staffView(req, resp);
            default ->
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);

        }

    }

    private void customerView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User sessionUser = (User) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String userId = sessionUser.getUserId();

        ProfileDTO profile = profileService.getUserProfile(userId);
        CustomerDTO customer = profileService.getCustomerProfile(userId);

        if (profile == null) {
            LOGGER.log(Level.WARNING, "Profile not found for user ID: {0}", userId);
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile not found.");
            return;
        }

        if (customer == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "customer data not found.");
        }

        req.setAttribute("profile", profile);
        req.setAttribute("customer", customer);

        req.getRequestDispatcher("/view/customer/profile.jsp").forward(req, resp);

    }

    private void staffView(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User sessionUser = (User) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String userId = sessionUser.getUserId();

        ProfileDTO profile = profileService.getUserProfile(userId);
        StaffDTO staff = profileService.getStaffProfile(userId);

        if (profile == null) {
            LOGGER.log(Level.WARNING, "Profile not found for user ID: {0}", userId);
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile not found.");
            return;
        }

        if (staff == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "staff data not found.");
        }

        req.setAttribute("profile", profile);
        req.setAttribute("staff", staff);

        req.getRequestDispatcher("/view/staff/profile.jsp").forward(req, resp);
    }

}
