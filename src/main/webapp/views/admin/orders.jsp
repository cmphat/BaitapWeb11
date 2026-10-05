<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng - Admin</title>
</head>
<body>
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/home">Quản trị</a></li>
                <li class="breadcrumb-item active" aria-current="page">Quản lý Đơn hàng</li>
            </ol>
        </nav>
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h1 class="h3 page-title mb-1"><i class="bi bi-box-seam-fill text-primary me-2"></i>Quản lý Đơn hàng toàn hệ thống</h1>
                <p class="page-subtitle mb-0">Theo dõi, kiểm tra và cập nhật trạng thái đơn hàng của tất cả khách hàng.</p>
            </div>
        </div>
    </div>

    <c:if test="${not empty sessionScope.adminSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            <c:out value="${sessionScope.adminSuccess}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="adminSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.adminAlert}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:out value="${sessionScope.adminAlert}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="adminAlert" scope="session"/>
    </c:if>

    <!-- Bộ lọc trạng thái -->
    <div class="d-flex overflow-auto gap-2 pb-3 mb-4 border-bottom">
        <a href="${pageContext.request.contextPath}/admin/orders" 
           class="btn btn-sm ${selectedStatus == 'all' || empty selectedStatus ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3">
            Tất cả <span class="badge ${selectedStatus == 'all' || empty selectedStatus ? 'bg-white text-primary' : 'bg-secondary'} ms-1">${counts['all']}</span>
        </a>
        <c:forEach items="${allStatuses}" var="st">
            <a href="${pageContext.request.contextPath}/admin/orders?status=${st}" 
               class="btn btn-sm ${selectedStatus == st ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3">
                <c:out value="${st}"/> 
                <span class="badge ${selectedStatus == st ? 'bg-white text-primary' : 'bg-secondary'} ms-1">
                    ${counts[st] != null ? counts[st] : 0}
                </span>
            </a>
        </c:forEach>
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="card exam-card text-center p-5 my-4">
                <div class="py-4">
                    <i class="bi bi-inbox text-muted" style="font-size: 4rem;"></i>
                    <h4 class="mt-3 mb-2">Chưa có đơn hàng nào</h4>
                    <p class="text-secondary mb-0">Không có đơn hàng nào khớp với trạng thái đã chọn.</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card exam-card shadow-sm border-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th scope="col" style="width: 90px;">Mã ĐH</th>
                                <th scope="col">Khách hàng</th>
                                <th scope="col">Người nhận & Địa chỉ</th>
                                <th scope="col" class="text-end">Tổng tiền</th>
                                <th scope="col" class="text-center" style="width: 140px;">Trạng thái</th>
                                <th scope="col" class="text-center" style="width: 200px;">Đổi trạng thái</th>
                                <th scope="col" class="text-center" style="width: 90px;">Xem</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="o">
                                <tr>
                                    <td class="fw-bold text-primary">#ORD-${o.orderId}</td>
                                    <td>
                                        <div class="fw-semibold">${o.username}</div>
                                        <small class="text-muted">${o.formattedDate}</small>
                                    </td>
                                    <td>
                                        <div><strong><c:out value="${o.receiverName}"/></strong> (${o.receiverPhone})</div>
                                        <small class="text-muted d-block text-truncate" style="max-width: 250px;" title="${o.receiverAddress}">
                                            <c:out value="${o.receiverAddress}"/>
                                        </small>
                                    </td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge ${o.statusBadgeClass} px-2 py-1">
                                            <c:out value="${o.status}"/>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post" class="d-flex align-items-center gap-1">
                                            <input type="hidden" name="orderId" value="${o.orderId}"/>
                                            <input type="hidden" name="ref" value="${selectedStatus}"/>
                                            <select name="newStatus" class="form-select form-select-sm" onchange="this.form.submit();">
                                                <c:forEach items="${allStatuses}" var="st">
                                                    <option value="${st}" ${o.status == st ? 'selected' : ''}>
                                                        ${st}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </form>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/order/detail?id=${o.orderId}" class="btn btn-outline-secondary btn-sm" title="Chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
