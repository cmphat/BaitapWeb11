<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực tài khoản - Đề 04</title>
</head>
<body>
<div class="d-flex justify-content-center py-3 py-md-4">
    <div class="card exam-card w-100" style="max-width: 480px;">
        <div class="card-body p-4">
            <h1 class="h3 text-center page-title mb-1">Xác thực tài khoản</h1>
            <p class="text-muted text-center small mb-3">Mã OTP đã được gửi tới email của bạn.</p>

            <c:if test="${sessionScope.otpMailSent == false}">
                <div class="alert alert-warning small">Chưa gửi được email tự động. Vui lòng kiểm tra SMTP hoặc gửi lại.</div>
            </c:if>
            <c:if test="${not empty alert}">
                <div class="alert alert-danger small"><c:out value="${alert}"/></div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success small"><c:out value="${success}"/></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/verify-otp">
                <div class="mb-3">
                    <label class="form-label small fw-semibold text-center d-block" for="otp">Mã OTP (6 chữ số)</label>
                    <input class="form-control form-control-lg text-center fw-bold" id="otp" name="otp" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" placeholder="000000" autocomplete="one-time-code" required>
                </div>
                <button class="btn btn-primary w-100" type="submit">Xác nhận</button>
            </form>

            <form method="post" action="${pageContext.request.contextPath}/resend-otp" class="text-center mt-3">
                <button class="btn btn-link btn-sm text-decoration-none" type="submit">Gửi lại OTP</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
