package vn.iotstar.service;

import java.util.List;
import java.util.Map;
import vn.iotstar.model.Cart;
import vn.iotstar.model.Order;

public interface IOrderService {

    Order checkoutCOD(String username, String receiverName, String receiverPhone, String receiverAddress, String notes, Cart cart);

    Order findById(int orderId);

    List<Order> findByUsername(String username, String status);

    List<Order> findAll(String status);

    Map<String, Integer> countByStatus(String username);

    boolean updateStatus(int orderId, String newStatus);

    boolean cancelOrder(int orderId, String username);
}
