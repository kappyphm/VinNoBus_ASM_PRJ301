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
import java.util.logging.Logger;

import module.auth.model.entity.User;
import module.user.model.dto.ProfileDTO;
import module.user.service.ProfileService;

/**
 *
 * @author kappyphm
 */
@WebServlet(name="ProfileServlet", urlPatterns={"/user/profile"})
public class ProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProfileServlet.class.getName());
    private ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User sessionUser = (User) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String userId = sessionUser.getUserId();

        ProfileDTO profile = profileService.getUserProfile(userId);

        if (profile == null) {
            LOGGER.warning("Profile not found for user ID: " + userId);
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile not found.");
            return;
        }

        req.setAttribute("profile", profile);

        req.getRequestDispatcher("/view/user/profile.jsp").forward(req, resp);
    }
   
    

}
