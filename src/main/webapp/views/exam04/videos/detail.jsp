<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${video.title}"/> - Chi tiết video - Đề 04</title>
</head>
<body>
<div class="mb-3">
    <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/videos?categoryId=${video.categoryId}">
        <i class="bi bi-arrow-left"></i> Quay lại danh sách
    </a>
</div>

<article class="card exam-card animate-in">
    <div class="card-body p-3 p-md-4">
        <div class="row g-4">
            <!-- Video Player: col-lg-7 desktop -->
            <div class="col-12 col-lg-7">
                <div class="ratio ratio-16x9 rounded overflow-hidden bg-black">
                    <video class="w-100 h-100" controls preload="metadata" poster="${pageContext.request.contextPath}${video.poster}?v=frame-20260923">
                        <source src="${pageContext.request.contextPath}/${video.videoPath}" type="video/mp4">
                        Trình duyệt của bạn không hỗ trợ phát thẻ video HTML5.
                    </video>
                </div>
            </div>

            <!-- Video Information: col-lg-5 desktop -->
            <div class="col-12 col-lg-5 d-flex flex-column">
                <div>
                    <span class="badge text-bg-primary mb-2"><c:out value="${video.categoryName}"/></span>
                    <h1 class="h3 page-title"><c:out value="${video.title}"/></h1>
                    <p class="text-muted mb-3">Mã video: <strong><c:out value="${video.videoId}"/></strong></p>

                    <div class="video-action-stats mb-3">
                        <span title="Lượt xem"><i class="bi bi-eye"></i> <strong id="viewCount">${video.views}</strong> xem</span>
                        <span title="Lượt chia sẻ"><i class="bi bi-share"></i> <strong id="shareCount">${video.shareCount}</strong> chia sẻ</span>
                        <span title="Lượt thích"><i class="bi bi-heart"></i> <strong id="likeCount">${video.likeCount}</strong> thích</span>
                    </div>

                    <div class="d-flex flex-wrap gap-2 mb-4">
                        <button id="likeButton" class="btn action-button ${liked ? 'is-active' : ''}" type="button" data-action="like">
                            <i class="bi ${liked ? 'bi-heart-fill' : 'bi-heart'}"></i>
                            <span>${liked ? 'Đã thích' : 'Thích'}</span>
                        </button>
                        <button id="shareButton" class="btn action-button" type="button" data-action="share">
                            <i class="bi bi-link-45deg"></i><span>Sao chép liên kết</span>
                        </button>
                    </div>

                    <h2 class="h6 fw-bold mb-2">Mô tả</h2>
                    <p class="text-secondary mb-0"><c:out value="${video.description}"/></p>
                </div>
            </div>
        </div>
    </div>
</article>
<script>
(() => {
    const endpoint = '${pageContext.request.contextPath}/video/interaction';
    const loginUrl = '${pageContext.request.contextPath}/login';
    const videoId = '${video.videoId}';
    const likeButton = document.getElementById('likeButton');
    const shareButton = document.getElementById('shareButton');
    const toast = document.getElementById('appToast');

    function notify(message, error) {
        toast.textContent = message;
        toast.className = 'app-toast show' + (error ? ' is-error' : '');
        window.setTimeout(() => toast.classList.remove('show'), 2400);
    }
    async function postAction(action) {
        const body = new URLSearchParams({videoId, action});
        const response = await fetch(endpoint, {method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'}, body});
        const data = await response.json();
        if (response.status === 401 || data.loginRequired) {
            notify('Vui lòng đăng nhập để tương tác.', true);
            window.setTimeout(() => location.href = loginUrl, 700);
            throw new Error('login-required');
        }
        if (!response.ok || !data.ok) throw new Error(data.message || 'Không thể lưu tương tác.');
        document.getElementById('likeCount').textContent = data.likeCount;
        document.getElementById('shareCount').textContent = data.shareCount;
        return data;
    }
    likeButton.addEventListener('click', async () => {
        likeButton.disabled = true;
        try {
            const data = await postAction('like');
            likeButton.classList.toggle('is-active', data.liked);
            likeButton.querySelector('i').className = 'bi ' + (data.liked ? 'bi-heart-fill' : 'bi-heart');
            likeButton.querySelector('span').textContent = data.liked ? 'Đã thích' : 'Thích';
            notify(data.liked ? 'Đã lưu lượt thích.' : 'Đã bỏ lượt thích.');
        } catch (error) { if (error.message !== 'login-required') notify(error.message, true); }
        finally { likeButton.disabled = false; }
    });
    shareButton.addEventListener('click', async () => {
        shareButton.disabled = true;
        try {
            await postAction('share');
            try { await navigator.clipboard.writeText(window.location.href); }
            catch (error) {
                const input = document.createElement('textarea'); input.value = window.location.href; document.body.appendChild(input);
                input.select(); document.execCommand('copy'); input.remove();
            }
            notify('Đã sao chép liên kết và lưu lượt chia sẻ.');
        } catch (error) { if (error.message !== 'login-required') notify(error.message, true); }
        finally { shareButton.disabled = false; }
    });
})();
</script>
</body>
</html>
