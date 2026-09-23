package vn.iotstar.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.User_24110294;
import vn.iotstar.service.IUserService_24110294;
import vn.iotstar.service.impl.UserService_24110294;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.OtpUtil;

@WebServlet("/register")
public class RegisterController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService_24110294 service = new UserService_24110294();
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/exam04/auth/register.jsp").forward(req, resp);
    }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = val(req,"username"), password = val(req,"password"), fullname = val(req,"fullname");
        String phone = val(req,"phone"), email = val(req,"email");
        req.setAttribute("username", username); req.setAttribute("fullname", fullname); req.setAttribute("phone", phone); req.setAttribute("email", email);
        if (username.length() < 3 || password.length() < 6 || fullname.isBlank() || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ và đúng định dạng thông tin đăng ký.");
            req.getRequestDispatcher("/views/exam04/auth/register.jsp").forward(req, resp); return;
        }
        if (service.findByUsername(username) != null || service.findByEmail(email) != null) {
            req.setAttribute("alert", "Tên đăng nhập hoặc email đã tồn tại.");
            req.getRequestDispatcher("/views/exam04/auth/register.jsp").forward(req, resp); return;
        }
        User_24110294 u = new User_24110294();
        u.setUsername(username); u.setPassword(password); u.setFullname(fullname); u.setPhone(phone); u.setEmail(email);
        u.setAdmin(false); u.setActive(false); service.insert(u);
        String otp = OtpUtil.generateOtp();
        HttpSession session = req.getSession(true);
        session.setAttribute("otpUsername", username); session.setAttribute("otpCode", otp);
        session.setAttribute("otpExpiry", LocalDateTime.now().plusMinutes(5));
        boolean sent = EmailUtil.sendOtp(email, otp, "ACTIVATE");
        session.setAttribute("otpMailSent", sent);
        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
    private String val(HttpServletRequest req, String n) { String s=req.getParameter(n); return s==null?"":s.trim(); }
}

