package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import module.user.model.dto.UserDetailDTO;

@WebFilter({
    "/users", //MANAGER,SALE
    "/user", //MANAGER,SALE
    "/user/delete", //MANAGER
    // profile manage
    "/profile", //MANAGER,SALE
    "/profile/update", //MANAGER,SALE
    // customer manage
    "/customer/update",//SALE, MANAGER
    // staff manage
    "/staffs", //MANAGER
    "/staff/update", //MANAGER
    "/staff/assign", //MANAGER
    "/staff/delete", //MANAGER
    "/ticket/checkin",//OPERATOR
    "/ticket/create"//OPERATOR,SALE
}) // áp dụng cho tất cả request
public class RoleFilter implements Filter {

    // Map route -> allowed roles
    private static final Map<String, List<String>> routeRoles = new HashMap<>();

    static {
        routeRoles.put("/users", Arrays.asList("MANAGER", "SALE"));
        routeRoles.put("/user", Arrays.asList("MANAGER", "SALE"));
        routeRoles.put("/user/delete", Arrays.asList("MANAGER"));
        routeRoles.put("/profile", Arrays.asList("MANAGER", "SALE"));
        routeRoles.put("/profile/update", Arrays.asList("MANAGER", "SALE"));
        routeRoles.put("/customer/update", Arrays.asList("MANAGER", "SALE"));
        routeRoles.put("/staffs", Arrays.asList("MANAGER"));
        routeRoles.put("/staff/update", Arrays.asList("MANAGER"));
        routeRoles.put("/staff/assign", Arrays.asList("MANAGER"));
        routeRoles.put("/staff/delete", Arrays.asList("MANAGER"));
        routeRoles.put("/ticket/checkin", Arrays.asList("OPERATOR"));
        routeRoles.put("/ticket/create", Arrays.asList("OPERATOR", "SALE"));
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getServletPath(); // lấy route

        // Nếu route có trong danh sách
        if (routeRoles.containsKey(path)) {
            if (session != null) {
                UserDetailDTO user = (UserDetailDTO) session.getAttribute("user");
                String role = user.getStaff().getDepartment();
                if (role != null && routeRoles.get(path).contains(role)) {
                    chain.doFilter(request, response); // hợp lệ
                    return;
                }
            }
            // nếu không hợp lệ
            res.sendRedirect(req.getContextPath() + "/accessDenied.jsp");
            return;
        }

        // các route không có trong map -> cho phép truy cập
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
