<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán đơn hàng COD - Đề 04</title>
</head>
<body>
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thanh toán COD</li>
            </ol>
        </nav>
        <h1 class="h3 page-title mb-1"><i class="bi bi-wallet2 text-primary me-2"></i>Thanh toán đơn hàng bằng COD</h1>
        <p class="page-subtitle mb-0">Vui lòng kiểm tra kỹ thông tin người nhận và phương thức thanh toán tiền mặt khi giao hàng (COD).</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-octagon-fill me-2"></i>
            <c:out value="${error}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
        <div class="row g-4">
            <!-- Cột thông tin giao hàng & phương thức thanh toán -->
            <div class="col-lg-7">
                <div class="card exam-card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h2 class="h5 fw-bold mb-0">
                            <i class="bi bi-geo-alt-fill text-primary me-2"></i>1. Thông tin giao hàng
                        </h2>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-3">
                            <label for="receiverName" class="form-label fw-semibold">Họ và tên người nhận <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="receiverName" name="receiverName" 
                                   value="${not empty receiverName ? receiverName : fullname}" required
                                   placeholder="Ví dụ: Nguyễn Văn A">
                        </div>
                        <div class="mb-3">
                            <label for="receiverPhone" class="form-label fw-semibold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone" 
                                   value="${not empty receiverPhone ? receiverPhone : phone}" required
                                   placeholder="Ví dụ: 0901234567">
                        </div>
                        <div class="mb-3">
                            <label for="receiverAddress" class="form-label fw-semibold">Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="receiverAddress" name="receiverAddress" rows="3" required
                                      placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố">${receiverAddress}</textarea>
                        </div>
                        <div class="mb-0">
                            <label for="notes" class="form-label fw-semibold">Ghi chú đơn hàng (nếu có)</label>
                            <input type="text" class="form-control" id="notes" name="notes" value="${notes}"
                                   placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi đến...">
                        </div>
                    </div>
                </div>

                <div class="card exam-card shadow-sm border-0">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h2 class="h5 fw-bold mb-0">
                            <i class="bi bi-credit-card-2-front-fill text-primary me-2"></i>2. Phương thức thanh toán
                        </h2>
                    </div>
                    <div class="card-body p-4">
                        <div class="form-check p-3 rounded-3 border border-primary bg-primary-subtle d-flex align-items-center gap-3">
                            <input class="form-check-input fs-5 ms-0 mt-0" type="radio" name="paymentMethod" id="paymentCOD" value="COD" checked>
                            <label class="form-check-label w-100 cursor-pointer" for="paymentCOD">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-primary">
                                        <i class="bi bi-cash-stack me-1"></i> Thanh toán khi nhận hàng (COD)
                                    </span>
                                    <span class="badge bg-primary">Khuyên dùng</span>
                                </div>
                                <div class="small text-secondary mt-1">
                                    Bạn sẽ thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi nhận được kiện hàng.
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cột tóm tắt đơn hàng -->
            <div class="col-lg-5">
                <div class="card exam-card shadow-sm border-0 sticky-top" style="top: 85px;">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h2 class="h5 fw-bold mb-0">
                            <i class="bi bi-bag-check-fill text-primary me-2"></i>Kiện hàng của bạn (${cart.totalQuantity} sản phẩm)
                        </h2>
                    </div>
                    <div class="card-body p-4">
                        <div class="order-items-list mb-3" style="max-height: 280px; overflow-y: auto;">
                            <c:forEach items="${cart.items}" var="item">
                                <div class="d-flex align-items-center gap-3 py-2 border-bottom">
                                    <img src="${item.product.image}" alt="${item.product.productName}" 
                                         class="rounded border bg-light" 
                                         style="width: 52px; height: 52px; object-fit: cover;"
                                         onerror="this.src='https://placehold.co/80x80?text=No+Img';">
                                    <div class="flex-grow-1">
                                        <div class="fw-semibold text-truncate small" style="max-width: 190px;" title="${item.product.productName}">
                                            <c:out value="${item.product.productName}"/>
                                        </div>
                                        <div class="text-muted small">
                                            SL: <strong>x${item.quantity}</strong> &times; 
                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </div>
                                    </div>
                                    <div class="text-end fw-bold text-danger small">
                                        <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Tạm tính:</span>
                            <span class="fw-semibold">
                                <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                            <span class="text-secondary">Phí giao hàng:</span>
                            <span class="text-success fw-bold">Miễn phí (COD)</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="h6 fw-bold mb-0">Tổng thanh toán:</span>
                            <span class="h4 fw-bold text-danger mb-0">
                                <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 py-3 fw-bold shadow-sm">
                            <i class="bi bi-check-circle-fill me-2"></i> Xác nhận đặt hàng (COD)
                        </button>
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none small text-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Quay lại sửa giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
