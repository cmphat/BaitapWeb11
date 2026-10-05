package vn.iotstar.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String STATUS_NEW = "Đơn hàng mới";
    public static final String STATUS_CONFIRMED = "Đã xác nhận";
    public static final String STATUS_PREPARING = "Chuẩn bị hàng";
    public static final String STATUS_SHIPPING = "Vận chuyển";
    public static final String STATUS_DELIVERING = "Giao hàng";
    public static final String STATUS_DELIVERED = "Đã giao";
    public static final String STATUS_CANCELLED = "Đơn hàng hủy";
    public static final String STATUS_RETURNED = "Đơn hàng hoàn";

    public static final List<String> ALL_STATUSES = Collections.unmodifiableList(Arrays.asList(
        STATUS_NEW,
        STATUS_CONFIRMED,
        STATUS_PREPARING,
        STATUS_SHIPPING,
        STATUS_DELIVERING,
        STATUS_DELIVERED,
        STATUS_CANCELLED,
        STATUS_RETURNED
    ));

    private int orderId;
    private String username;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String notes;
    private String paymentMethod = "COD";
    private double totalAmount;
    private String status = STATUS_NEW;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private List<OrderDetail> details = new ArrayList<>();

    public Order() {
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<OrderDetail> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }

    public boolean isCancellable() {
        return STATUS_NEW.equalsIgnoreCase(this.status);
    }

    public String getFormattedDate() {
        if (createdAt == null) {
            return "";
        }
        return createdAt.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

    public String getStatusBadgeClass() {
        if (status == null) {
            return "bg-secondary";
        }
        String s = status.trim();
        if (STATUS_NEW.equalsIgnoreCase(s)) {
            return "bg-primary";
        } else if (STATUS_CONFIRMED.equalsIgnoreCase(s)) {
            return "bg-info text-dark";
        } else if (STATUS_PREPARING.equalsIgnoreCase(s)) {
            return "bg-warning text-dark";
        } else if (STATUS_SHIPPING.equalsIgnoreCase(s)) {
            return "bg-secondary";
        } else if (STATUS_DELIVERING.equalsIgnoreCase(s)) {
            return "bg-primary text-white";
        } else if (STATUS_DELIVERED.equalsIgnoreCase(s)) {
            return "bg-success";
        } else if (STATUS_CANCELLED.equalsIgnoreCase(s)) {
            return "bg-danger";
        } else if (STATUS_RETURNED.equalsIgnoreCase(s)) {
            return "bg-dark";
        }
        return "bg-secondary";
    }

    public String getStatusIconClass() {
        if (status == null) {
            return "bi-circle";
        }
        String s = status.trim();
        if (STATUS_NEW.equalsIgnoreCase(s)) {
            return "bi-bag-plus";
        } else if (STATUS_CONFIRMED.equalsIgnoreCase(s)) {
            return "bi-check2-circle";
        } else if (STATUS_PREPARING.equalsIgnoreCase(s)) {
            return "bi-box-seam";
        } else if (STATUS_SHIPPING.equalsIgnoreCase(s)) {
            return "bi-truck";
        } else if (STATUS_DELIVERING.equalsIgnoreCase(s)) {
            return "bi-bicycle";
        } else if (STATUS_DELIVERED.equalsIgnoreCase(s)) {
            return "bi-check-all";
        } else if (STATUS_CANCELLED.equalsIgnoreCase(s)) {
            return "bi-x-circle";
        } else if (STATUS_RETURNED.equalsIgnoreCase(s)) {
            return "bi-arrow-return-left";
        }
        return "bi-circle";
    }
}
