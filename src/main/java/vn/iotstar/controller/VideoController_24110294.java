package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.Category_24110294;
import vn.iotstar.model.VideoDetail_24110294;
import vn.iotstar.service.*;
import vn.iotstar.service.impl.*;

@WebServlet("/videos")
public class VideoController_24110294 extends HttpServlet {
    private static final long serialVersionUID=1L;
    private final ICategoryService_24110294 categories=new CategoryService_24110294();
    private final IVideoService_24110294 videos=new VideoService_24110294();
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
        List<Category_24110294> list=categories.findAllWithVideoCount(); req.setAttribute("categories",list);
        if(list.isEmpty()){req.getRequestDispatcher("/views/exam04/videos/list.jsp").forward(req,resp);return;}
        int categoryId=parse(req.getParameter("categoryId"),list.get(0).getCategoryId());
        Category_24110294 selected=categories.findById(categoryId); if(selected==null){selected=list.get(0);categoryId=selected.getCategoryId();}
        int count=videos.countByCategory(categoryId), pages=Math.max(1,(int)Math.ceil(count/3.0)); int page=Math.min(parse(req.getParameter("page"),1),pages);
        req.setAttribute("selectedCategory",selected); req.setAttribute("videos",videos.findByCategory(categoryId,page,3));
        req.setAttribute("videoCount",count);req.setAttribute("page",page);req.setAttribute("totalPages",pages);
        req.getRequestDispatcher("/views/exam04/videos/list.jsp").forward(req,resp);
    }
    private int parse(String s,int d){try{return Math.max(1,Integer.parseInt(s));}catch(Exception e){return d;}}
}

