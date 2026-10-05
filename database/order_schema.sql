USE ExerciseWeb;
GO

/* ==============================================================
   BÀI TẬP 11 - CHÂU MINH PHÁT - 24110294
   BẢNG ĐƠN HÀNG (Orders) VÀ CHI TIẾT ĐƠN HÀNG (OrderDetails)
   ============================================================== */

IF OBJECT_ID(N'dbo.OrderDetails', N'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID(N'dbo.Orders', N'U') IS NOT NULL DROP TABLE dbo.Orders;
GO

CREATE TABLE dbo.Orders (
    OrderId INT IDENTITY(1001,1) NOT NULL PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    ReceiverName NVARCHAR(100) NOT NULL,
    ReceiverPhone NVARCHAR(20) NOT NULL,
    ReceiverAddress NVARCHAR(300) NOT NULL,
    Notes NVARCHAR(500) NULL,
    PaymentMethod NVARCHAR(50) NOT NULL CONSTRAINT DF_Orders_PaymentMethod DEFAULT N'COD',
    TotalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    Status NVARCHAR(50) NOT NULL CONSTRAINT DF_Orders_Status DEFAULT N'Đơn hàng mới',
    CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Orders_CreatedAt DEFAULT SYSDATETIME(),
    UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_Orders_UpdatedAt DEFAULT SYSDATETIME(),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.OrderDetails (
    DetailId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    ProductName NVARCHAR(255) NOT NULL,
    ProductImage NVARCHAR(500) NULL,
    Price DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL,
    SubTotal DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(OrderId) ON DELETE CASCADE
);
GO

CREATE INDEX IX_Orders_Username ON dbo.Orders(Username);
CREATE INDEX IX_Orders_Status ON dbo.Orders(Status);
CREATE INDEX IX_OrderDetails_OrderId ON dbo.OrderDetails(OrderId);
GO

/* ==============================================================
   DỮ LIỆU MẪU ĐẦY ĐỦ 8 TRẠNG THÁI ĐỂ GIÁO VIÊN KIỂM TRA NGAY:
   1. Đơn hàng mới
   2. Đã xác nhận
   3. Chuẩn bị hàng
   4. Vận chuyển
   5. Giao hàng
   6. Đã giao
   7. Đơn hàng hủy
   8. Đơn hàng hoàn
   ============================================================== */

-- Đơn hàng 1: Đơn hàng mới (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Giao giờ hành chính giúp em', N'COD', 16500000, N'Đơn hàng mới', DATEADD(MINUTE, -10, SYSDATETIME()));

DECLARE @Order1 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order1, 1, N'Nikon D7000', N'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400', 6500000, 1, 6500000),
(@Order1, 2, N'Nikon D71000', N'https://images.unsplash.com/photo-1606980707986-49a75ee1cdd2?w=400', 10000000, 1, 10000000);

-- Đơn hàng 2: Đã xác nhận (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Gọi trước khi giao', N'COD', 2300000, N'Đã xác nhận', DATEADD(HOUR, -2, SYSDATETIME()));

DECLARE @Order2 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order2, 3, N'Nikon D72000', N'https://images.unsplash.com/photo-1452780212940-6f5c0d14d848?w=400', 2300000, 1, 2300000);

-- Đơn hàng 3: Chuẩn bị hàng (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Đóng gói cẩn thận hàng dễ vỡ', N'COD', 3200000, N'Chuẩn bị hàng', DATEADD(HOUR, -5, SYSDATETIME()));

DECLARE @Order3 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order3, 4, N'Canon 700d', N'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 3200000, 1, 3200000);

-- Đơn hàng 4: Vận chuyển (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'', N'COD', 1000000, N'Vận chuyển', DATEADD(DAY, -1, SYSDATETIME()));

DECLARE @Order4 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order4, 6, N'Canon 300D', N'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400', 1000000, 1, 1000000);

-- Đơn hàng 5: Giao hàng (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Shipper vui lòng gọi số 0333015964', N'COD', 1234400, N'Giao hàng', DATEADD(DAY, -2, SYSDATETIME()));

DECLARE @Order5 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order5, 7, N'Canon hs240', N'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400', 1234400, 1, 1234400);

-- Đơn hàng 6: Đã giao (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Giao thành công, khách đã nhận hàng', N'COD', 1160000, N'Đã giao', DATEADD(DAY, -3, SYSDATETIME()));

DECLARE @Order6 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order6, 8, N'FujiFilm', N'https://images.unsplash.com/photo-1606980707986-49a75ee1cdd2?w=400', 1160000, 1, 1160000);

-- Đơn hàng 7: Đơn hàng hủy (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Khách đổi ý muốn chọn mẫu khác', N'COD', 3000009, N'Đơn hàng hủy', DATEADD(DAY, -4, SYSDATETIME()));

DECLARE @Order7 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order7, 9, N'Nikon z5', N'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 3000009, 1, 3000009);

-- Đơn hàng 8: Đơn hàng hoàn (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'Châu Minh Phát', N'0333015964', N'1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Hàng hoàn do sai địa chỉ', N'COD', 30000000, N'Đơn hàng hoàn', DATEADD(DAY, -5, SYSDATETIME()));

DECLARE @Order8 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order8, 10, N'Nikon D850', N'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400', 30000000, 1, 30000000);

GO
