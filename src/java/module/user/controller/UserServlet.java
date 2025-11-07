package module.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = {
    // current user
    "/me",
    "/register",
    "/me/update",
    // user manage
    "/users",
    "/user",
    "/user/delete",
    // profile manage
    "/profile",
    "/profile/update",
    // customer manage
    "/customer/update",
    // staff manage
    "/staffs",
    "/staff/update",
    "/staff/assign",
    "/staff/delete"
})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {

            // current user
            case "/me":
                showCurrentUserInfo(req, resp);
                break;

            case "/me/update":
                showCurrentUserUpdateForm(req, resp);
                break;

            // user manage
            case "/users":
                listUsers(req, resp);
                break;

            case "/user":
                showUserDetail(req, resp);
                break;

            // profile manage
            case "/profile":
                showProfileDetail(req, resp);
                break;

            case "/profile/update":
                showProfileUpdateForm(req, resp);
                break;

            // customer manage
            case "/customer/update":
                showCustomerUpdateForm(req, resp);
                break;

            // staff manage
            case "/staffs":
                listStaffs(req, resp);
                break;

            case "/staff/update":
                showStaffUpdateForm(req, resp);
                break;

            case "/staff/assign":
                showStaffAssignForm(req, resp);
                break;

            default:
                resp.sendError(404, "Not Found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {

            // current user
            case "/register":
                handleRegister(req, resp);
                break;

            case "/me/update":
                handleCurrentUserUpdate(req, resp);
                break;

            // user manage
            case "/user":
                createOrUpdateUser(req, resp);
                break;

            case "/user/delete":
                handleUserDelete(req, resp);
                break;

            // profile manage
            case "/profile/update":
                handleProfileUpdate(req, resp);
                break;

            // customer manage
            case "/customer/update":
                handleCustomerUpdate(req, resp);
                break;

            // staff manage
            case "/staff/update":
                handleStaffUpdate(req, resp);
                break;

            case "/staff/assign":
                handleStaffAssign(req, resp);
                break;

            case "/staff/delete":
                handleStaffDelete(req, resp);
                break;

            default:
                resp.sendError(404, "Not Found");
        }
    }

    // ===========================
    // Handler methods placeholder
    // ===========================
    private void showCurrentUserInfo(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showCurrentUserUpdateForm(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleCurrentUserUpdate(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showUserDetail(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void createOrUpdateUser(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleUserDelete(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showProfileDetail(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showProfileUpdateForm(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleProfileUpdate(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showCustomerUpdateForm(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleCustomerUpdate(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void listStaffs(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showStaffUpdateForm(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleStaffUpdate(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showStaffAssignForm(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleStaffAssign(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleStaffDelete(HttpServletRequest req, HttpServletResponse resp) {
    }
}
