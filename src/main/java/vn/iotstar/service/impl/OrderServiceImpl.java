package vn.iotstar.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import vn.iotstar.dao.IOrderDao;
import vn.iotstar.dao.impl.OrderDaoImpl;
import vn.iotstar.model.Cart;
import vn.iotstar.model.CartItem;
import vn.iotstar.model.Order;
import vn.iotstar.model.OrderDetail;
import vn.iotstar.service.IOrderService;

public class OrderServiceImpl implements IOrderService {

    private final IOrderDao orderDao = new OrderDaoImpl();

    @Override
    public Order checkoutCOD(String username, String receiverName, String receiverPhone, String receiverAddress, String notes, Cart cart) {
        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng đang trống, không thể thanh toán.");
        }
        if (receiverName == null || receiverName.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập họ tên người nhận.");
        }
        if (receiverPhone == null || receiverPhone.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập số điện thoại người nhận.");
        }
        if (receiverAddress == null || receiverAddress.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập địa chỉ giao hàng.");
        }

        Order order = new Order();
        order.setUsername(username);
        order.setReceiverName(receiverName.trim());
        order.setReceiverPhone(receiverPhone.trim());
        order.setReceiverAddress(receiverAddress.trim());
        order.setNotes(notes != null ? notes.trim() : "");
        order.setPaymentMethod("COD");
        order.setTotalAmount(cart.getTotalAmount());
        order.setStatus(Order.STATUS_NEW);

        List<OrderDetail> details = new ArrayList<>();
        for (CartItem item : cart.getItems()) {
            OrderDetail d = new OrderDetail();
            d.setProductId(item.getProduct().getProductId());
            d.setProductName(item.getProduct().getProductName());
            d.setProductImage(item.getProduct().getImage());
            d.setPrice(item.getProduct().getPrice());
            d.setQuantity(item.getQuantity());
            d.setSubTotal(item.getSubTotal());
            details.add(d);
        }

        int orderId = orderDao.insert(order, details);
        if (orderId > 0) {
            order.setOrderId(orderId);
            order.setDetails(details);
            cart.clear(); // Xóa giỏ hàng sau khi đặt thành công
            return order;
        }

        return null;
    }

    @Override
    public Order findById(int orderId) {
        return orderDao.findById(orderId);
    }

    @Override
    public List<Order> findByUsername(String username, String status) {
        return orderDao.findByUsername(username, status);
    }

    @Override
    public List<Order> findAll(String status) {
        return orderDao.findAll(status);
    }

    @Override
    public Map<String, Integer> countByStatus(String username) {
        return orderDao.countByStatus(username);
    }

    @Override
    public boolean updateStatus(int orderId, String newStatus) {
        return orderDao.updateStatus(orderId, newStatus);
    }

    @Override
    public boolean cancelOrder(int orderId, String username) {
        return orderDao.cancelOrder(orderId, username);
    }
}
