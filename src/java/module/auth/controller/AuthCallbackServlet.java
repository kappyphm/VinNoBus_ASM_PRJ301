package module.auth.controller;

import exception.AuthException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import module.auth.model.entity.GoogleUserProfile;
import module.auth.model.entity.User;
import module.auth.service.AuthService;
import util.googleAuth.GoogleAuthException;
import util.googleAuth.GoogleAuthUtil;

@WebServlet("/oauth2callback")
public class AuthCallbackServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(AuthCallbackServlet.class.getName());

    private AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String state = request.getParameter("state");

        // Validate state token to prevent CSRF
        String sessionState = (String) request.getSession().getAttribute("oauth_state");
        if (state == null || !state.equals(sessionState)) {
            LOGGER.warning("Invalid OAuth state parameter");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid state parameter.");
            return;
        }

        if (code == null || code.isEmpty()) {
            LOGGER.warning("Invalid OAuth code parameter");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid code parameter.");
            return;
        }

        LOGGER.info("Exchanging authorization code for access token.");

        try {
            String idToken = GoogleAuthUtil.getIdToken(code);

            GoogleUserProfile profile = GoogleAuthUtil.verifyAndExtractUserProfile(idToken);

            Optional<User> user = authService.handleGoogleLogin(profile);

            // if user is present, log them in; else redirect to registration
            if (user.isPresent()) {
                request.getSession().setAttribute("user_id", user.get().getUserId());
                LOGGER.log(Level.INFO, "User logged in successfully: {0}", user.get().getUserId());
                response.sendRedirect(request.getContextPath() + "/user/profile");
            } else {
                LOGGER.info("No existing user found, redirecting to registration.");
                request.getSession().setAttribute("googleProfile", profile);
                response.sendRedirect(request.getContextPath() + "/auth/register");
            }

        } catch (GoogleAuthException e) {
            LOGGER.log(Level.SEVERE, "Google authentication failed: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Google Auth Failed");

        } catch (AuthException e) {
            LOGGER.log(Level.WARNING, "Business logic error: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication failed: " + e.getMessage());

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unhandled error during OAuth callback", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal error occurred.");

        }
    }
}
