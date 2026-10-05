package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.IVideoInteractionService_24110294;
import vn.iotstar.service.impl.VideoInteractionService_24110294;

@WebServlet("/admin/analytics")
public class AnalyticsController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoInteractionService_24110294 service = new VideoInteractionService_24110294();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int[] summary = service.getSummary();
        req.setAttribute("totalViews", summary[0]);
        req.setAttribute("totalLikes", summary[1]);
        req.setAttribute("totalShares", summary[2]);
        req.setAttribute("totalActions", summary[3]);
        req.setAttribute("videoAnalytics", service.findVideoAnalytics());
        req.setAttribute("recentInteractions", service.findRecentInteractions(30));
        req.getRequestDispatcher("/views/exam04/admin/analytics.jsp").forward(req, resp);
    }
}
