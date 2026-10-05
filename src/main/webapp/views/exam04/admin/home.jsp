<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang quản trị - Đề 04</title>
</head>
<body>
<div class="mb-4">
    <h1 class="h3 page-title">Xin chào Admin</h1>
    <p class="page-subtitle">Bảng điều khiển quản trị hệ thống Đề 04</p>
</div>

<div class="row g-3 mb-4 animate-in">
    <div class="col-md-6 col-xl-3">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-people-fill text-primary fs-4 me-2"></i>
                    <h2 class="h5 mb-0">Quản lý Users</h2>
                </div>
                <p class="text-secondary small mb-3">Xem danh sách, thêm, sửa, xóa người dùng và phân trang 6 user/trang.</p>
                <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/admin/users">Quản lý Users</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-collection-play-fill text-primary fs-4 me-2"></i>
                    <h2 class="h5 mb-0">Danh sách Videos</h2>
                </div>
                <p class="text-secondary small mb-3">Xem các video theo danh mục, số lượt thích, chia sẻ và phát video local.</p>
                <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/videos">Danh sách Videos</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-tags-fill text-primary fs-4 me-2"></i>
                    <h2 class="h5 mb-0">Danh mục</h2>
                </div>
                <p class="text-secondary small mb-3">Các danh mục video gồm Lập trình Web, Cơ sở dữ liệu, Kỹ năng mềm, Java.</p>
                <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/videos">Xem danh mục</a>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card exam-card h-100">
            <div class="card-body p-3 p-lg-4">
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-bar-chart-fill text-primary fs-4 me-2"></i>
                    <h2 class="h5 mb-0">Phân tích dữ liệu</h2>
                </div>
                <p class="text-secondary small mb-3">Theo dõi lượt xem, thích, chia sẻ và lịch sử thao tác của người dùng.</p>
                <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/admin/analytics">Mở phân tích</a>
            </div>
        </div>
    </div>
</div>

<div class="card exam-card">
    <div class="card-body p-3 p-lg-4">
        <h2 class="h6 fw-bold mb-3">Thông tin sinh viên thực hiện</h2>
        <div class="row g-2 text-secondary small">
            <div class="col-sm-4"><strong>Họ và tên:</strong> Châu Minh Phát</div>
            <div class="col-sm-4"><strong>MSSV:</strong> 24110294</div>
            <div class="col-sm-4"><strong>Mã đề:</strong> 04</div>
        </div>
    </div>
</div>
</body>
</html>
