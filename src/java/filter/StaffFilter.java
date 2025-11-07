package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import module.user.model.dto.UserDetailDTO;

@WebFilter({
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
}) // áp dụng cho tất cả request, nhưng chúng ta sẽ lọc bên trong
public class StaffFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getServletPath();

        UserDetailDTO user = (UserDetailDTO) req.getSession().getAttribute("user");

        if (user == null) {
            // chưa đăng nhập → redirect về login
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return; // dừng request
        }

        if (user.getStaff() == null || !"MANAGER".equals(user.getStaff().getDepartment())) {
            resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Deined");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
