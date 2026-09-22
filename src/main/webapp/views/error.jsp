<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông báo lỗi - Exam Starter Kit</title>
</head>
<body>
    <div class="container my-5 text-center" style="max-width: 600px;">
        <div class="card shadow border-0 py-4 px-3">
            <div class="card-body">
                <div class="text-danger mb-3">
                    <i class="bi bi-exclamation-triangle-fill" style="font-size: 4rem;"></i>
                </div>
                <h3 class="fw-bold text-danger mb-2">Đã xảy ra sự cố!</h3>
                <p class="text-muted mb-4">
                    <c:choose>
                        <c:when test="${not empty errorMessage}">
                            ${errorMessage}
                        </c:when>
                        <c:otherwise>
                            Yêu cầu không thể hoàn tất hoặc dữ liệu không hợp lệ.
                        </c:otherwise>
                    </c:choose>
                </p>
                <div class="d-flex justify-content-center gap-2">
                    <a href="javascript:history.back()" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-1"></i>Quay lại
                    </a>
                    <a href="${pageContext.request.contextPath}/sample?action=list" class="btn btn-primary">
                        <i class="bi bi-box-seam me-1"></i>Về trang danh sách
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary">
                        <i class="bi bi-house me-1"></i>Trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
