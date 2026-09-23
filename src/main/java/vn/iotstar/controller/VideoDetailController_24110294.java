package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.VideoDetail_24110294;
import vn.iotstar.service.IVideoService_24110294;
import vn.iotstar.service.impl.VideoService_24110294;

@WebServlet("/video/detail")
public class VideoDetailController_24110294 extends HttpServlet {
    private static final long serialVersionUID=1L;
    private final IVideoService_24110294 service=new VideoService_24110294();
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
        VideoDetail_24110294 video=service.findDetail(req.getParameter("id")); if(video==null){resp.sendError(404);return;}
        req.setAttribute("video",video);req.getRequestDispatcher("/views/exam04/videos/detail.jsp").forward(req,resp);
    }
}

