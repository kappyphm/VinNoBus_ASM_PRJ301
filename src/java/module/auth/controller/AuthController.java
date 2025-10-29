/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package module.auth.controller;

import exception.AuthException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import module.auth.model.entity.GoogleUserProfile;
import module.auth.model.entity.User;
import module.auth.service.AuthService;
import module.user.model.input.UserProfileInput;
import util.googleAuth.GoogleAuthException;
import util.googleAuth.GoogleAuthUtil;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "AuthController", urlPatterns = {"/auth/login", "/auth/logout", "/auth/register", "/auth/callback"})
public class AuthController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AuthController.class.getName());
    private final AuthService authService = new AuthService();

    // <editor-fold defaultstate="collapsed" desc="GET endpoints">
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case  "/auth/login" ->
                handleLogin(req, resp);
            case "/auth/logout" ->
                handleLogout(req, resp);
            case "/auth/register" ->
                getRegister(req, resp);
            case "/auth/callback" ->
                handleCallback(req, resp);
            default ->
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }

    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Check user is login
        if (req.getSession().getAttribute("user") != null) {
            LOGGER.info("User already logged in, redirecting to profile.");
            resp.sendRedirect(req.getContextPath() + "/user/profile");
            return;
        }

        // Random "state" to prevent CSRF attacks
        String state = UUID.randomUUID().toString();
        req.getSession().setAttribute("oauth_state", state);
        LOGGER.log(Level.INFO, "Generated OAuth state: {0}", state);

        // Build the Google login URL
        String authUrl = GoogleAuthUtil.buildAuthorizationUrl(state);
        LOGGER.log(Level.INFO, "Redirecting to Google OAuth URL: {0}", authUrl);

        // Redirect user to Google login
        resp.sendRedirect(authUrl);
        LOGGER.info("Redirected user to Google for authentication.");
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().removeAttribute("user");
        //TODO: delete both staff data
        resp.sendRedirect(req.getContextPath() + "/");
    }

    private void getRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/auth/register.jsp").forward(req, resp);
    }

    private void handleCallback(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String state = req.getParameter("state");

        // Validate state token to prevent CSRF
        String sessionState = (String) req.getSession().getAttribute("oauth_state");
        if (state == null || !state.equals(sessionState)) {
            LOGGER.warning("Invalid OAuth state parameter");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid state parameter.");
            return;
        }

        if (code == null || code.isEmpty()) {
            LOGGER.warning("Invalid OAuth code parameter");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid code parameter.");
            return;
        }

        LOGGER.info("Exchanging authorization code for access token.");

        try {
            String idToken = GoogleAuthUtil.getIdToken(code);

            GoogleUserProfile profile = GoogleAuthUtil.verifyAndExtractUserProfile(idToken);

            Optional<User> user = authService.handleGoogleLogin(profile);

            // if user is present, log them in; else redirect to registration
            if (user.isPresent()) {
                req.getSession().setAttribute("user", user.get());
                LOGGER.log(Level.INFO, "User logged in successfully: {0}", user.get().getUserId());
                resp.sendRedirect(req.getContextPath() + "/user/profile");
            } else {
                LOGGER.info("No existing user found, redirecting to registration.");
                req.getSession().setAttribute("googleProfile", profile);
                resp.sendRedirect(req.getContextPath() + "/auth/register");
            }

        } catch (GoogleAuthException e) {
            LOGGER.log(Level.SEVERE, "Google authentication failed: " + e.getMessage(), e);
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Google Auth Failed");

        } catch (AuthException e) {
            LOGGER.log(Level.WARNING, "Business logic error: " + e.getMessage(), e);
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication failed: " + e.getMessage());

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Unhandled error during OAuth callback", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal error occurred.");

        }
    }
    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="POST Endpoints">
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {

            case "/auth/register" ->
                handleRegister(req, resp);

            default ->
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String dateOfBirth = req.getParameter("dateOfBirth");
        String avatarUrl = req.getParameter("pictureUrl");
        String userId = req.getParameter("googleSub");

        UserProfileInput profileInput = new UserProfileInput(
                userId,
                fullName,
                email,
                phone,
                address,
                avatarUrl,
                dateOfBirth
        );

        try {
            Optional<User> newUserOpt = authService.register(profileInput);
            if (newUserOpt.isPresent()) {
                req.getSession().setAttribute("user", newUserOpt.get());
                req.getSession().removeAttribute("googleProfile");
                resp.sendRedirect(req.getContextPath() + "/auth/login");
            } else {
                req.setAttribute("errorMessage", "Registration failed: User not found after insert.");
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (AuthException e) {
            req.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    // </editor-fold>
}
