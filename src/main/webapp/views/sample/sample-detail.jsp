<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Sample #${sample.id} - Exam Starter Kit</title>
</head>
<body>
    <div class="container my-4" style="max-width: 750px;">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="card-title mb-0 fw-bold">
                    <i class="bi bi-info-circle me-2"></i>Chi tiết bản ghi #${sample.id}
                </h4>
                <c:choose>
                    <c:when test="${sample.status == 1}">
                        <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger"><i class="bi bi-lock me-1"></i>Khóa</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="card-body p-4">
                <table class="table table-bordered mb-4">
                    <tbody>
                        <tr>
                            <th class="bg-light text-secondary" style="width: 25%;">ID</th>
                            <td class="fw-bold text-dark">#${sample.id}</td>
                        </tr>
                        <tr>
                            <th class="bg-light text-secondary">Tên Sample</th>
                            <td class="fw-bold text-primary fs-5">${sample.name}</td>
                        </tr>
                        <tr>
                            <th class="bg-light text-secondary">Danh mục</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty sample.category}">
                                        <span class="badge bg-info text-dark">
                                            <i class="bi bi-tag-fill me-1"></i>${sample.category.categoryname}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Không có</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light text-secondary">Trạng thái</th>
                            <td>
                                <c:choose>
                                    <c:when test="${sample.status == 1}">
                                        <span class="text-success fw-semibold"><i class="bi bi-check-circle me-1"></i>Đang hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger fw-semibold"><i class="bi bi-lock me-1"></i>Đang bị khóa</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light text-secondary">Mô tả chi tiết</th>
                            <td>
                                <p class="mb-0 text-muted" style="white-space: pre-wrap;">${empty sample.description ? '<em>(Không có mô tả)</em>' : sample.description}</p>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="d-flex justify-content-between border-top pt-3">
                    <a href="${pageContext.request.contextPath}/sample?action=list" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/sample?action=edit&id=${sample.id}" class="btn btn-warning">
                            <i class="bi bi-pencil-square me-1"></i>Chỉnh sửa
                        </a>
                        <a href="${pageContext.request.contextPath}/sample?action=delete&id=${sample.id}" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa bản ghi này?');">
                            <i class="bi bi-trash me-1"></i>Xóa
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
