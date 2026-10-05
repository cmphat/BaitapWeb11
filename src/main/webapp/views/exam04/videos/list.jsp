<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Video theo danh mục - Đề 04</title>
</head>
<body>
<div class="mb-4">
    <h1 class="h3 page-title">Video theo danh mục</h1>
    <p class="page-subtitle">Chọn danh mục để xem danh sách video. Mỗi trang hiển thị 3 video.</p>
    <div class="category-nav">
        <c:forEach items="${categories}" var="category">
            <a class="category-link ${selectedCategory.categoryId == category.categoryId ? 'active' : ''}"
               href="${pageContext.request.contextPath}/videos?categoryId=${category.categoryId}&page=1">
                <c:if test="${not empty category.images}">
                    <img class="category-thumb" src="${pageContext.request.contextPath}/${category.images}" alt="Ảnh ${category.categoryName}">
                </c:if>
                <span><c:out value="${category.categoryName}"/> <strong>(${category.videoCount})</strong></span>
            </a>
        </c:forEach>
    </div>
</div>

<c:if test="${not empty selectedCategory}">
    <div class="d-flex justify-content-between align-items-end mb-3">
        <div>
            <h2 class="h4 mb-1"><c:out value="${selectedCategory.categoryName}"/></h2>
            <span class="text-muted">Có ${videoCount} video trong danh mục</span>
        </div>
        <span class="badge text-bg-primary">Trang ${page}/${totalPages}</span>
    </div>
</c:if>

<c:choose>
    <c:when test="${empty videos}">
        <div class="alert alert-info">Danh mục này chưa có video.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-4">
            <c:forEach items="${videos}" var="video">
                <div class="col-12 col-md-6 col-lg-4">
                    <article class="card exam-card video-card h-100 animate-in">
                        <img class="video-poster" src="${pageContext.request.contextPath}${video.poster}?v=frame-20260923" alt="Poster ${video.title}">
                        <div class="card-body d-flex flex-column p-3">
                            <span class="badge text-bg-light border align-self-start mb-2"><c:out value="${video.categoryName}"/></span>
                            <h3 class="card-title"><c:out value="${video.title}"/></h3>
                            <p class="video-meta mb-2">Mã video: <strong><c:out value="${video.videoId}"/></strong></p>
                            <div class="video-stats mb-3">
                                <span><i class="bi bi-eye text-secondary"></i> ${video.views}</span>
                                <span><i class="bi bi-share text-secondary"></i> ${video.shareCount}</span>
                                <span><i class="bi bi-heart text-secondary"></i> ${video.likeCount}</span>
                            </div>
                            <a class="btn btn-outline-primary btn-sm mt-auto align-self-start" href="${pageContext.request.contextPath}/video/detail?id=${video.videoId}">Xem chi tiết</a>
                        </div>
                    </article>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<c:if test="${not empty selectedCategory and totalPages > 1}">
    <nav class="mt-4" aria-label="Phân trang video">
        <ul class="pagination justify-content-center">
            <li class="page-item ${page == 1 ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategory.categoryId}&page=${page - 1}" aria-label="Trang trước">&laquo;</a>
            </li>
            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                <li class="page-item ${pageNumber == page ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategory.categoryId}&page=${pageNumber}">${pageNumber}</a>
                </li>
            </c:forEach>
            <li class="page-item ${page == totalPages ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategory.categoryId}&page=${page + 1}" aria-label="Trang sau">&raquo;</a>
            </li>
        </ul>
    </nav>
</c:if>
</body>
</html>
