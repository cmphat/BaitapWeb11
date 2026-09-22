-- =======================================================
-- RESET EXAM TEST DATA
-- Database: ExerciseWeb
-- =======================================================

USE ExerciseWeb;
GO

IF OBJECT_ID('dbo.samples', 'U') IS NOT NULL
BEGIN
    DELETE FROM dbo.samples;
    DBCC CHECKIDENT ('dbo.samples', RESEED, 0);

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

    PRINT 'Reset exam samples table successfully with 15 rows.';
END
ELSE
BEGIN
    PRINT 'Table samples does not exist. Please run exam_template.sql first.';
END
GO
