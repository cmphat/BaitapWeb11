<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><title>Quản lý Users - Đề 04</title></head><body>
<div class="d-flex flex-wrap justify-content-between align-items-end gap-2 mb-4">
    <div><h1 class="h3 page-title">Quản lý người dùng</h1><span class="text-muted">Tổng số ${totalUsers} người dùng - 6 người dùng/trang</span></div>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/users/create">Thêm người dùng</a>
</div>
<c:if test="${param.msg == 'saved'}"><div class="alert alert-success">Lưu người dùng thành công.</div></c:if>
<c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Xóa người dùng thành công.</div></c:if>
<c:if test="${param.error == 'delete'}"><div class="alert alert-danger">Không thể xóa vì người dùng có dữ liệu liên quan.</div></c:if>
<div class="table-responsive card exam-card"><table class="table table-hover mb-0">
    <thead class="table-light"><tr><th>Người dùng</th><th>Email</th><th>Vai trò</th><th>Trạng thái</th><th class="text-end">Thao tác</th></tr></thead>
    <tbody><c:forEach items="${users}" var="user"><tr>
        <td><div class="d-flex align-items-center gap-2"><c:choose><c:when test="${not empty user.images}"><img class="avatar-sm" src="${pageContext.request.contextPath}/${user.images}" alt="Ảnh ${user.fullname}"></c:when><c:otherwise><span class="avatar-sm bg-light d-inline-flex align-items-center justify-content-center"><i class="bi bi-person"></i></span></c:otherwise></c:choose><div><strong><c:out value="${user.fullname}"/></strong><div class="small text-muted"><c:out value="${user.username}"/></div></div></div></td>
        <td><c:out value="${user.email}"/></td>
        <td><span class="badge ${user.admin ? 'text-bg-dark' : 'text-bg-secondary'}">${user.admin ? 'Admin' : 'User'}</span></td>
        <td><span class="badge ${user.active ? 'text-bg-success' : 'text-bg-warning'}">${user.active ? 'Đã kích hoạt' : 'Chưa kích hoạt'}</span></td>
        <td class="text-end text-nowrap"><a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/admin/users/detail?username=${user.username}">Chi tiết</a> <a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/admin/users/edit?username=${user.username}">Sửa</a> <a class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')" href="${pageContext.request.contextPath}/admin/users/delete?username=${user.username}">Xóa</a></td>
    </tr></c:forEach></tbody>
</table></div>
<nav class="mt-4" aria-label="Phân trang người dùng"><ul class="pagination justify-content-center">
    <li class="page-item ${page == 1 ? 'disabled' : ''}"><a class="page-link" href="?page=${page - 1}">Trước</a></li>
    <c:forEach begin="1" end="${totalPages}" var="pageNumber"><li class="page-item ${pageNumber == page ? 'active' : ''}"><a class="page-link" href="?page=${pageNumber}">${pageNumber}</a></li></c:forEach>
    <li class="page-item ${page == totalPages ? 'disabled' : ''}"><a class="page-link" href="?page=${page + 1}">Sau</a></li>
</ul></nav>
</body></html>

