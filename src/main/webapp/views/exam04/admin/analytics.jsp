<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>Phân tích tương tác - Đề 04</title></head>
<body>
<section class="animate-in">
    <div class="mb-4">
        <span class="eyebrow">DỮ LIỆU NGƯỜI DÙNG</span>
        <h1 class="h3 page-title mt-1">Phân tích tương tác video</h1>
        <p class="page-subtitle mb-0">Dữ liệu thực được lưu khi người dùng xem, thích hoặc sao chép liên kết.</p>
    </div>

    <div class="row g-3 mb-4 analytics-summary">
        <div class="col-6 col-lg-3"><div class="metric-card"><i class="bi bi-eye"></i><strong>${totalViews}</strong><span>Lượt xem</span></div></div>
        <div class="col-6 col-lg-3"><div class="metric-card"><i class="bi bi-heart"></i><strong>${totalLikes}</strong><span>Lượt thích</span></div></div>
        <div class="col-6 col-lg-3"><div class="metric-card"><i class="bi bi-share"></i><strong>${totalShares}</strong><span>Lượt chia sẻ</span></div></div>
        <div class="col-6 col-lg-3"><div class="metric-card"><i class="bi bi-activity"></i><strong>${totalActions}</strong><span>Sự kiện đã lưu</span></div></div>
    </div>

    <div class="row g-4">
        <div class="col-xl-7">
            <div class="card exam-card h-100"><div class="card-body p-0">
                <div class="p-3 border-bottom"><h2 class="h5 mb-0">Hiệu suất theo video</h2></div>
                <div class="table-responsive"><table class="table table-hover mb-0">
                    <thead><tr><th>Video</th><th class="text-end">Xem</th><th class="text-end">Thích</th><th class="text-end">Chia sẻ</th></tr></thead>
                    <tbody><c:forEach items="${videoAnalytics}" var="row"><tr>
                        <td><a href="${pageContext.request.contextPath}/video/detail?id=${row.videoId}"><c:out value="${row.title}"/></a><div class="small text-muted"><c:out value="${row.videoId}"/></div></td>
                        <td class="text-end">${row.views}</td><td class="text-end">${row.likeCount}</td><td class="text-end">${row.shareCount}</td>
                    </tr></c:forEach></tbody>
                </table></div>
            </div></div>
        </div>
        <div class="col-xl-5">
            <div class="card exam-card h-100"><div class="card-body p-0">
                <div class="p-3 border-bottom"><h2 class="h5 mb-0">Hoạt động gần đây</h2></div>
                <div class="interaction-feed">
                    <c:choose><c:when test="${empty recentInteractions}"><p class="text-muted p-3 mb-0">Chưa có hoạt động mới.</p></c:when><c:otherwise>
                        <c:forEach items="${recentInteractions}" var="item"><div class="interaction-item">
                            <span class="action-dot action-${item.actionType}"></span>
                            <div><strong><c:out value="${empty item.fullname ? 'Khách' : item.fullname}"/></strong>
                                <span class="action-label"><c:out value="${item.actionType}"/></span>
                                <div class="small text-muted"><c:out value="${item.videoTitle}"/> · <c:out value="${item.displayTime}"/></div>
                            </div>
                        </div></c:forEach>
                    </c:otherwise></c:choose>
                </div>
            </div></div>
        </div>
    </div>
</section>
</body>
</html>
