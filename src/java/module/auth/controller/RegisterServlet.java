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
import module.auth.service.AuthService;
import module.user.model.input.UserProfileInput;

/**
 *
 * @author kappyphm
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/auth/register"})
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        

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
            authService.register(profileInput);
            //set user_sub in session
            req.getSession().setAttribute("user_id", userId);
            req.getSession().removeAttribute("googleProfile");
            resp.sendRedirect(req.getContextPath() + "/auth/login");
        } catch (AuthException e) {
            req.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/view/auth/register.jsp").forward(req, resp);
        }

    }
    
    
    
}
