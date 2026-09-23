package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.model.User_24110294;
import vn.iotstar.service.IUserService_24110294;
import vn.iotstar.service.impl.UserService_24110294;

@WebServlet(urlPatterns={"/admin/users", "/admin/users/create", "/admin/users/detail", "/admin/users/edit", "/admin/users/delete"})
public class UserController_24110294 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE=6;
    private final IUserService_24110294 service=new UserService_24110294();
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException {
        String path=req.getServletPath();
        if(path.endsWith("/create")){ req.setAttribute("mode","create"); forward(req,resp,"form.jsp"); return; }
        if(path.endsWith("/detail")||path.endsWith("/edit")){
            User_24110294 u=service.findByUsername(req.getParameter("username"));
            if(u==null){resp.sendError(404);return;} req.setAttribute("user",u);
            req.setAttribute("mode",path.endsWith("/edit")?"edit":"detail"); forward(req,resp,path.endsWith("/edit")?"form.jsp":"detail.jsp"); return;
        }
        if(path.endsWith("/delete")){ try{service.delete(req.getParameter("username"));resp.sendRedirect(req.getContextPath()+"/admin/users?msg=deleted");}catch(Exception e){resp.sendRedirect(req.getContextPath()+"/admin/users?error=delete");} return; }
        int page=parse(req.getParameter("page"),1); int total=service.count(); int pages=Math.max(1,(int)Math.ceil(total/(double)PAGE_SIZE)); page=Math.min(page,pages);
        req.setAttribute("users",service.findAll(page,PAGE_SIZE)); req.setAttribute("page",page); req.setAttribute("totalPages",pages); req.setAttribute("totalUsers",total);
        forward(req,resp,"list.jsp");
    }
    @Override protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException {
        String path=req.getServletPath(); User_24110294 u=new User_24110294();
        u.setUsername(val(req,"username")); u.setPassword(val(req,"password")); u.setPhone(val(req,"phone"));
        u.setFullname(val(req,"fullname")); u.setEmail(val(req,"email")); u.setImages(val(req,"images"));
        u.setAdmin(req.getParameter("admin")!=null); u.setActive(req.getParameter("active")!=null);
        try { if(path.endsWith("/create")) service.insert(u); else service.update(u); resp.sendRedirect(req.getContextPath()+"/admin/users?msg=saved"); }
        catch(Exception e){req.setAttribute("alert",e.getMessage());req.setAttribute("user",u);req.setAttribute("mode",path.endsWith("/create")?"create":"edit");forward(req,resp,"form.jsp");}
    }
    private void forward(HttpServletRequest req,HttpServletResponse resp,String file)throws ServletException,IOException{req.getRequestDispatcher("/views/exam04/admin/users/"+file).forward(req,resp);}
    private int parse(String s,int d){try{return Math.max(1,Integer.parseInt(s));}catch(Exception e){return d;}}
    private String val(HttpServletRequest r,String n){String s=r.getParameter(n);return s==null?"":s.trim();}
}

