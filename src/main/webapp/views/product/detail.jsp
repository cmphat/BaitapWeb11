<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - Chi tiết sản phẩm</title>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách sản phẩm
        </a>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-4">
            <div class="row g-4 align-items-center">
                <div class="col-12 col-md-5 text-center">
                    <div class="bg-light p-3 rounded-3 d-flex align-items-center justify-content-center" style="min-height: 300px;">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <img src="${product.image}" alt="${product.productName}" class="img-fluid rounded shadow-sm" style="max-height: 320px; object-fit: cover;" onerror="this.src='https://placehold.co/400x300?text=No+Image';">
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center py-5">
                                    <i class="bi bi-image display-1 d-block"></i>
                                    <span>Không có ảnh sản phẩm</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-12 col-md-7">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="badge bg-primary">
                            <i class="bi bi-tag me-1"></i> ${product.category != null ? product.category.categoryname : 'Chưa phân loại'}
                        </span>
                        <c:choose>
                            <c:when test="${product.status == 1}">
                                <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i> Đang bán</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary"><i class="bi bi-lock me-1"></i> Ngừng bán</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h2 class="fw-bold mb-3">${product.productName}</h2>
                    <h3 class="text-danger fw-bold mb-4">${product.price} VNĐ</h3>

                    <ul class="list-group list-group-flush mb-3">
                        <li class="list-group-item px-0">
                            <strong>Mã sản phẩm:</strong> #${product.productId}
                        </li>
                        <li class="list-group-item px-0">
                            <strong>Tình trạng kho:</strong> 
                            <span class="text-success fw-bold">Còn ${product.quantity > 0 ? product.quantity : 10} sản phẩm</span>
                        </li>
                        <li class="list-group-item px-0">
                            <strong>Ngày đăng:</strong> ${product.createdAt}
                        </li>
                    </ul>

                    <!-- Form chọn số lượng trong giới hạn và thêm vào giỏ / mua ngay -->
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mb-4 p-3 bg-white rounded border shadow-sm">
                        <input type="hidden" name="productId" value="${product.productId}"/>
                        <label class="form-label fw-semibold small mb-2">Số lượng đặt mua:</label>
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <button type="button" class="btn btn-outline-secondary" onclick="let q=document.getElementById('pQty'); if(parseInt(q.value)>1) q.value=parseInt(q.value)-1;">
                                <i class="bi bi-dash"></i>
                            </button>
                            <input type="number" id="pQty" name="quantity" value="1" min="1" max="${product.quantity > 0 ? product.quantity : 10}" 
                                   class="form-control text-center fw-bold" style="width: 70px;"
                                   onchange="let max=${product.quantity > 0 ? product.quantity : 10}; if(this.value>max) this.value=max; if(this.value<1) this.value=1;">
                            <button type="button" class="btn btn-outline-secondary" onclick="let q=document.getElementById('pQty'); let max=${product.quantity > 0 ? product.quantity : 10}; if(parseInt(q.value)<max) q.value=parseInt(q.value)+1;">
                                <i class="bi bi-plus"></i>
                            </button>
                            <span class="text-muted small ms-2">(Tối đa ${product.quantity > 0 ? product.quantity : 10})</span>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-outline-primary flex-grow-1 py-2 fw-semibold">
                                <i class="bi bi-cart-plus me-1"></i> Thêm vào giỏ hàng
                            </button>
                            <button type="submit" name="buyNow" value="true" class="btn btn-primary flex-grow-1 py-2 fw-semibold">
                                <i class="bi bi-lightning-charge-fill me-1"></i> Mua ngay (COD)
                            </button>
                        </div>
                    </form>

                    <div class="p-3 bg-light rounded-3 border">
                        <h6 class="fw-bold mb-2"><i class="bi bi-card-text me-1"></i> Mô tả sản phẩm</h6>
                        <p class="mb-0 text-muted" style="white-space: pre-line;">
                            ${not empty product.description ? product.description : 'Chưa có thông tin mô tả chi tiết cho sản phẩm này.'}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
