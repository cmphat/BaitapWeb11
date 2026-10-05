package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.model.Order;
import vn.iotstar.model.User_24110294;
import vn.iotstar.model.User;
import vn.iotstar.service.IOrderService;
import vn.iotstar.service.impl.OrderServiceImpl;

@WebServlet(urlPatterns = {"/orders", "/order/detail", "/order/cancel"})
public class OrderHistoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Object account = session != null ? session.getAttribute("account") : null;

        if (account == null) {
            session = req.getSession(true);
            session.setAttribute("authAlert", "Vui lòng đăng nhập để xem lịch sử đặt hàng.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String username = "";
        if (account instanceof User_24110294) {
            username = ((User_24110294) account).getUsername();
        } else if (account instanceof User) {
            username = ((User) account).getUsername();
        }

        String path = req.getServletPath();

        if ("/order/cancel".equals(path)) {
            handleCancel(req, resp, username);
            return;
        }

        if ("/order/detail".equals(path)) {
            handleDetail(req, resp, username);
            return;
        }

        // /orders - Danh sách và lọc theo 8 trạng thái
        String selectedStatus = req.getParameter("status");
        if (selectedStatus != null) {
            selectedStatus = selectedStatus.trim();
        }

        List<Order> orders = orderService.findByUsername(username, selectedStatus);
        Map<String, Integer> counts = orderService.countByStatus(username);

        req.setAttribute("orders", orders);
        req.setAttribute("selectedStatus", selectedStatus != null ? selectedStatus : "all");
        req.setAttribute("counts", counts);
        req.setAttribute("allStatuses", Order.ALL_STATUSES);

        req.getRequestDispatcher("/views/order/history.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void handleDetail(HttpServletRequest req, HttpServletResponse resp, String username) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        try {
            int orderId = Integer.parseInt(idParam);
            Order order = orderService.findById(orderId);
            if (order != null && (username.equals(order.getUsername()) || isCurrentUserAdmin(req))) {
                req.setAttribute("order", order);
                req.getRequestDispatcher("/views/order/detail.jsp").forward(req, resp);
                return;
            }
        } catch (Exception ignored) {
        }
        resp.sendRedirect(req.getContextPath() + "/orders");
    }

    private void handleCancel(HttpServletRequest req, HttpServletResponse resp, String username) throws IOException {
        String idParam = req.getParameter("id");
        try {
            int orderId = Integer.parseInt(idParam);
            boolean cancelled = orderService.cancelOrder(orderId, username);
            if (cancelled) {
                req.getSession().setAttribute("orderSuccess", "Đã hủy đơn hàng #" + orderId + " thành công và hoàn trả số lượng vào kho.");
            } else {
                req.getSession().setAttribute("orderAlert", "Không thể hủy đơn hàng #" + orderId + ". Chỉ có thể hủy khi đơn hàng ở trạng thái 'Đơn hàng mới'.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("orderAlert", "Mã đơn hàng không hợp lệ.");
        }
        resp.sendRedirect(req.getContextPath() + "/orders");
    }

    private boolean isCurrentUserAdmin(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        if (s == null) return false;
        Object acc = s.getAttribute("account");
        if (acc instanceof User_24110294) return ((User_24110294) acc).isAdmin();
        if (acc instanceof User) return ((User) acc).getRoleid() == 1;
        return false;
    }
}
