package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import module.user.model.entity.User;

@WebFilter({
    "/user/detail",
    "/user/update"
}) // áp dụng cho tất cả request, nhưng chúng ta sẽ lọc bên trong
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getServletPath();
        // Cho phép truy cập /user/update nếu là POST (đang hoàn thiện hồ sơ)
        if ("/user/update".equals(path) && "POST".equalsIgnoreCase(req.getMethod())) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            // chưa đăng nhập → redirect về login
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return; // dừng request
        }

        // nếu đã login hoặc trang không cần bảo vệ → cho tiếp tục
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
