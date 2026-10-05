<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn - Đề 04</title>
</head>
<body>
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
            </ol>
        </nav>
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h1 class="h3 page-title mb-1"><i class="bi bi-cart3 text-primary me-2"></i>Giỏ hàng của bạn</h1>
                <p class="page-subtitle mb-0">Quản lý các sản phẩm đã chọn, điều chỉnh số lượng hoặc tiến hành thanh toán COD.</p>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Tiếp tục mua sắm
            </a>
        </div>
    </div>

    <!-- Thông báo phản hồi -->
    <c:if test="${not empty sessionScope.cartSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            <c:out value="${sessionScope.cartSuccess}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="cartSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.cartAlert}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:out value="${sessionScope.cartAlert}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="cartAlert" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${empty cart or empty cart.items}">
            <div class="card exam-card text-center p-5 my-4">
                <div class="py-4">
                    <i class="bi bi-cart-x text-muted" style="font-size: 5rem;"></i>
                    <h3 class="h4 mt-3 mb-2">Giỏ hàng của bạn đang trống!</h3>
                    <p class="text-secondary mb-4">Hãy khám phá danh mục sản phẩm và chọn mua các thiết bị ưng ý.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary px-4 py-2">
                        <i class="bi bi-bag-plus me-1"></i> Xem danh sách sản phẩm
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <!-- Danh sách sản phẩm trong giỏ -->
                <div class="col-lg-8">
                    <div class="card exam-card shadow-sm border-0">
                        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                            <span class="fw-bold"><i class="bi bi-box-seam me-1 text-primary"></i> Danh sách mặt hàng (${cart.itemCount})</span>
                            <a href="${pageContext.request.contextPath}/cart/clear" 
                               class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                                <i class="bi bi-trash3 me-1"></i> Xóa toàn bộ
                            </a>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col" style="min-width: 220px;">Sản phẩm</th>
                                        <th scope="col" class="text-center">Đơn giá</th>
                                        <th scope="col" class="text-center" style="width: 170px;">Số lượng</th>
                                        <th scope="col" class="text-end">Thành tiền</th>
                                        <th scope="col" class="text-center" style="width: 60px;">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cart.items}" var="item">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center gap-3">
                                                    <img src="${item.product.image}" alt="${item.product.productName}" 
                                                         class="rounded border bg-light" 
                                                         style="width: 64px; height: 64px; object-fit: cover;"
                                                         onerror="this.src='https://placehold.co/100x100?text=No+Img';">
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/product/detail?id=${item.product.productId}" 
                                                           class="fw-bold text-decoration-none text-dark d-block">
                                                            <c:out value="${item.product.productName}"/>
                                                        </a>
                                                        <small class="text-muted d-block">Mã: #${item.product.productId}</small>
                                                        <small class="text-info d-block">
                                                            Tồn kho: ${item.product.quantity > 0 ? item.product.quantity : 10}
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center fw-semibold text-secondary">
                                                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td>
                                                <!-- Form cập nhật số lượng trong giới hạn -->
                                                <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex align-items-center justify-content-center gap-1">
                                                    <input type="hidden" name="productId" value="${item.product.productId}"/>
                                                    <button type="submit" name="quantity" value="${item.quantity - 1}" 
                                                            class="btn btn-sm btn-outline-secondary px-2 py-1" 
                                                            title="Giảm 1" ${item.quantity <= 1 ? 'onclick="return confirm(\'Xóa sản phẩm này khỏi giỏ hàng?\')"' : ''}>
                                                        <i class="bi bi-dash"></i>
                                                    </button>
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" 
                                                           max="${item.product.quantity > 0 ? item.product.quantity : 10}" 
                                                           class="form-control form-control-sm text-center px-1" 
                                                           style="width: 52px;"
                                                           onchange="this.form.submit();"
                                                           title="Nhập số lượng từ 1 đến ${item.product.quantity > 0 ? item.product.quantity : 10}">
                                                    <button type="submit" name="quantity" value="${item.quantity + 1}" 
                                                            class="btn btn-sm btn-outline-secondary px-2 py-1" 
                                                            title="Tăng 1"
                                                            ${item.quantity >= (item.product.quantity > 0 ? item.product.quantity : 10) ? 'disabled' : ''}>
                                                        <i class="bi bi-plus"></i>
                                                    </button>
                                                </form>
                                                <div class="text-center mt-1">
                                                    <small class="text-muted" style="font-size: 0.72rem;">Giới hạn: 1 - ${item.product.quantity > 0 ? item.product.quantity : 10}</small>
                                                </div>
                                            </td>
                                            <td class="text-end fw-bold text-danger">
                                                <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/cart/remove?productId=${item.product.productId}" 
                                                   class="btn btn-sm btn-link text-danger p-0" 
                                                   title="Xóa sản phẩm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ?');">
                                                    <i class="bi bi-trash fs-5"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Tóm tắt đơn hàng và thanh toán COD -->
                <div class="col-lg-4">
                    <div class="card exam-card shadow-sm border-0 sticky-top" style="top: 85px;">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h2 class="h5 fw-bold mb-0"><i class="bi bi-receipt me-1 text-primary"></i> Tóm tắt đơn hàng</h2>
                        </div>
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-secondary">Tổng số lượng:</span>
                                <span class="fw-bold">${cart.totalQuantity} món</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-secondary">Tạm tính:</span>
                                <span class="fw-bold">
                                    <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                                <span class="text-secondary">Phí vận chuyển:</span>
                                <span class="text-success fw-bold">Miễn phí</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="h6 fw-bold mb-0">Tổng thanh toán:</span>
                                <span class="h4 fw-bold text-danger mb-0">
                                    <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </div>

                            <div class="p-3 bg-light rounded-3 border mb-3">
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <i class="bi bi-cash-coin text-success fs-5"></i>
                                    <strong class="small">Thanh toán khi nhận hàng (COD)</strong>
                                </div>
                                <p class="small text-muted mb-0">
                                    Thanh toán tiền mặt cho shipper ngay khi nhận và kiểm tra hàng.
                                </p>
                            </div>

                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg w-100 py-3 fw-bold shadow-sm">
                                <i class="bi bi-shield-check me-2"></i> Tiến hành thanh toán COD
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
