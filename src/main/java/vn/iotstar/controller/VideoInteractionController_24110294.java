package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.model.User_24110294;
import vn.iotstar.model.VideoDetail_24110294;
import vn.iotstar.service.IVideoInteractionService_24110294;
import vn.iotstar.service.IVideoService_24110294;
import vn.iotstar.service.impl.VideoInteractionService_24110294;
import vn.iotstar.service.impl.VideoService_24110294;

@WebServlet("/video/interaction")
public class VideoInteractionController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoInteractionService_24110294 interactions = new VideoInteractionService_24110294();
    private final IVideoService_24110294 videos = new VideoService_24110294();

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        Object value = req.getSession(false) == null ? null : req.getSession(false).getAttribute("account");
        if (!(value instanceof User_24110294)) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("{\"ok\":false,\"loginRequired\":true,\"message\":\"Vui lòng đăng nhập để tương tác.\"}");
            return;
        }
        User_24110294 account = (User_24110294) value;
        String videoId = clean(req.getParameter("videoId"));
        String action = clean(req.getParameter("action")).toLowerCase();
        VideoDetail_24110294 video = videos.findDetail(videoId);
        if (video == null || !("like".equals(action) || "share".equals(action))) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"ok\":false,\"message\":\"Dữ liệu tương tác không hợp lệ.\"}");
            return;
        }
        try {
            boolean liked = interactions.isLiked(videoId, account.getUsername());
            if ("like".equals(action)) liked = interactions.toggleLike(videoId, account.getUsername());
            else interactions.recordShare(videoId, account.getUsername(), account.getEmail(), req.getSession().getId());
            video = videos.findDetail(videoId);
            resp.getWriter().write("{\"ok\":true,\"liked\":" + liked + ",\"likeCount\":" + video.getLikeCount()
                    + ",\"shareCount\":" + video.getShareCount() + "}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"ok\":false,\"message\":\"Không thể lưu tương tác lúc này.\"}");
        }
    }

    private String clean(String value) { return value == null ? "" : value.trim(); }
}
