<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang quản trị - Đề 04</title>
</head>
<body>
<div class="mb-4">
    <h1 class="h3 page-title">Trang quản trị</h1>
    <p class="page-subtitle">Quản lý dữ liệu người dùng và kiểm tra các chức năng của bài thi.</p>
</div>
<div class="row g-4">
    <div class="col-md-6 col-xl-4">
        <div class="card exam-card h-100"><div class="card-body p-4">
            <h2 class="h5">Quản lý người dùng</h2>
            <p class="text-secondary">Thêm, xem chi tiết, cập nhật, xóa và phân trang 6 người dùng mỗi trang.</p>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/users">Mở quản lý Users</a>
        </div></div>
    </div>
    <div class="col-md-6 col-xl-4">
        <div class="card exam-card h-100"><div class="card-body p-4">
            <h2 class="h5">Danh sách video</h2>
            <p class="text-secondary">Kiểm tra video theo danh mục, số lượt thích, chia sẻ và phân trang.</p>
            <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/videos">Xem video</a>
        </div></div>
    </div>
    <div class="col-md-12 col-xl-4">
        <div class="card exam-card h-100"><div class="card-body p-4">
            <h2 class="h5">Thông tin bài thi</h2>
            <dl class="row mb-0"><dt class="col-5">Họ tên</dt><dd class="col-7">Châu Minh Phát</dd><dt class="col-5">MSSV</dt><dd class="col-7">24110294</dd><dt class="col-5">Mã đề</dt><dd class="col-7 mb-0">04</dd></dl>
        </div></div>
    </div>
</div>
</body>
</html>
