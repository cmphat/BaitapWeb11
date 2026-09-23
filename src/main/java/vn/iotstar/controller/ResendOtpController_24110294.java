package vn.iotstar.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.OtpUtil;

@WebServlet("/resend-otp")
public class ResendOtpController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("pendingUsername") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        String email = (String) session.getAttribute("pendingEmail");
        String fullname = (String) session.getAttribute("pendingFullname");
        String otp = OtpUtil.generateOtp();
        session.setAttribute("otp", otp);
        session.setAttribute("otpCreatedAt", LocalDateTime.now());
        boolean sent = EmailUtil.sendActivationOtp(email, fullname, otp);
        session.setAttribute("otpMailSent", sent);
        req.setAttribute(sent ? "success" : "alert", sent
                ? "Đã gửi lại mã OTP. Vui lòng kiểm tra email."
                : "Không gửi được email OTP. Vui lòng kiểm tra cấu hình SMTP.");
        req.getRequestDispatcher("/views/exam04/auth/verify-otp.jsp").forward(req, resp);
    }
}
