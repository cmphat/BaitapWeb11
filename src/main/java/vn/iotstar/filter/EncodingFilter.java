package vn.iotstar.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
public class EncodingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String uri = ((HttpServletRequest) request).getRequestURI();
        if (!uri.contains("/assets/") && !uri.contains("/css/") && !uri.contains("/js/")
                && !uri.contains("/images/") && !uri.contains("/uploads/")) {
            response.setContentType("text/html; charset=UTF-8");
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
