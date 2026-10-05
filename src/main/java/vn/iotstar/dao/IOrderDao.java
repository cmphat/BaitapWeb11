package vn.iotstar.dao;

import java.util.List;
import java.util.Map;
import vn.iotstar.model.Order;
import vn.iotstar.model.OrderDetail;

public interface IOrderDao {

    int insert(Order order, List<OrderDetail> details);

    Order findById(int orderId);

    List<Order> findByUsername(String username, String status);

    List<Order> findAll(String status);

    Map<String, Integer> countByStatus(String username);

    boolean updateStatus(int orderId, String newStatus);

    boolean cancelOrder(int orderId, String username);
}
