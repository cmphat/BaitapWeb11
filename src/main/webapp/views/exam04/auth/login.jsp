<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Đề 04</title>
</head>
<body>
<div class="d-flex justify-content-center py-3 py-md-4">
    <div class="card exam-card w-100" style="max-width: 440px;">
        <div class="card-body p-4">
            <h1 class="h3 text-center page-title mb-1">Đăng nhập</h1>
            <p class="text-muted text-center small mb-4">Vui lòng nhập thông tin tài khoản để tiếp tục</p>

            <c:if test="${param.activated == '1'}">
                <div class="alert alert-success small">Kích hoạt tài khoản thành công. Bạn có thể đăng nhập.</div>
            </c:if>
            <c:if test="${not empty alert}">
                <div class="alert alert-danger small"><c:out value="${alert}"/></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="mb-3">
                    <label class="form-label small fw-semibold" for="username">Tên đăng nhập</label>
                    <input class="form-control" id="username" name="username" value="<c:out value='${username}'/>" autocomplete="username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold" for="password">Mật khẩu</label>
                    <input class="form-control" id="password" type="password" name="password" autocomplete="current-password" required>
                </div>
                <button class="btn btn-primary w-100" type="submit">Đăng nhập</button>
            </form>

            <p class="text-center small mt-3 mb-0">
                Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký tài khoản</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
