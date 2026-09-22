<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Sample - Exam Starter Kit</title>
</head>
<body>
    <div class="container my-4">
        <!-- Header & Action Buttons -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom flex-wrap gap-2">
            <div>
                <h2 class="fw-bold mb-0 text-primary">
                    <i class="bi bi-box-seam me-2"></i>Quản lý Sample
                </h2>
                <small class="text-muted">Exam Starter Kit - Servlet / JSP / JPA CRUD</small>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/sample?action=add" class="btn btn-primary shadow-sm">
                    <i class="bi bi-plus-lg me-1"></i>Thêm mới
                </a>
                <a href="${pageContext.request.contextPath}/sample?action=list" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-clockwise me-1"></i>Làm mới
                </a>
            </div>
        </div>

        <!-- Thông báo Alert (Flash messages) -->
        <c:if test="${param.msg == 'add_success'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>Thêm mới bản ghi thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'update_success'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>Cập nhật bản ghi thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'delete_success'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-trash-fill me-2"></i>Xóa bản ghi thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>Lỗi: <c:out value="${param.error}" />
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Search & Filter Card -->
        <div class="card shadow-sm mb-4 border-0 bg-light">
            <div class="card-body">
                <div class="row g-3">
                    <!-- Search Form -->
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/sample" method="get" class="d-flex gap-2">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm theo tên hoặc mô tả..." value="${keyword}">
                            <button type="submit" class="btn btn-dark">
                                <i class="bi bi-search"></i>
                            </button>
                            <c:if test="${not empty keyword}">
                                <a href="${pageContext.request.contextPath}/sample?action=list" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-lg"></i>
                                </a>
                            </c:if>
                        </form>
                    </div>

                    <!-- Filter by Category -->
                    <div class="col-md-3">
                        <form action="${pageContext.request.contextPath}/sample" method="get" id="filterCatForm">
                            <input type="hidden" name="action" value="filter">
                            <select name="category_id" class="form-select" onchange="document.getElementById('filterCatForm').submit()">
                                <option value="">-- Lọc theo danh mục --</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryid}" ${selectedCategoryId == c.categoryid ? 'selected' : ''}>
                                        ${c.categoryname}
                                    </option>
                                </c:forEach>
                            </select>
                        </form>
                    </div>

                    <!-- Filter by Status -->
                    <div class="col-md-3">
                        <form action="${pageContext.request.contextPath}/sample" method="get" id="filterStatusForm">
                            <input type="hidden" name="action" value="filter">
                            <select name="status" class="form-select" onchange="document.getElementById('filterStatusForm').submit()">
                                <option value="">-- Lọc theo trạng thái --</option>
                                <option value="1" ${selectedStatus == 1 ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${selectedStatus == 0 ? 'selected' : ''}>Khóa</option>
                            </select>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Data -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${empty samples}">
                        <div class="text-center py-5">
                            <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                            <h5 class="mt-3 text-muted">Không có dữ liệu hiển thị</h5>
                            <p class="text-muted small">Hãy thêm mới hoặc chọn tiêu chí tìm kiếm khác.</p>
                            <a href="${pageContext.request.contextPath}/sample?action=add" class="btn btn-sm btn-primary">
                                <i class="bi bi-plus-lg me-1"></i>Thêm dữ liệu ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th style="width: 70px;" class="text-center">ID</th>
                                        <th>Tên Sample</th>
                                        <th>Danh mục</th>
                                        <th>Mô tả</th>
                                        <th style="width: 130px;" class="text-center">Trạng thái</th>
                                        <th style="width: 220px;" class="text-center">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="s" items="${samples}">
                                        <tr>
                                            <td class="text-center fw-semibold text-secondary">#${s.id}</td>
                                            <td class="fw-bold text-dark">
                                                <a href="${pageContext.request.contextPath}/sample?action=detail&id=${s.id}" class="text-decoration-none text-primary">
                                                    ${s.name}
                                                </a>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty s.category}">
                                                        <span class="badge bg-info text-dark">
                                                            <i class="bi bi-tag-fill me-1"></i>${s.category.categoryname}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Không có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-muted small" style="max-width: 300px;">
                                                ${empty s.description ? '<em>(Chưa có mô tả)</em>' : s.description}
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${s.status == 1}">
                                                        <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger"><i class="bi bi-lock me-1"></i>Khóa</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <a href="${pageContext.request.contextPath}/sample?action=detail&id=${s.id}" class="btn btn-outline-info" title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/sample?action=edit&id=${s.id}" class="btn btn-outline-warning" title="Chỉnh sửa">
                                                        <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/sample?action=delete&id=${s.id}" class="btn btn-outline-danger" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa bản ghi này không?');">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination Footer -->
            <c:if test="${totalPages > 1}">
                <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                    <span class="text-muted small">
                        Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (Tổng cộng: ${totalItems} mục)
                    </span>
                    <nav>
                        <ul class="pagination pagination-sm mb-0">
                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/sample?action=list&page=${currentPage - 1}">Trước</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/sample?action=list&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/sample?action=list&page=${currentPage + 1}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
