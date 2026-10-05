package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.IOrderDao;
import vn.iotstar.model.Order;
import vn.iotstar.model.OrderDetail;

public class OrderDaoImpl extends DBConnection implements IOrderDao {

    @Override
    public int insert(Order order, List<OrderDetail> details) {
        String sqlOrder = "INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt, UpdatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), SYSDATETIME())";
        String sqlDetail = "INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlUpdateStock = "UPDATE dbo.Products SET Quantity = CASE WHEN Quantity >= ? THEN Quantity - ? ELSE 0 END WHERE ProductId = ?";

        Connection con = null;
        try {
            con = getConnection();
            con.setAutoCommit(false);

            int orderId = -1;
            try (PreparedStatement psOrder = con.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setString(1, order.getUsername());
                psOrder.setString(2, order.getReceiverName());
                psOrder.setString(3, order.getReceiverPhone());
                psOrder.setString(4, order.getReceiverAddress());
                psOrder.setString(5, order.getNotes());
                psOrder.setString(6, order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD");
                psOrder.setDouble(7, order.getTotalAmount());
                psOrder.setString(8, order.getStatus() != null ? order.getStatus() : Order.STATUS_NEW);

                psOrder.executeUpdate();
                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            if (orderId <= 0) {
                con.rollback();
                return -1;
            }

            try (PreparedStatement psDetail = con.prepareStatement(sqlDetail);
                 PreparedStatement psStock = con.prepareStatement(sqlUpdateStock)) {
                for (OrderDetail d : details) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, d.getProductId());
                    psDetail.setString(3, d.getProductName());
                    psDetail.setString(4, d.getProductImage());
                    psDetail.setDouble(5, d.getPrice());
                    psDetail.setInt(6, d.getQuantity());
                    psDetail.setDouble(7, d.getSubTotal());
                    psDetail.addBatch();

                    psStock.setInt(1, d.getQuantity());
                    psStock.setInt(2, d.getQuantity());
                    psStock.setInt(3, d.getProductId());
                    psStock.addBatch();
                }
                psDetail.executeBatch();
                psStock.executeBatch();
            }

            con.commit();
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (Exception ignored) {
                }
            }
            return -1;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (Exception ignored) {
                }
            }
        }
    }

    @Override
    public Order findById(int orderId) {
        String sql = "SELECT * FROM dbo.Orders WHERE OrderId = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(con, orderId));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Order> findByUsername(String username, String status) {
        List<Order> list = new ArrayList<>();
        boolean hasStatus = status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status.trim()) && !"Tất cả".equalsIgnoreCase(status.trim());
        String sql = hasStatus
                ? "SELECT * FROM dbo.Orders WHERE Username = ? AND Status = ? ORDER BY CreatedAt DESC"
                : "SELECT * FROM dbo.Orders WHERE Username = ? ORDER BY CreatedAt DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            if (hasStatus) {
                ps.setString(2, status.trim());
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(con, order.getOrderId()));
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Order> findAll(String status) {
        List<Order> list = new ArrayList<>();
        boolean hasStatus = status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status.trim()) && !"Tất cả".equalsIgnoreCase(status.trim());
        String sql = hasStatus
                ? "SELECT * FROM dbo.Orders WHERE Status = ? ORDER BY CreatedAt DESC"
                : "SELECT * FROM dbo.Orders ORDER BY CreatedAt DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasStatus) {
                ps.setString(1, status.trim());
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(con, order.getOrderId()));
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Map<String, Integer> countByStatus(String username) {
        Map<String, Integer> counts = new HashMap<>();
        for (String s : Order.ALL_STATUSES) {
            counts.put(s, 0);
        }
        counts.put("all", 0);

        boolean hasUser = username != null && !username.trim().isEmpty();
        String sql = hasUser
                ? "SELECT Status, COUNT(*) as cnt FROM dbo.Orders WHERE Username = ? GROUP BY Status"
                : "SELECT Status, COUNT(*) as cnt FROM dbo.Orders GROUP BY Status";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasUser) {
                ps.setString(1, username);
            }
            try (ResultSet rs = ps.executeQuery()) {
                int total = 0;
                while (rs.next()) {
                    String st = rs.getString("Status");
                    int count = rs.getInt("cnt");
                    if (st != null) {
                        counts.put(st.trim(), count);
                    }
                    total += count;
                }
                counts.put("all", total);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return counts;
    }

    @Override
    public boolean updateStatus(int orderId, String newStatus) {
        String sql = "UPDATE dbo.Orders SET Status = ?, UpdatedAt = SYSDATETIME() WHERE OrderId = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean cancelOrder(int orderId, String username) {
        String sqlCheck = "SELECT Status FROM dbo.Orders WHERE OrderId = ? AND Username = ?";
        String sqlCancel = "UPDATE dbo.Orders SET Status = ?, UpdatedAt = SYSDATETIME() WHERE OrderId = ?";
        String sqlRestoreStock = "UPDATE dbo.Products SET Quantity = Quantity + ? WHERE ProductId = ?";

        Connection con = null;
        try {
            con = getConnection();
            con.setAutoCommit(false);

            String currentStatus = null;
            try (PreparedStatement psCheck = con.prepareStatement(sqlCheck)) {
                psCheck.setInt(1, orderId);
                psCheck.setString(2, username);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        currentStatus = rs.getString("Status");
                    }
                }
            }

            if (currentStatus == null || !Order.STATUS_NEW.equalsIgnoreCase(currentStatus.trim())) {
                con.rollback();
                return false;
            }

            try (PreparedStatement psCancel = con.prepareStatement(sqlCancel)) {
                psCancel.setString(1, Order.STATUS_CANCELLED);
                psCancel.setInt(2, orderId);
                psCancel.executeUpdate();
            }

            List<OrderDetail> details = findDetailsByOrderId(con, orderId);
            try (PreparedStatement psRestore = con.prepareStatement(sqlRestoreStock)) {
                for (OrderDetail d : details) {
                    psRestore.setInt(1, d.getQuantity());
                    psRestore.setInt(2, d.getProductId());
                    psRestore.addBatch();
                }
                psRestore.executeBatch();
            }

            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (Exception ignored) {}
            }
            return false;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (Exception ignored) {}
            }
        }
    }

    private List<OrderDetail> findDetailsByOrderId(Connection con, int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM dbo.OrderDetails WHERE OrderId = ? ORDER BY DetailId ASC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail d = new OrderDetail();
                    d.setDetailId(rs.getInt("DetailId"));
                    d.setOrderId(rs.getInt("OrderId"));
                    d.setProductId(rs.getInt("ProductId"));
                    d.setProductName(rs.getString("ProductName"));
                    d.setProductImage(rs.getString("ProductImage"));
                    d.setPrice(rs.getDouble("Price"));
                    d.setQuantity(rs.getInt("Quantity"));
                    d.setSubTotal(rs.getDouble("SubTotal"));
                    details.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
    }

    private Order mapOrder(ResultSet rs) throws Exception {
        Order order = new Order();
        order.setOrderId(rs.getInt("OrderId"));
        order.setUsername(rs.getString("Username"));
        order.setReceiverName(rs.getString("ReceiverName"));
        order.setReceiverPhone(rs.getString("ReceiverPhone"));
        order.setReceiverAddress(rs.getString("ReceiverAddress"));
        order.setNotes(rs.getString("Notes"));
        order.setPaymentMethod(rs.getString("PaymentMethod"));
        order.setTotalAmount(rs.getDouble("TotalAmount"));
        order.setStatus(rs.getString("Status"));

        Timestamp created = rs.getTimestamp("CreatedAt");
        if (created != null) {
            order.setCreatedAt(created.toLocalDateTime());
        }
        Timestamp updated = rs.getTimestamp("UpdatedAt");
        if (updated != null) {
            order.setUpdatedAt(updated.toLocalDateTime());
        }
        return order;
    }
}
