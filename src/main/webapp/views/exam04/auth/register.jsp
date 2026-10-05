<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Đề 04</title>
</head>
<body>
<div class="d-flex justify-content-center py-3 py-md-4">
    <div class="card exam-card w-100" style="max-width: 600px;">
        <div class="card-body p-4">
            <h1 class="h3 page-title mb-1">Đăng ký tài khoản</h1>
            <p class="text-muted small mb-4">Mã OTP xác thực sẽ được gửi tới email của bạn.</p>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger small"><c:out value="${alert}"/></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/register">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold" for="username">Tên đăng nhập</label>
                        <input class="form-control" id="username" name="username" value="<c:out value='${username}'/>" minlength="3" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold" for="password">Mật khẩu</label>
                        <input class="form-control" id="password" type="password" name="password" minlength="6" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold" for="fullname">Họ và tên</label>
                        <input class="form-control" id="fullname" name="fullname" value="<c:out value='${fullname}'/>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold" for="phone">Số điện thoại</label>
                        <input class="form-control" id="phone" name="phone" value="<c:out value='${phone}'/>" pattern="0[0-9]{9,10}">
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold" for="email">Email nhận OTP</label>
                        <input class="form-control" id="email" type="email" name="email" value="<c:out value='${email}'/>" required>
                    </div>
                    <div class="col-12 d-flex gap-2 pt-2">
                        <button class="btn btn-primary" type="submit">Đăng ký</button>
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
