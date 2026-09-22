# JSP & BOOTSTRAP 5 FORM SNIPPETS

Tổng hợp mẫu các loại ô nhập liệu thông dụng nhất trong các bài thi Java Web, chuẩn Bootstrap 5.3.3.

---

## 1. Ô NHẬP VĂN BẢN (TEXT)
```jsp
<div class="mb-3">
    <label for="name" class="form-label fw-semibold">Tên đối tượng <span class="text-danger">*</span></label>
    <input type="text" class="form-control" id="name" name="name" 
           value="${entity.name}" placeholder="Nhập tên..." required>
    <div class="form-text">Ví dụ: Tên sản phẩm, họ và tên...</div>
</div>
```

---

## 2. Ô NHẬP SỐ NGUYÊN HOẶC SỐ THỰC (NUMBER / PRICE)
```jsp
<div class="mb-3">
    <label for="price" class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
    <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" 
           value="${entity.price}" placeholder="0.00" required>
</div>

<div class="mb-3">
    <label for="quantity" class="form-label fw-semibold">Số lượng <span class="text-danger">*</span></label>
    <input type="number" min="0" class="form-control" id="quantity" name="quantity" 
           value="${entity.quantity}" placeholder="0" required>
</div>
```

---

## 3. EMAIL
```jsp
<div class="mb-3">
    <label for="email" class="form-label fw-semibold">Địa chỉ Email</label>
    <input type="email" class="form-control" id="email" name="email" 
           value="${entity.email}" placeholder="example@domain.com">
</div>
```

---

## 4. NGÀY THÁNG (DATE)
```jsp
<div class="mb-3">
    <label for="birthdate" class="form-label fw-semibold">Ngày sinh / Ngày tạo</label>
    <input type="date" class="form-control" id="birthdate" name="birthdate" 
           value="${entity.birthdate}">
</div>
```

---

## 5. DROPDOWN DANH SÁCH (SELECT)
```jsp
<div class="mb-3">
    <label for="category_id" class="form-label fw-semibold">Chọn danh mục</label>
    <select class="form-select" id="category_id" name="category_id">
        <option value="">-- Vui lòng chọn --</option>
        <c:forEach var="cat" items="${categories}">
            <option value="${cat.categoryid}" ${entity.category.categoryid == cat.categoryid ? 'selected' : ''}>
                ${cat.categoryname}
            </option>
        </c:forEach>
    </select>
</div>
```

---

## 6. NÚT CHỌN MỘT (RADIO BUTTON)
```jsp
<div class="mb-3">
    <label class="form-label fw-semibold d-block">Trạng thái</label>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="status" id="status1" value="1" 
               ${entity.status == 1 || empty entity ? 'checked' : ''}>
        <label class="form-check-label text-success" for="status1">Kích hoạt</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="status" id="status0" value="0" 
               ${entity.status == 0 ? 'checked' : ''}>
        <label class="form-check-label text-danger" for="status0">Khóa</label>
    </div>
</div>
```

---

## 7. Ô ĐÁNH DẤU (CHECKBOX)
```jsp
<div class="mb-3">
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="featured" id="featured" value="true" 
               ${entity.featured ? 'checked' : ''}>
        <label class="form-check-label" for="featured">
            Đánh dấu là nổi bật
        </label>
    </div>
</div>
```

---

## 8. VĂN BẢN DÀI (TEXTAREA)
```jsp
<div class="mb-3">
    <label for="description" class="form-label fw-semibold">Mô tả chi tiết</label>
    <textarea class="form-control" id="description" name="description" rows="4" 
              placeholder="Nhập nội dung mô tả...">${entity.description}</textarea>
</div>
```

---

## 9. UPLOAD FILE ẢNH
```jsp
<!-- Form phải có thuộc tính enctype="multipart/form-data" -->
<form action="..." method="post" enctype="multipart/form-data">
    <div class="mb-3">
        <label for="imageFile" class="form-label fw-semibold">Chọn file ảnh</label>
        <input class="form-control" type="file" id="imageFile" name="imageFile" accept="image/*">
    </div>
</form>
```
