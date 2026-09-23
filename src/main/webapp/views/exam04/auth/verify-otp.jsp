<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><title>Xác thực OTP - Đề 04</title></head><body>
<div class="row justify-content-center py-md-4"><div class="col-md-6 col-lg-5">
<div class="card exam-card"><div class="card-body p-4">
    <h1 class="h3 mb-2">Xác thực OTP</h1>
    <p class="text-muted">Mã gồm 6 chữ số đã được gửi tới <strong><c:out value="${sessionScope.pendingEmail}"/></strong> và có hiệu lực trong 5 phút.</p>
    <c:if test="${sessionScope.otpMailSent == false}"><div class="alert alert-warning">Chưa gửi được email. Hãy kiểm tra cấu hình SMTP rồi thử gửi lại.</div></c:if>
    <c:if test="${not empty alert}"><div class="alert alert-danger"><c:out value="${alert}"/></div></c:if>
    <c:if test="${not empty success}"><div class="alert alert-success"><c:out value="${success}"/></div></c:if>
    <form method="post" action="${pageContext.request.contextPath}/verify-otp">
        <label class="form-label" for="otp">Mã OTP</label>
        <input class="form-control form-control-lg text-center mb-3" id="otp" name="otp" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" autocomplete="one-time-code" required>
        <button class="btn btn-primary w-100" type="submit">Kích hoạt tài khoản</button>
    </form>
    <form method="post" action="${pageContext.request.contextPath}/resend-otp" class="text-center mt-3">
        <button class="btn btn-link text-decoration-none" type="submit">Gửi lại mã OTP</button>
    </form>
</div></div></div></div>
</body></html>
