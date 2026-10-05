package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.model.Order;
import vn.iotstar.service.IOrderService;
import vn.iotstar.service.impl.OrderServiceImpl;

@WebServlet(urlPatterns = {"/admin/orders", "/admin/orders/update-status"})
public class AdminOrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/orders/update-status".equals(path)) {
            handleUpdateStatus(req, resp);
            return;
        }

        String selectedStatus = req.getParameter("status");
        if (selectedStatus != null) {
            selectedStatus = selectedStatus.trim();
        }

        List<Order> orders = orderService.findAll(selectedStatus);
        Map<String, Integer> counts = orderService.countByStatus(null);

        req.setAttribute("orders", orders);
        req.setAttribute("selectedStatus", selectedStatus != null ? selectedStatus : "all");
        req.setAttribute("counts", counts);
        req.setAttribute("allStatuses", Order.ALL_STATUSES);

        req.getRequestDispatcher("/views/admin/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleUpdateStatus(req, resp);
    }

    private void handleUpdateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("orderId");
        String newStatus = req.getParameter("newStatus");

        try {
            int orderId = Integer.parseInt(idParam);
            if (newStatus != null && !newStatus.trim().isEmpty()) {
                boolean ok = orderService.updateStatus(orderId, newStatus.trim());
                if (ok) {
                    req.getSession().setAttribute("adminSuccess", "Đã cập nhật trạng thái đơn hàng #" + orderId + " sang: " + newStatus);
                } else {
                    req.getSession().setAttribute("adminAlert", "Không thể cập nhật trạng thái đơn hàng #" + orderId);
                }
            }
        } catch (Exception e) {
            req.getSession().setAttribute("adminAlert", "Dữ liệu không hợp lệ.");
        }

        String ref = req.getParameter("ref");
        if (ref != null && !ref.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders?status=" + java.net.URLEncoder.encode(ref, "UTF-8"));
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }
}
