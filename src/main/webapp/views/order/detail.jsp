<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #ORD-${order.orderId} - Đề 04</title>
</head>
<body>
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/orders">Lịch sử đơn hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết #ORD-${order.orderId}</li>
            </ol>
        </nav>
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h1 class="h3 page-title mb-1">
                    <i class="bi bi-receipt text-primary me-2"></i>Chi tiết đơn hàng #ORD-${order.orderId}
                </h1>
                <p class="page-subtitle mb-0">Đặt lúc: <strong>${order.formattedDate}</strong> &bull; Khách hàng: <strong>${order.username}</strong></p>
            </div>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Quay lại lịch sử
            </a>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <!-- Thông tin trạng thái & người nhận -->
        <div class="col-md-6">
            <div class="card exam-card h-100 shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <span class="fw-bold"><i class="bi bi-truck me-1 text-primary"></i> Trạng thái & Vận chuyển</span>
                    <span class="badge ${order.statusBadgeClass} px-3 py-2 fs-7">
                        <i class="bi ${order.statusIconClass} me-1"></i><c:out value="${order.status}"/>
                    </span>
                </div>
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-0 d-flex flex-column gap-2 small">
                        <li><strong>Phương thức:</strong> <span class="badge bg-light text-dark border">COD - Thu tiền khi nhận hàng</span></li>
                        <li><strong>Trạng thái hiện tại:</strong> <strong class="text-primary"><c:out value="${order.status}"/></strong></li>
                        <li><strong>Thời gian tạo:</strong> ${order.formattedDate}</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card exam-card h-100 shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom">
                    <span class="fw-bold"><i class="bi bi-person-lines-fill me-1 text-primary"></i> Thông tin giao nhận</span>
                </div>
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-0 d-flex flex-column gap-2 small">
                        <li><strong>Người nhận:</strong> <c:out value="${order.receiverName}"/></li>
                        <li><strong>Điện thoại:</strong> <c:out value="${order.receiverPhone}"/></li>
                        <li><strong>Địa chỉ:</strong> <c:out value="${order.receiverAddress}"/></li>
                        <li><strong>Ghi chú:</strong> <c:out value="${not empty order.notes ? order.notes : 'Không có'}"/></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="card exam-card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3 border-bottom">
            <h2 class="h6 fw-bold mb-0"><i class="bi bi-box-seam me-1 text-primary"></i> Sản phẩm trong đơn hàng</h2>
        </div>
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col" class="text-center">Đơn giá</th>
                        <th scope="col" class="text-center">Số lượng</th>
                        <th scope="col" class="text-end">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${order.details}" var="d">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="${d.productImage}" alt="${d.productName}" 
                                         class="rounded border bg-light" 
                                         style="width: 56px; height: 56px; object-fit: cover;"
                                         onerror="this.src='https://placehold.co/80x80?text=No+Img';">
                                    <div>
                                        <div class="fw-bold"><c:out value="${d.productName}"/></div>
                                        <small class="text-muted">Mã sản phẩm: #${d.productId}</small>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center text-secondary">
                                <fmt:formatNumber value="${d.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td class="text-center fw-semibold">
                                x${d.quantity}
                            </td>
                            <td class="text-end fw-bold text-danger">
                                <fmt:formatNumber value="${d.subTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot class="table-light">
                    <tr>
                        <th colspan="3" class="text-end py-3">Tổng cộng:</th>
                        <th class="text-end text-danger fs-5 py-3">
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</body>
</html>
