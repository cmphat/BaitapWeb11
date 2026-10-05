package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.VideoDetail_24110294;
import vn.iotstar.model.User_24110294;
import vn.iotstar.service.IVideoInteractionService_24110294;
import vn.iotstar.service.IVideoService_24110294;
import vn.iotstar.service.impl.VideoInteractionService_24110294;
import vn.iotstar.service.impl.VideoService_24110294;

@WebServlet("/video/detail")
public class VideoDetailController_24110294 extends HttpServlet {
    private static final long serialVersionUID=1L;
    private final IVideoService_24110294 service=new VideoService_24110294();
    private final IVideoInteractionService_24110294 interactionService=new VideoInteractionService_24110294();
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
        String videoId = req.getParameter("id");
        VideoDetail_24110294 video = service.findDetail(videoId);
        if (video == null) {
            resp.sendError(404);
            return;
        }
        HttpSession session = req.getSession(true);
        User_24110294 account = session.getAttribute("account") instanceof User_24110294
                ? (User_24110294) session.getAttribute("account") : null;
        String viewedKey = "viewed_24110294_" + videoId;
        if (session.getAttribute(viewedKey) == null) {
            interactionService.recordView(videoId, account == null ? null : account.getUsername(), session.getId());
            session.setAttribute(viewedKey, Boolean.TRUE);
            video = service.findDetail(videoId);
        }
        req.setAttribute("video", video);
        req.setAttribute("liked", account != null && interactionService.isLiked(videoId, account.getUsername()));
        req.setAttribute("videoPath", vn.iotstar.util.VideoPathUtil.resolveVideoPath(video.getVideoId()));
        req.getRequestDispatcher("/views/exam04/videos/detail.jsp").forward(req, resp);
    }
}
