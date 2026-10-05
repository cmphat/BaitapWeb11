package vn.iotstar.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import vn.iotstar.entity.Product;

public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    public Cart() {
    }

    public Map<Integer, CartItem> getMap() {
        return items;
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public int getItemCount() {
        return items.size();
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public double getTotalAmount() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getSubTotal();
        }
        return total;
    }

    /**
     * Thêm sản phẩm vào giỏ hàng có kiểm tra giới hạn tồn kho.
     * @param product Sản phẩm cần thêm
     * @param quantity Số lượng muốn thêm
     * @return CartItem đã được thêm/cập nhật
     */
    public CartItem add(Product product, int quantity) {
        if (product == null || quantity <= 0) {
            return null;
        }

        int maxStock = product.getQuantity() > 0 ? product.getQuantity() : 99;
        int pId = product.getProductId();

        if (items.containsKey(pId)) {
            CartItem existing = items.get(pId);
            int newQty = existing.getQuantity() + quantity;
            if (newQty > maxStock) {
                newQty = maxStock;
            }
            existing.setQuantity(newQty);
            return existing;
        } else {
            int initialQty = Math.min(quantity, maxStock);
            CartItem newItem = new CartItem(product, initialQty);
            items.put(pId, newItem);
            return newItem;
        }
    }

    /**
     * Thay đổi số lượng sản phẩm trong giới hạn cho phép (1 <= qty <= maxStock).
     * @param productId ID sản phẩm
     * @param quantity Số lượng mới
     * @param maxStock Giới hạn tồn kho tối đa
     * @return true nếu cập nhật thành công, false nếu không tìm thấy
     */
    public boolean updateQuantity(int productId, int quantity, int maxStock) {
        if (!items.containsKey(productId)) {
            return false;
        }

        if (quantity <= 0) {
            items.remove(productId);
            return true;
        }

        if (maxStock <= 0) {
            maxStock = 99;
        }

        int finalQty = Math.min(quantity, maxStock);
        items.get(productId).setQuantity(finalQty);
        return true;
    }

    public void remove(int productId) {
        items.remove(productId);
    }

    public void clear() {
        items.clear();
    }
}
