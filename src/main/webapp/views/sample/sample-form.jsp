<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle} - Exam Starter Kit</title>
</head>
<body>
    <div class="container my-4" style="max-width: 750px;">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white py-3">
                <h4 class="card-title mb-0 fw-bold">
                    <i class="bi bi-${formAction == 'add' ? 'plus-circle' : 'pencil-square'} me-2"></i>${pageTitle}
                </h4>
            </div>
            <div class="card-body p-4">
                <!-- Validation Error Alert -->
                <c:if test="${not empty validationError}">
                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                        <i class="bi bi-exclamation-octagon-fill me-2"></i><strong>Lỗi dữ liệu:</strong> ${validationError}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/sample" method="post" class="needs-validation">
                    <input type="hidden" name="action" value="${formAction}">
                    <c:if test="${formAction == 'edit'}">
                        <input type="hidden" name="id" value="${sample.id}">
                    </c:if>

                    <!-- ID (Readonly on Edit) -->
                    <c:if test="${formAction == 'edit'}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted">ID</label>
                            <input type="text" class="form-control bg-light" value="#${sample.id}" readonly>
                        </div>
                    </c:if>

                    <!-- Name Field -->
                    <div class="mb-3">
                        <label for="name" class="form-label fw-semibold">
                            Tên Sample <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="name" name="name" 
                               placeholder="Nhập tên..." 
                               value="${not empty retainedName ? retainedName : sample.name}" required>
                        <div class="form-text">Bắt buộc nhập, không được để trống.</div>
                    </div>

                    <!-- Category Select (1-N Relation) -->
                    <div class="mb-3">
                        <label for="category_id" class="form-label fw-semibold">Danh mục (Category)</label>
                        <select class="form-select" id="category_id" name="category_id">
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="c" items="${categories}">
                                <c:set var="isCurrentCat" value="${(not empty sample.category && sample.category.categoryid == c.categoryid) || (not empty retainedCategoryId && retainedCategoryId == c.categoryid)}" />
                                <option value="${c.categoryid}" ${isCurrentCat ? 'selected' : ''}>
                                    ${c.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Description Field -->
                    <div class="mb-3">
                        <label for="description" class="form-label fw-semibold">Mô tả</label>
                        <textarea class="form-control" id="description" name="description" rows="4" 
                                  placeholder="Nhập thông tin mô tả chi tiết...">${not empty retainedDescription ? retainedDescription : sample.description}</textarea>
                    </div>

                    <!-- Status Field (Radio Buttons) -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold d-block">Trạng thái</label>
                        <c:set var="currentStatus" value="${not empty retainedStatus ? retainedStatus : (not empty sample ? sample.status : 1)}" />
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" ${currentStatus == 1 ? 'checked' : ''}>
                            <label class="form-check-label text-success fw-semibold" for="statusActive">
                                <i class="bi bi-check-circle me-1"></i>Hoạt động
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0" ${currentStatus == 0 ? 'checked' : ''}>
                            <label class="form-check-label text-danger fw-semibold" for="statusInactive">
                                <i class="bi bi-lock me-1"></i>Khóa / Tạm dừng
                            </label>
                        </div>
                    </div>

                    <!-- Form Buttons -->
                    <div class="d-flex justify-content-end gap-2 border-top pt-3">
                        <a href="${pageContext.request.contextPath}/sample?action=list" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-1"></i>Hủy bỏ
                        </a>
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-save me-1"></i>Lưu thông tin
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
