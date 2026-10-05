package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.Product;
import vn.iotstar.model.Cart;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/remove", "/cart/clear"})
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IProductService productService = new ProductServiceImpl();

    private Cart getCart(HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/cart/add".equals(path)) {
            handleAdd(req, resp);
        } else if ("/cart/update".equals(path)) {
            handleUpdate(req, resp);
        } else if ("/cart/remove".equals(path)) {
            handleRemove(req, resp);
        } else if ("/cart/clear".equals(path)) {
            handleClear(req, resp);
        } else {
            // View cart
            Cart cart = getCart(req);
            req.setAttribute("cart", cart);
            req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/cart/add".equals(path)) {
            handleAdd(req, resp);
        } else if ("/cart/update".equals(path)) {
            handleUpdate(req, resp);
        } else if ("/cart/remove".equals(path)) {
            handleRemove(req, resp);
        } else if ("/cart/clear".equals(path)) {
            handleClear(req, resp);
        } else {
            doGet(req, resp);
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cart cart = getCart(req);
        String pIdParam = req.getParameter("productId");
        String qtyParam = req.getParameter("quantity");
        String buyNowParam = req.getParameter("buyNow");

        try {
            int productId = Integer.parseInt(pIdParam);
            int quantity = 1;
            if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                quantity = Integer.parseInt(qtyParam.trim());
            }
            if (quantity < 1) {
                quantity = 1;
            }

            Product product = productService.findById(productId);
            if (product != null) {
                int stock = product.getQuantity() > 0 ? product.getQuantity() : 99;
                if (quantity > stock) {
                    quantity = stock;
                    req.getSession().setAttribute("cartAlert", "Số lượng yêu cầu vượt quá tồn kho (" + stock + "). Đã điều chỉnh về tối đa.");
                } else {
                    req.getSession().setAttribute("cartSuccess", "Đã thêm \"" + product.getProductName() + "\" vào giỏ hàng thành công!");
                }
                cart.add(product, quantity);
            } else {
                req.getSession().setAttribute("cartAlert", "Không tìm thấy thông tin sản phẩm.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("cartAlert", "Dữ liệu không hợp lệ.");
        }

        if ("true".equalsIgnoreCase(buyNowParam)) {
            resp.sendRedirect(req.getContextPath() + "/checkout");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cart cart = getCart(req);
        String pIdParam = req.getParameter("productId");
        String qtyParam = req.getParameter("quantity");

        try {
            int productId = Integer.parseInt(pIdParam);
            int quantity = Integer.parseInt(qtyParam);

            Product product = productService.findById(productId);
            int maxStock = product != null && product.getQuantity() > 0 ? product.getQuantity() : 99;

            if (quantity <= 0) {
                cart.remove(productId);
                req.getSession().setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng.");
            } else if (quantity > maxStock) {
                cart.updateQuantity(productId, maxStock, maxStock);
                req.getSession().setAttribute("cartAlert", "Số lượng không được vượt quá số lượng còn lại trong kho (" + maxStock + ").");
            } else {
                cart.updateQuantity(productId, quantity, maxStock);
                req.getSession().setAttribute("cartSuccess", "Cập nhật số lượng thành công.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("cartAlert", "Dữ liệu cập nhật không hợp lệ.");
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleRemove(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cart cart = getCart(req);
        String pIdParam = req.getParameter("productId");
        try {
            int productId = Integer.parseInt(pIdParam);
            cart.remove(productId);
            req.getSession().setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng.");
        } catch (Exception e) {
            req.getSession().setAttribute("cartAlert", "Không thể xóa sản phẩm.");
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleClear(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cart cart = getCart(req);
        cart.clear();
        req.getSession().setAttribute("cartSuccess", "Đã xóa toàn bộ giỏ hàng.");
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
