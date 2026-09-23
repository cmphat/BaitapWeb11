<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Xác thực OTP - Đề 04</title></head><body><div class="row justify-content-center"><div class="col-md-5"><div class="card shadow-sm"><div class="card-body p-4"><h3>Xác thực OTP</h3><p>Mã OTP gồm 6 chữ số, có hiệu lực 5 phút.</p>
<c:if test="${sessionScope.otpMailSent == false}"><div class="alert alert-warning">Máy chủ chưa gửi được email. Hãy kiểm tra cấu hình SMTP rồi đăng ký lại.</div></c:if><c:if test="${not empty alert}"><div class="alert alert-danger"><c:out value="${alert}"/></div></c:if>
<form method="post" action="${pageContext.request.contextPath}/verify-otp"><input class="form-control mb-3" name="otp" pattern="[0-9]{6}" maxlength="6" required><button class="btn btn-primary w-100">Kích hoạt tài khoản</button></form></div></div></div></div></body></html>

