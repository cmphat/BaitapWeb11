<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Đề 04</title>
</head>
<body>
<section class="card exam-card overflow-hidden mb-4">
    <div class="row g-0 align-items-stretch">
        <div class="col-lg-7">
            <div class="card-body p-4 p-lg-5">
                <span class="badge text-bg-primary mb-2">BÀI THI THỰC HÀNH - ĐỀ 04</span>
                <h1 class="h3 page-title mb-2">Hệ thống quản lý và xem video</h1>
                <p class="text-secondary mb-4">Ứng dụng Jakarta EE với mô hình MVC 3 lớp, Servlet, JSP/JSTL, JDBC SQL Server, SiteMesh, Session và xác thực OTP.</p>
                <div class="d-flex flex-wrap gap-2">
                    <a class="btn btn-primary btn-sm px-3" href="${pageContext.request.contextPath}/products">
                        <i class="bi bi-grid me-1"></i> Danh sách sản phẩm
                    </a>
                    <a class="btn btn-outline-primary btn-sm px-3" href="${pageContext.request.contextPath}/cart">
                        <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                    </a>
                    <a class="btn btn-outline-secondary btn-sm px-3" href="${pageContext.request.contextPath}/orders">
                        <i class="bi bi-clock-history me-1"></i> Lịch sử đơn hàng
                    </a>
                    <a class="btn btn-outline-dark btn-sm px-3" href="${pageContext.request.contextPath}/videos">
                        <i class="bi bi-play-circle me-1"></i> Video bài học
                    </a>
                    <c:if test="${empty sessionScope.account}">
                        <a class="btn btn-outline-secondary btn-sm px-3" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.account and sessionScope.account.admin}">
                        <a class="btn btn-outline-danger btn-sm px-3" href="${pageContext.request.contextPath}/admin/orders">Quản lý Đơn hàng</a>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <img class="w-100 h-100" style="min-height:240px;object-fit:cover" src="${pageContext.request.contextPath}/assets/images/categories/category_technology.jpg" alt="Lập trình Web">
        </div>
    </div>
</section>

<div class="row g-3">
    <div class="col-md-4">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <h2 class="h6 fw-bold mb-2"><i class="bi bi-database text-primary me-2"></i>Mô hình MVC & JDBC</h2>
                <p class="text-secondary small mb-0">Truy xuất CSDL SQL Server thông qua DAO Pattern, PreparedStatement và kết nối độc lập.</p>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <h2 class="h6 fw-bold mb-2"><i class="bi bi-grid-3x3-gap text-primary me-2"></i>Phân trang dữ liệu</h2>
                <p class="text-secondary small mb-0">Phân trang 3 video mỗi trang và 6 người dùng mỗi trang bằng ORDER BY, OFFSET và FETCH NEXT.</p>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <h2 class="h6 fw-bold mb-2"><i class="bi bi-person-badge text-primary me-2"></i>Thông tin sinh viên</h2>
                <p class="small mb-1"><strong>Họ và tên:</strong> Châu Minh Phát</p>
                <p class="small text-secondary mb-0"><strong>MSSV:</strong> 24110294 &bull; <strong>Đề:</strong> 04</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
