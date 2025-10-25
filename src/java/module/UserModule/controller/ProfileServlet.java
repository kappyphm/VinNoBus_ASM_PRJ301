/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package module.UserModule.controller;

import module.UserModule.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import module.UserModule.model.dto.ProfileDTO;

import java.io.IOException;
import java.util.logging.Logger;

import module.UserModule.service.ProfileService;
import module.UserModule.service.UserService;

/**
 *
 * @author kappyphm
 */
@WebServlet(name="ProfileServlet", urlPatterns={"/profile"})
public class ProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProfileServlet.class.getName());
    private UserService userService = new UserService();
    private ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = (String) req.getSession().getAttribute("user_id");

        ProfileDTO profile = profileService.getUserProfile(userId);

        if (profile == null) {
            LOGGER.warning("Profile not found for user ID: " + userId);
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile not found.");
            return;
        }

        req.setAttribute("profile", profile);

        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }
   
    

}
