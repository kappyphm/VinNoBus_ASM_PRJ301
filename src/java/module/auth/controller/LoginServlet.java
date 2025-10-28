package module.auth.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.googleAuth.GoogleAuthUtil;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Check user is login
        if (request.getSession().getAttribute("user_id") != null) {
            LOGGER.info("User already logged in, redirecting to profile.");
            response.sendRedirect(request.getContextPath() + "/user/profile");
            return;
        }

        // Random "state" to prevent CSRF attacks
        String state = UUID.randomUUID().toString();
        request.getSession().setAttribute("oauth_state", state);
        LOGGER.log(Level.INFO, "Generated OAuth state: {0}", state);

        // Build the Google login URL
        String authUrl = GoogleAuthUtil.buildAuthorizationUrl(state);
        LOGGER.log(Level.INFO, "Redirecting to Google OAuth URL: {0}", authUrl);

        // Redirect user to Google login
        response.sendRedirect(authUrl);
        LOGGER.info("Redirected user to Google for authentication.");
    }
}
