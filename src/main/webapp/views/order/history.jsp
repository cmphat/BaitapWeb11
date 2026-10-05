<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt hàng - Đề 04</title>
    <style>
        .order-filter-nav {
            display: flex;
            overflow-x: auto;
            white-space: nowrap;
            gap: 8px;
            padding-bottom: 6px;
        }
        .order-filter-nav::-webkit-scrollbar {
            height: 4px;
        }
        .order-filter-nav::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Lịch sử đặt hàng</li>
            </ol>
        </nav>
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h1 class="h3 page-title mb-1"><i class="bi bi-clock-history text-primary me-2"></i>Lịch sử đặt hàng</h1>
                <p class="page-subtitle mb-0">Theo dõi toàn bộ đơn hàng của bạn được phân loại theo 8 trạng thái xử lý.</p>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-bag-plus me-1"></i> Mua sắm thêm
            </a>
        </div>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty sessionScope.orderSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            <c:out value="${sessionScope.orderSuccess}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="orderSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.orderAlert}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:out value="${sessionScope.orderAlert}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="orderAlert" scope="session"/>
    </c:if>

    <!-- Hộp ghi chú hướng dẫn kiểm tra theo yêu cầu đề bài -->
    <div class="alert alert-info border-primary border-opacity-25 bg-primary-subtle py-2 px-3 mb-4 rounded-3 small">
        <div class="d-flex align-items-center gap-2">
            <i class="bi bi-info-circle-fill text-primary fs-5"></i>
            <div>
                <strong>Hướng dẫn kiểm tra trực tiếp:</strong> Bạn có thể vào SQL Server và chạy lệnh:
                <code>UPDATE dbo.Orders SET Status = N'Đã giao' WHERE OrderId = 1001;</code>
                sau đó tải lại trang hoặc bấm tab tương ứng để quan sát đơn hàng lập tức cập nhật theo đúng trạng thái trong CSDL.
            </div>
        </div>
    </div>

    <!-- Thanh lọc 8 trạng thái đơn hàng -->
    <div class="order-filter-nav mb-4 border-bottom pb-3">
        <a href="${pageContext.request.contextPath}/orders" 
           class="btn btn-sm ${selectedStatus == 'all' || empty selectedStatus ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3">
            Tất cả <span class="badge ${selectedStatus == 'all' || empty selectedStatus ? 'bg-white text-primary' : 'bg-secondary'} ms-1">${counts['all']}</span>
        </a>

        <c:forEach items="${allStatuses}" var="st">
            <a href="${pageContext.request.contextPath}/orders?status=${st}" 
               class="btn btn-sm ${selectedStatus == st ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3">
                <c:out value="${st}"/> 
                <span class="badge ${selectedStatus == st ? 'bg-white text-primary' : 'bg-secondary'} ms-1">
                    ${counts[st] != null ? counts[st] : 0}
                </span>
            </a>
        </c:forEach>
    </div>

    <!-- Danh sách đơn hàng -->
    <c:choose>
        <c:when test="${empty orders}">
            <div class="card exam-card text-center p-5 my-4">
                <div class="py-4">
                    <i class="bi bi-journal-x text-muted" style="font-size: 4.5rem;"></i>
                    <h3 class="h5 mt-3 mb-2">Không tìm thấy đơn hàng nào!</h3>
                    <p class="text-secondary mb-3">
                        <c:choose>
                            <c:when test="${selectedStatus != 'all' && not empty selectedStatus}">
                                Bạn hiện không có đơn hàng nào ở trạng thái "<strong><c:out value="${selectedStatus}"/></strong>".
                            </c:when>
                            <c:otherwise>
                                Bạn chưa có đơn hàng nào trong hệ thống.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary btn-sm me-2">
                        <i class="bi bi-list-ul me-1"></i> Xem tất cả trạng thái
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-sm">
                        <i class="bi bi-bag-plus me-1"></i> Mua sắm ngay
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="d-flex flex-column gap-4">
                <c:forEach items="${orders}" var="order">
                    <div class="card exam-card shadow-sm border-0 rounded-3 overflow-hidden">
                        <!-- Header đơn hàng -->
                        <div class="card-header bg-white py-3 px-4 border-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
                            <div class="d-flex align-items-center gap-3 flex-wrap">
                                <span class="fw-bold fs-6">
                                    <i class="bi bi-receipt text-primary me-1"></i>Đơn hàng #ORD-${order.orderId}
                                </span>
                                <span class="text-muted small">
                                    <i class="bi bi-calendar3 me-1"></i>${order.formattedDate}
                                </span>
                                <span class="badge bg-light text-dark border">
                                    <i class="bi bi-cash-stack text-success me-1"></i>${order.paymentMethod}
                                </span>
                            </div>
                            <div>
                                <span class="badge ${order.statusBadgeClass} px-3 py-2 fs-7 fw-semibold">
                                    <i class="bi ${order.statusIconClass} me-1"></i><c:out value="${order.status}"/>
                                </span>
                            </div>
                        </div>

                        <!-- Thân đơn hàng -->
                        <div class="card-body p-4">
                            <!-- Thông tin giao hàng -->
                            <div class="p-3 bg-light rounded-3 mb-3 border">
                                <div class="row g-2 small">
                                    <div class="col-md-4">
                                        <span class="text-muted">Người nhận:</span>
                                        <strong><c:out value="${order.receiverName}"/></strong>
                                    </div>
                                    <div class="col-md-4">
                                        <span class="text-muted">Số điện thoại:</span>
                                        <strong><c:out value="${order.receiverPhone}"/></strong>
                                    </div>
                                    <div class="col-md-4">
                                        <span class="text-muted">Hình thức:</span>
                                        <span class="text-success fw-bold">COD (Thu tiền khi nhận)</span>
                                    </div>
                                    <div class="col-12 mt-2">
                                        <span class="text-muted">Địa chỉ nhận:</span>
                                        <span><c:out value="${order.receiverAddress}"/></span>
                                    </div>
                                    <c:if test="${not empty order.notes}">
                                        <div class="col-12 mt-1">
                                            <span class="text-muted">Ghi chú:</span>
                                            <em><c:out value="${order.notes}"/></em>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Bảng sản phẩm trong đơn -->
                            <div class="table-responsive">
                                <table class="table align-middle mb-0 table-sm">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" style="min-width: 200px;">Sản phẩm</th>
                                            <th scope="col" class="text-center" style="width: 130px;">Đơn giá</th>
                                            <th scope="col" class="text-center" style="width: 100px;">Số lượng</th>
                                            <th scope="col" class="text-end" style="width: 140px;">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${order.details}" var="d">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <img src="${d.productImage}" alt="${d.productName}" 
                                                             class="rounded border bg-light" 
                                                             style="width: 48px; height: 48px; object-fit: cover;"
                                                             onerror="this.src='https://placehold.co/80x80?text=No+Img';">
                                                        <div>
                                                            <span class="fw-semibold small d-block"><c:out value="${d.productName}"/></span>
                                                            <small class="text-muted">Mã: #${d.productId}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center text-secondary small">
                                                    <fmt:formatNumber value="${d.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </td>
                                                <td class="text-center fw-semibold">
                                                    x${d.quantity}
                                                </td>
                                                <td class="text-end fw-bold text-danger small">
                                                    <fmt:formatNumber value="${d.subTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Footer đơn hàng -->
                        <div class="card-footer bg-white py-3 px-4 border-top d-flex justify-content-between align-items-center flex-wrap gap-2">
                            <div>
                                <c:if test="${order.cancellable}">
                                    <a href="${pageContext.request.contextPath}/order/cancel?id=${order.orderId}" 
                                       class="btn btn-outline-danger btn-sm"
                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #ORD-${order.orderId}?');">
                                        <i class="bi bi-x-circle me-1"></i> Hủy đơn hàng
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/order/detail?id=${order.orderId}" class="btn btn-outline-secondary btn-sm ms-1">
                                    <i class="bi bi-file-earmark-text me-1"></i> Chi tiết đơn
                                </a>
                            </div>
                            <div class="text-end">
                                <span class="text-secondary small me-2">Tổng số tiền:</span>
                                <span class="h5 fw-bold text-danger mb-0">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
