-- =======================================================
-- EXAM DATABASE TEMPLATE FOR SQL SERVER
-- Database: ExerciseWeb
-- =======================================================

USE ExerciseWeb;
GO

-- 1. Xóa bảng samples nếu đã tồn tại
IF OBJECT_ID('dbo.samples', 'U') IS NOT NULL
    DROP TABLE dbo.samples;
GO

-- 2. Tạo bảng mẫu samples (Mô hình 1-N: Category 1 - N Sample)
CREATE TABLE dbo.samples (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    status INT DEFAULT 1,          -- 1: Hoạt động / Kích hoạt, 0: Khóa / Tạm dừng
    category_id INT NULL,          -- Khóa ngoại tham chiếu đến categories(CategoryId)
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Sample_Category FOREIGN KEY (category_id) 
        REFERENCES dbo.categories(CategoryId) 
        ON DELETE SET NULL
);
GO

-- 3. Đảm bảo có sẵn categories mẫu
IF NOT EXISTS (SELECT 1 FROM dbo.categories WHERE CategoryId = 1)
BEGIN
    SET IDENTITY_INSERT dbo.categories ON;
    INSERT INTO dbo.categories (CategoryId, CategoryName, Status) VALUES (1, N'Điện tử & Công nghệ', 1);
    INSERT INTO dbo.categories (CategoryId, CategoryName, Status) VALUES (2, N'Đồ gia dụng', 1);
    INSERT INTO dbo.categories (CategoryId, CategoryName, Status) VALUES (3, N'Văn phòng phẩm', 1);
    SET IDENTITY_INSERT dbo.categories OFF;
END
GO

-- 4. Chèn 15 dòng dữ liệu test
INSERT INTO dbo.samples (name, description, status, category_id) VALUES
(N'Laptop Dell XPS 15', N'Laptop đồ họa mỏng nhẹ hiệu năng cao', 1, 1),
(N'MacBook Pro 14 M3', N'Chip M3 Pro màn hình Liquid Retina XDR', 1, 1),
(N'Bàn phím cơ Keychron K2', N'Bàn phím không dây cơ học Blue Switch', 1, 1),
(N'Chuột Logitech MX Master 3S', N'Chuột công thái học cao cấp chống ồn', 1, 1),
(N'Màn hình Dell UltraSharp 27', N'Màn hình 4K IPS độ chuẩn màu cao', 1, 1),
(N'Tai nghe Sony WH-1000XM5', N'Tai nghe chống ồn chủ động đỉnh cao', 0, 1),
(N'Nồi chiên không dầu Philips', N'Dung tích 4.2 lít công nghệ Rapid Air', 1, 3),
(N'Máy lọc không khí Xiaomi', N'Bộ lọc HEPA 3 lớp diệt khuẩn', 1, 3),
(N'Robot hút bụi Ecovacs', N'Điều hướng Laser thông minh lau nhà tự động', 0, 3),
(N'Bình đun siêu tốc Lock&Lock', N'Chất liệu thủy tinh dung tích 1.7L', 1, 3),
(N'Bút bi cao cấp Parker', N'Mực xanh ngòi 0.7mm sang trọng', 1, 1),
(N'Sổ tay bìa da A5', N'Giấy chống lóa 100gsm 200 trang', 1, 1),
(N'Bảng vẽ điện tử Wacom One', N'Cảm ứng lực 4096 mức cho họa sĩ', 1, 1),
(N'Đèn bàn học chống cận Taotronics', N'Ánh sáng LED 5 chế độ sáng dịu mắt', 1, 3),
(N'Ổ cứng di động SSD Samsung T7 1TB', N'Tốc độ đọc ghi 1050MB/s chuẩn USB 3.2', 0, 1);
GO

-- Kiểm tra kết quả
SELECT s.id, s.name, s.status, s.category_id, c.CategoryName 
FROM dbo.samples s
LEFT JOIN dbo.categories c ON s.category_id = c.CategoryId;
GO
