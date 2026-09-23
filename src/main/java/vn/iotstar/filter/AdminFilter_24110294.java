package vn.iotstar.filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import vn.iotstar.model.User_24110294;

@WebFilter("/admin/*")
public class AdminFilter_24110294 implements Filter {
    @Override public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain)throws IOException,ServletException{
        HttpServletRequest req=(HttpServletRequest)request; HttpServletResponse resp=(HttpServletResponse)response;
        HttpSession session=req.getSession(false); Object account=session==null?null:session.getAttribute("account");
        if(!(account instanceof User_24110294)){resp.sendRedirect(req.getContextPath()+"/login");return;}
        if(!((User_24110294)account).isAdmin()){resp.sendError(HttpServletResponse.SC_FORBIDDEN,"Chỉ quản trị viên được truy cập.");return;}
        chain.doFilter(request,response);
    }
}
