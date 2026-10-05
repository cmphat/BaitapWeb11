package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.model.Cart;
import vn.iotstar.model.Order;
import vn.iotstar.model.User_24110294;
import vn.iotstar.model.User;
import vn.iotstar.service.IOrderService;
import vn.iotstar.service.impl.OrderServiceImpl;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Object account = session != null ? session.getAttribute("account") : null;

        if (account == null) {
            session = req.getSession(true);
            session.setAttribute("authAlert", "Vui lòng đăng nhập tài khoản để thực hiện thanh toán COD.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartAlert", "Giỏ hàng của bạn đang trống. Vui lòng chọn sản phẩm trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String username = "";
        String fullname = "";
        String phone = "";

        if (account instanceof User_24110294) {
            User_24110294 u = (User_24110294) account;
            username = u.getUsername();
            fullname = u.getFullname();
            phone = u.getPhone();
        } else if (account instanceof User) {
            User u = (User) account;
            username = u.getUsername();
            fullname = u.getFullname();
            phone = u.getPhone();
        }

        req.setAttribute("username", username);
        req.setAttribute("fullname", fullname);
        req.setAttribute("phone", phone);
        req.setAttribute("cart", cart);

        req.getRequestDispatcher("/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Object account = session != null ? session.getAttribute("account") : null;

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String username = "";
        if (account instanceof User_24110294) {
            username = ((User_24110294) account).getUsername();
        } else if (account instanceof User) {
            username = ((User) account).getUsername();
        }

        String receiverName = req.getParameter("receiverName");
        String receiverPhone = req.getParameter("receiverPhone");
        String receiverAddress = req.getParameter("receiverAddress");
        String notes = req.getParameter("notes");
        String paymentMethod = req.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        try {
            Order order = orderService.checkoutCOD(username, receiverName, receiverPhone, receiverAddress, notes, cart);
            if (order != null) {
                session.setAttribute("orderSuccess", "Đặt hàng thành công! Đơn hàng #" + order.getOrderId() 
                        + " đã được ghi nhận với hình thức thanh toán COD.");
                resp.sendRedirect(req.getContextPath() + "/orders?placedId=" + order.getOrderId());
                return;
            } else {
                req.setAttribute("error", "Không thể tạo đơn hàng. Vui lòng kiểm tra lại số lượng tồn kho.");
            }
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã có lỗi xảy ra trong quá trình thanh toán: " + e.getMessage());
        }

        req.setAttribute("receiverName", receiverName);
        req.setAttribute("receiverPhone", receiverPhone);
        req.setAttribute("receiverAddress", receiverAddress);
        req.setAttribute("notes", notes);
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/views/checkout.jsp").forward(req, resp);
    }
}
