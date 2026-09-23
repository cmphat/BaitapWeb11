<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết video - Đề 04</title>
</head>
<body>
<div class="mb-3">
    <a class="text-decoration-none" href="${pageContext.request.contextPath}/videos?categoryId=${video.categoryId}">&larr; Quay lại danh sách</a>
</div>
<article class="card exam-card overflow-hidden">
    <div class="row g-0">
        <div class="col-lg-6">
            <img class="detail-poster" src="${pageContext.request.contextPath}/${video.poster}" alt="Poster ${video.title}">
        </div>
        <div class="col-lg-6">
            <div class="card-body p-4 p-xl-5">
                <span class="badge text-bg-primary mb-3"><c:out value="${video.categoryName}"/></span>
                <h1 class="h2 page-title"><c:out value="${video.title}"/></h1>
                <p class="text-muted">Mã video: <strong><c:out value="${video.videoId}"/></strong></p>
                <div class="d-flex flex-wrap gap-4 py-3 border-top border-bottom mb-4">
                    <span><i class="bi bi-eye me-1"></i> <strong>${video.views}</strong> lượt xem</span>
                    <span><i class="bi bi-share me-1"></i> <strong>${video.shareCount}</strong> lượt chia sẻ</span>
                    <span><i class="bi bi-heart me-1"></i> <strong>${video.likeCount}</strong> lượt thích</span>
                </div>
                <h2 class="h5">Mô tả</h2>
                <p class="text-secondary mb-0"><c:out value="${video.description}"/></p>
            </div>
        </div>
    </div>
</article>
</body>
</html>
