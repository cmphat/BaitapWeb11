# SQL SNIPPETS (MICROSOFT SQL SERVER)

Tập hợp cú pháp chuẩn Microsoft SQL Server 2016-2022 cho kỳ thi Java Web.

---

## 1. TẠO BẢNG CƠ BẢN VỚI IDENTITY
```sql
CREATE TABLE dbo.products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    price DECIMAL(18,2) DEFAULT 0.0,
    quantity INT DEFAULT 0,
    description NVARCHAR(MAX),
    status INT DEFAULT 1,
    category_id INT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) 
        REFERENCES dbo.categories(CategoryId) ON DELETE SET NULL
);
```

---

## 2. SELECT & TÌM KIẾM (LIKE)
```sql
-- Tìm kiếm có dấu / không phân biệt hoa thường
SELECT id, name, price, quantity, status 
FROM dbo.products 
WHERE LOWER(name) LIKE LOWER(N'%laptop%') 
ORDER BY id DESC;
```

---

## 3. JOIN (QUAN HỆ 1-N)
```sql
-- Lấy danh sách sản phẩm kèm tên danh mục
SELECT p.id, p.name, p.price, p.status, c.CategoryId, c.CategoryName 
FROM dbo.products p
LEFT JOIN dbo.categories c ON p.category_id = c.CategoryId
WHERE p.status = 1
ORDER BY p.id DESC;
```

---

## 4. INSERT VÀ LẤY ID VỪA TẠO
```sql
INSERT INTO dbo.products (name, price, quantity, description, status, category_id)
VALUES (N'Bàn phím cơ', 1500000.0, 10, N'Bàn phím Blue Switch', 1, 1);

-- Lấy ID của dòng vừa được insert tự tăng
SELECT SCOPE_IDENTITY() AS NewID;
```

---

## 5. UPDATE & DELETE
```sql
-- Cập nhật bản ghi theo ID
UPDATE dbo.products
SET name = N'Bàn phím cơ Pro',
    price = 1800000.0,
    quantity = 15,
    status = 1
WHERE id = 1;

-- Xóa bản ghi
DELETE FROM dbo.products WHERE id = 1;
```

---

## 6. PHÂN TRANG (OFFSET - FETCH NEXT - SQL SERVER SYNTAX)
*Lưu ý: SQL Server KHÔNG DÙNG cú pháp `LIMIT ... OFFSET` của MySQL, mà dùng `OFFSET ... ROWS FETCH NEXT ... ROWS ONLY`.*
```sql
-- Lấy trang 2, mỗi trang 5 dòng (Bắt buộc phải có ORDER BY)
SELECT id, name, price, status 
FROM dbo.products 
ORDER BY id DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
```

---

## 7. GOM NHÓM & THỐNG KÊ (GROUP BY, COUNT, SUM)
```sql
-- Đếm số sản phẩm trong từng danh mục
SELECT c.CategoryId, c.CategoryName, COUNT(p.id) AS TotalProducts, SUM(p.quantity) AS TotalQuantity
FROM dbo.categories c
LEFT JOIN dbo.products p ON c.CategoryId = p.category_id
GROUP BY c.CategoryId, c.CategoryName;
```

---

## 8. RESET DỮ LIỆU & AUTO INCREMENT
```sql
-- Xóa toàn bộ dữ liệu bảng
DELETE FROM dbo.products;

-- Reset lại cột IDENTITY về 0 (dòng tiếp theo sẽ là 1)
DBCC CHECKIDENT ('dbo.products', RESEED, 0);
```
