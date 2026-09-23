package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.User_24110294;
import vn.iotstar.service.IUserService_24110294;
import vn.iotstar.service.impl.UserService_24110294;

@WebServlet("/login")
public class LoginController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService_24110294 service = new UserService_24110294();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession(false) != null && req.getSession(false).getAttribute("account") != null) {
            User_24110294 u = (User_24110294) req.getSession(false).getAttribute("account");
            resp.sendRedirect(req.getContextPath() + (u.isAdmin() ? "/admin/home" : "/home")); return;
        }
        req.getRequestDispatcher("/views/exam04/auth/login.jsp").forward(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = value(req.getParameter("username"));
        String password = value(req.getParameter("password"));
        User_24110294 found = service.findByUsername(username);
        if (found != null && password.equals(found.getPassword()) && !found.isActive()) {
            req.setAttribute("alert", "Tài khoản chưa được kích hoạt.");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/exam04/auth/login.jsp").forward(req, resp); return;
        }
        User_24110294 user = service.login(username, password);
        if (user == null) {
            req.setAttribute("alert", "Tên đăng nhập hoặc mật khẩu không đúng.");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/exam04/auth/login.jsp").forward(req, resp); return;
        }
        req.getSession(true).setAttribute("account", user);
        resp.sendRedirect(req.getContextPath() + (user.isAdmin() ? "/admin/home" : "/home"));
    }
    private String value(String s) { return s == null ? "" : s.trim(); }
}
