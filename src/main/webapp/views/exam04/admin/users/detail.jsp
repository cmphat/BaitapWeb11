<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><title>Chi tiết User - Đề 04</title></head><body>
<div class="card exam-card"><div class="card-body p-4">
    <div class="d-flex align-items-center gap-3 mb-4">
        <c:if test="${not empty user.images}"><img class="rounded-circle border" style="width:72px;height:72px;object-fit:cover" src="${pageContext.request.contextPath}/${user.images}" alt="Ảnh ${user.fullname}"></c:if>
        <div><h1 class="h3 mb-1"><c:out value="${user.fullname}"/></h1><span class="text-muted">@<c:out value="${user.username}"/></span></div>
    </div>
    <dl class="row mb-4"><dt class="col-sm-3">Email</dt><dd class="col-sm-9"><c:out value="${user.email}"/></dd><dt class="col-sm-3">Điện thoại</dt><dd class="col-sm-9"><c:out value="${user.phone}"/></dd><dt class="col-sm-3">Vai trò</dt><dd class="col-sm-9">${user.admin ? 'Admin' : 'User'}</dd><dt class="col-sm-3">Trạng thái</dt><dd class="col-sm-9">${user.active ? 'Đã kích hoạt' : 'Chưa kích hoạt'}</dd></dl>
    <a class="btn btn-warning" href="${pageContext.request.contextPath}/admin/users/edit?username=${user.username}">Cập nhật</a>
    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">Quay lại</a>
</div></div>
</body></html>
