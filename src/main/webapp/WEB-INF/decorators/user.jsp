<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title">Đề 04 - Châu Minh Phát</sitemesh:write></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/exam04.css" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">ĐỀ 04</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar" aria-controls="userNavbar" aria-expanded="false" aria-label="Mở menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="userNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products"><i class="bi bi-grid me-1"></i>Sản phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/videos"><i class="bi bi-play-circle me-1"></i>Video</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="bi bi-clock-history me-1"></i>Lịch sử đơn</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/exam">Đề thi</a></li>
                <c:if test="${not empty sessionScope.account and sessionScope.account.admin}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/home">Trang quản trị</a></li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item me-2">
                    <a class="nav-link position-relative text-white px-3 py-1 rounded bg-primary-subtle bg-opacity-25" href="${pageContext.request.contextPath}/cart" title="Xem giỏ hàng">
                        <i class="bi bi-cart3 fs-5 align-middle"></i>
                        <span class="ms-1 align-middle d-none d-sm-inline">Giỏ hàng</span>
                        <c:choose>
                            <c:when test="${not empty sessionScope.cart and sessionScope.cart.totalQuantity > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-light">
                                    ${sessionScope.cart.totalQuantity}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary ms-1">0</span>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-1"></i><c:out value="${sessionScope.account.fullname}"/>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders"><i class="bi bi-receipt me-2 text-primary"></i>Đơn hàng của tôi</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart3 me-2 text-success"></i>Giỏ hàng (${not empty sessionScope.cart ? sessionScope.cart.totalQuantity : 0})</a></li>
                                <c:if test="${sessionScope.account.admin}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders"><i class="bi bi-shield-check me-2 text-danger"></i>Quản lý Đơn hàng (Admin)</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home"><i class="bi bi-speedometer2 me-2 text-primary"></i>Trang quản trị</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<main class="main-content py-4">
    <div class="container"><sitemesh:write property="body"/></div>
</main>
<footer class="student-footer py-3 text-center">
    <div class="container small d-flex flex-column flex-md-row justify-content-center gap-md-4">
        <span><strong>Họ tên:</strong> Châu Minh Phát</span>
        <span><strong>MSSV:</strong> 24110294</span>
        <span><strong>Mã đề:</strong> 04</span>
    </div>
</footer>
<div id="appToast" class="app-toast" role="status" aria-live="polite"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
