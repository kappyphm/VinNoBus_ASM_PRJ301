package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebFilter("/oauth2callback")
public class OAuthSercurityFilter implements Filter {

    private final Logger LOGGER = Logger.getLogger(OAuthSercurityFilter.class.getName());

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String code = request.getParameter("code");
        String state = request.getParameter("state");

        if (code == null || state == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            LOGGER.warning("Missing OAuth parameters: code or state.");
            return;
        }

        fc.doFilter(req, res);
    }

}
