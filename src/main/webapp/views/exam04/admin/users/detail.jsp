<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết người dùng - Đề 04</title>
</head>
<body>
<div class="mb-3">
    <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/admin/users">
        <i class="bi bi-arrow-left"></i> Quay lại danh sách
    </a>
</div>

<div class="card exam-card">
    <div class="card-body p-4">
        <div class="d-flex align-items-center gap-3 mb-4">
            <c:choose>
                <c:when test="${not empty user.images}">
                    <img class="rounded-circle border" style="width:64px;height:64px;object-fit:cover" src="${pageContext.request.contextPath}/${user.images}" alt="Ảnh ${user.fullname}">
                </c:when>
                <c:otherwise>
                    <span class="rounded-circle bg-light border d-inline-flex align-items-center justify-content-center" style="width:64px;height:64px;font-size:1.8rem;color:#6c757d">
                        <i class="bi bi-person"></i>
                    </span>
                </c:otherwise>
            </c:choose>
            <div>
                <h1 class="h3 page-title mb-1"><c:out value="${user.fullname}"/></h1>
                <span class="text-muted">Username: <strong><c:out value="${user.username}"/></strong></span>
            </div>
        </div>

        <dl class="row mb-4 border-top pt-3">
            <dt class="col-sm-3 text-secondary">Email</dt>
            <dd class="col-sm-9"><c:out value="${user.email}"/></dd>

            <dt class="col-sm-3 text-secondary">Điện thoại</dt>
            <dd class="col-sm-9"><c:out value="${user.phone}"/></dd>

            <dt class="col-sm-3 text-secondary">Vai trò</dt>
            <dd class="col-sm-9">
                <c:choose>
                    <c:when test="${user.admin}">
                        <span class="badge text-bg-primary">Admin</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge text-bg-secondary">User</span>
                    </c:otherwise>
                </c:choose>
            </dd>

            <dt class="col-sm-3 text-secondary">Trạng thái</dt>
            <dd class="col-sm-9">
                <c:choose>
                    <c:when test="${user.active}">
                        <span class="badge text-bg-success">Đang hoạt động</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge text-bg-warning text-dark">Chưa kích hoạt</span>
                    </c:otherwise>
                </c:choose>
            </dd>
        </dl>

        <div class="d-flex gap-2">
            <a class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/admin/users/edit?username=${user.username}">
                <i class="bi bi-pencil-square me-1"></i> Cập nhật
            </a>
            <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/admin/users">Quay lại</a>
        </div>
    </div>
</div>
</body>
</html>
