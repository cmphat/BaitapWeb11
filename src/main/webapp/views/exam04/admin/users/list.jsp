<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Users - Đề 04</title>
</head>
<body>
<div class="d-flex flex-wrap justify-content-between align-items-end gap-2 mb-4">
    <div>
        <h1 class="h3 page-title">Quản lý người dùng</h1>
        <span class="text-muted">Tổng số ${totalUsers} người dùng &bull; 6 người dùng/trang</span>
    </div>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/users/create">
        <i class="bi bi-person-plus me-1"></i> Thêm người dùng
    </a>
</div>

<c:if test="${param.msg == 'saved'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Lưu thông tin người dùng thành công.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Xóa người dùng thành công.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${param.error == 'delete'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Không thể xóa vì người dùng có dữ liệu liên quan.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<div class="card exam-card overflow-hidden">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th scope="col" style="width: 70px;">Avatar</th>
                    <th scope="col">Username</th>
                    <th scope="col">Fullname</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Admin</th>
                    <th scope="col">Active</th>
                    <th scope="col" class="text-end" style="min-width: 170px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${not empty user.images}">
                                    <img class="avatar-img" src="${pageContext.request.contextPath}/${user.images}" alt="Avatar ${user.username}">
                                </c:when>
                                <c:otherwise>
                                    <span class="avatar-placeholder"><i class="bi bi-person"></i></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><strong><c:out value="${user.username}"/></strong></td>
                        <td><c:out value="${user.fullname}"/></td>
                        <td><c:out value="${user.email}"/></td>
                        <td><c:out value="${user.phone}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${user.admin}">
                                    <span class="badge text-bg-primary">Admin</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge text-bg-secondary">User</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.active}">
                                    <span class="badge text-bg-success">Đang hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge text-bg-warning text-dark">Chưa kích hoạt</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end text-nowrap">
                            <a class="btn btn-sm btn-outline-primary me-1" href="${pageContext.request.contextPath}/admin/users/detail?username=${user.username}">Xem</a>
                            <a class="btn btn-sm btn-outline-warning me-1" href="${pageContext.request.contextPath}/admin/users/edit?username=${user.username}">Sửa</a>
                            <a class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')" href="${pageContext.request.contextPath}/admin/users/delete?username=${user.username}">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<c:if test="${totalPages > 1}">
    <nav class="mt-4" aria-label="Phân trang người dùng">
        <ul class="pagination justify-content-center">
            <li class="page-item ${page == 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${page - 1}">Previous</a>
            </li>
            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                <li class="page-item ${pageNumber == page ? 'active' : ''}">
                    <a class="page-link" href="?page=${pageNumber}">${pageNumber}</a>
                </li>
            </c:forEach>
            <li class="page-item ${page == totalPages ? 'disabled' : ''}">
                <a class="page-link" href="?page=${page + 1}">Next</a>
            </li>
        </ul>
    </nav>
</c:if>
</body>
</html>
