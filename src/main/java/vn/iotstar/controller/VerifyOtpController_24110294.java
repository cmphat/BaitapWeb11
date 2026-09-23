package vn.iotstar.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.service.IUserService_24110294;
import vn.iotstar.service.impl.UserService_24110294;

@WebServlet("/verify-otp")
public class VerifyOtpController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService_24110294 service = new UserService_24110294();
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession(false) == null || req.getSession(false).getAttribute("otpUsername") == null) {
            resp.sendRedirect(req.getContextPath()+"/register"); return;
        }
        req.getRequestDispatcher("/views/exam04/auth/verify-otp.jsp").forward(req,resp);
    }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s=req.getSession(false);
        String input=req.getParameter("otp");
        if (s==null || s.getAttribute("otpUsername")==null) { resp.sendRedirect(req.getContextPath()+"/register"); return; }
        String expected=(String)s.getAttribute("otpCode"); LocalDateTime expiry=(LocalDateTime)s.getAttribute("otpExpiry");
        if (input==null || !input.trim().equals(expected) || expiry==null || LocalDateTime.now().isAfter(expiry)) {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn.");
            req.getRequestDispatcher("/views/exam04/auth/verify-otp.jsp").forward(req,resp); return;
        }
        service.activate((String)s.getAttribute("otpUsername"));
        s.removeAttribute("otpUsername"); s.removeAttribute("otpCode"); s.removeAttribute("otpExpiry"); s.removeAttribute("otpMailSent");
        resp.sendRedirect(req.getContextPath()+"/login?activated=1");
    }
}

