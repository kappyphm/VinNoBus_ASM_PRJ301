package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.entity.GoogleUserProfile;
import util.googleAuth.GoogleAuthException;
import util.googleAuth.GoogleAuthUtil;

@WebServlet("/oauth2callback")
public class AuthCallbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String state = request.getParameter("state");

        // Validate state token to prevent CSRF
        String sessionState = (String) request.getSession().getAttribute("oauth_state");
        if (state == null || !state.equals(sessionState)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid state parameter.");
            return;
        }

        try {
            // Step 1: Exchange authorization code for ID token
            String idToken = GoogleAuthUtil.getIdToken(code);

            // Step 2: Verify and extract user info
            GoogleUserProfile profile = GoogleAuthUtil.verifyAndExtractUserProfile(idToken);

            // Step 3: Check if user exists in database
            // Example (you replace this with real DB logic)
            //boolean isNewUser = !UserDAO.exists(profile.getEmail());

            // Save user info in session
            //request.getSession().setAttribute("user", profile);

            // Step 4: Redirect based on user existence
//            if (isNewUser) {
//                response.sendRedirect("complete-profile.jsp");
//            } else {
//                response.sendRedirect("profile.jsp");
//            }

        } catch (GoogleAuthException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Google authentication failed.");
        }
    }
}
