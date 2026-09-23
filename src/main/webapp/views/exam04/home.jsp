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
                <span class="badge text-bg-primary mb-3">BÀI THI WEB - ĐỀ 04</span>
                <h1 class="display-6 fw-bold mb-3">Website quản lý video</h1>
                <p class="lead text-secondary">Ứng dụng Servlet, JSP/JSTL, JDBC, SQL Server, SiteMesh, Session và OTP Email.</p>
                <div class="d-flex flex-wrap gap-2 mt-4">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/videos">Xem danh sách video</a>
                    <c:if test="${empty sessionScope.account}">
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <img class="w-100 h-100" style="min-height:280px;object-fit:cover" src="${pageContext.request.contextPath}/assets/images/categories/category_technology.jpg" alt="Công nghệ - Đề 04">
        </div>
    </div>
</section>
<div class="row g-3">
    <div class="col-md-4"><div class="card h-100"><div class="card-body"><h2 class="h5">JDBC thuần</h2><p class="text-secondary mb-0">Các chức năng bài thi truy xuất SQL Server qua DAO và PreparedStatement.</p></div></div></div>
    <div class="col-md-4"><div class="card h-100"><div class="card-body"><h2 class="h5">Phân trang rõ ràng</h2><p class="text-secondary mb-0">Video 3 dòng/trang và Users 6 dòng/trang bằng OFFSET/FETCH.</p></div></div></div>
    <div class="col-md-4"><div class="card h-100"><div class="card-body"><h2 class="h5">Thông tin sinh viên</h2><p class="mb-1">Châu Minh Phát</p><p class="text-secondary mb-0">24110294 - Đề 04</p></div></div></div>
</div>
</body>
</html>

