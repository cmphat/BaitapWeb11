<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${mode == 'create' ? 'Tạo người dùng' : 'Cập nhật người dùng'} - Đề 04</title>
</head>
<body>
<div class="card exam-card">
    <div class="card-body p-4">
        <h1 class="h3 page-title mb-1">${mode == 'create' ? 'Thêm người dùng mới' : 'Cập nhật người dùng'}</h1>
        <p class="text-muted small mb-4">Điền đầy đủ các thông tin cần thiết bên dưới.</p>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger small"><c:out value="${alert}"/></div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/admin/users/${mode == 'create' ? 'create' : 'edit'}">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label small fw-semibold" for="username">Username</label>
                    <input class="form-control" id="username" name="username" value="<c:out value='${user.username}'/>" ${mode == 'edit' ? 'readonly' : ''} required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold" for="password">Password</label>
                    <input class="form-control" id="password" name="password" value="<c:out value='${user.password}'/>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold" for="fullname">Họ và tên</label>
                    <input class="form-control" id="fullname" name="fullname" value="<c:out value='${user.fullname}'/>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold" for="phone">Số điện thoại</label>
                    <input class="form-control" id="phone" name="phone" value="<c:out value='${user.phone}'/>">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold" for="email">Email</label>
                    <input class="form-control" id="email" type="email" name="email" value="<c:out value='${user.email}'/>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold" for="images">Đường dẫn ảnh đại diện (avatar)</label>
                    <input class="form-control" id="images" name="images" value="<c:out value='${user.images}'/>" placeholder="assets/images/avatars/avatar_01.png">
                </div>
                <div class="col-12 pt-1">
                    <div class="form-check form-check-inline me-4">
                        <input class="form-check-input" type="checkbox" id="adminCheck" name="admin" ${user.admin ? 'checked' : ''}>
                        <label class="form-check-label" for="adminCheck">Quyền Admin</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="activeCheck" name="active" ${user.active ? 'checked' : ''}>
                        <label class="form-check-label" for="activeCheck">Đang hoạt động (Active)</label>
                    </div>
                </div>
                <div class="col-12 pt-3 d-flex gap-2">
                    <button class="btn btn-primary" type="submit">Lưu thông tin</button>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">Quay lại</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
