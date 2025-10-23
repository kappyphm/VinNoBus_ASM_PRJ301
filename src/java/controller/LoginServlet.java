package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;
import util.googleAuth.GoogleAuthUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Random "state" to prevent CSRF attacks
        String state = UUID.randomUUID().toString();
        request.getSession().setAttribute("oauth_state", state);

        // Build the Google login URL
        String authUrl = GoogleAuthUtil.buildAuthorizationUrl(state);

        // Redirect user to Google login
        response.sendRedirect(authUrl);
    }
}
