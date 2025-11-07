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
import module.auth.model.dto.GoogleUserDTO;
import module.auth.service.AuthService;
import module.user.model.entity.User;
import util.googleAuth.GoogleAuthException;
import util.googleAuth.GoogleAuthUtil;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth/login", "/auth/logout", "/auth/register", "/auth/callback"})
public class AuthServlet extends HttpServlet {
    
    private final AuthService authService = new AuthService();

    // <editor-fold defaultstate="collapsed" desc="GET endpoints">
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/auth/login" ->
                handleGoogleLogin(req, resp);
            case "/auth/logout" ->
                handleLogout(req, resp);
            case "/auth/callback" ->
                handleCallback(req, resp);
            default ->
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
        
    }
    
    private void handleGoogleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //Check user is login
        if (req.getSession().getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/user/detail");
            return;
        }
        
        String refer = req.getHeader("Refers");
        req.getSession().setAttribute("loginRedirect", refer);

        // Random "state" to prevent CSRF attacks
        String state = UUID.randomUUID().toString();
        req.getSession().setAttribute("oauth_state", state);

        // Build the Google login URL
        String authUrl = GoogleAuthUtil.buildAuthorizationUrl(state);

        // Redirect user to Google login
        resp.sendRedirect(authUrl);
    }
    
    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();
        //TODO: delete both staff data
        resp.sendRedirect(req.getContextPath() + "/");
    }

//    private boolean isSafeRedirect(String url) {
//        if (url == null || url.isEmpty()) {
//            return false;
//        }
//        return (url.startsWith("/") && !url.startsWith("//"));
//    }
    private void handleCallback(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String state = req.getParameter("state");

        // Validate state token to prevent CSRF
        String sessionState = (String) req.getSession().getAttribute("oauth_state");
        req.getSession().removeAttribute("oauth_state");
        
        if (state == null || !state.equals(sessionState)) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid state parameter.");
            return;
        }
        
        if (code == null || code.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid code parameter.");
            return;
        }
        try {
            String idToken = GoogleAuthUtil.getIdToken(code);
            GoogleUserDTO googleUser = GoogleAuthUtil.verifyAndExtractUserProfile(idToken);
            
            Optional<User> loginResult = authService.handleLogin(googleUser);
            
            if (loginResult.isPresent()) {
                User currentUser = loginResult.get();
                
                req.getSession().setAttribute("user", currentUser);

                //TODO: foward user to home or any
                String redirectURL = (String) req.getSession().getAttribute("loginRedirect");
                req.getSession().removeAttribute("loginRedirect");
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    resp.sendRedirect(redirectURL);
                } else {
                    // Mặc định về trang chủ
                    resp.sendRedirect(req.getContextPath() + "/");
                }
            } else {
                req.setAttribute("googleUser", googleUser);
                req.setAttribute("action", "create");
                req.getRequestDispatcher("/view/user/form.jsp").forward(req, resp);

              //  resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Cannot find user in system");
            }
            
        } catch (GoogleAuthException e) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Google Auth Failed");
            
        } catch (AuthException e) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication failed: " + e.getMessage());
            
        } catch (IOException e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal error occurred.");
            
        }
    }
    // </editor-fold>

}
