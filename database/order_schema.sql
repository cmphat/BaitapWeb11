USE ExerciseWeb;
GO

/* ==============================================================
   BĂ€I Táº¬P 11 - CHĂ‚U MINH PHĂT - 24110294
   Báº¢NG ÄÆ N HĂ€NG (Orders) VĂ€ CHI TIáº¾T ÄÆ N HĂ€NG (OrderDetails)
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
    Status NVARCHAR(50) NOT NULL CONSTRAINT DF_Orders_Status DEFAULT N'ÄÆ¡n hĂ ng má»›i',
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
   Dá»® LIá»†U MáºªU Äáº¦Y Äá»¦ 8 TRáº NG THĂI Äá»‚ GIĂO VIĂN KIá»‚M TRA NGAY:
   1. ÄÆ¡n hĂ ng má»›i
   2. ÄĂ£ xĂ¡c nháº­n
   3. Chuáº©n bá»‹ hĂ ng
   4. Váº­n chuyá»ƒn
   5. Giao hĂ ng
   6. ÄĂ£ giao
   7. ÄÆ¡n hĂ ng há»§y
   8. ÄÆ¡n hĂ ng hoĂ n
   ============================================================== */

-- ÄÆ¡n hĂ ng 1: ÄÆ¡n hĂ ng má»›i (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'Giao giá» hĂ nh chĂ­nh giĂºp em', N'COD', 16500000, N'ÄÆ¡n hĂ ng má»›i', DATEADD(MINUTE, -10, SYSDATETIME()));

DECLARE @Order1 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order1, 1, N'Nikon D7000', N'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400', 6500000, 1, 6500000),
(@Order1, 2, N'Nikon D71000', N'https://images.unsplash.com/photo-1606980707986-49a75ee1cdd2?w=400', 10000000, 1, 10000000);

-- ÄÆ¡n hĂ ng 2: ÄĂ£ xĂ¡c nháº­n (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'Gá»i trÆ°á»›c khi giao', N'COD', 2300000, N'ÄĂ£ xĂ¡c nháº­n', DATEADD(HOUR, -2, SYSDATETIME()));

DECLARE @Order2 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order2, 3, N'Nikon D72000', N'https://images.unsplash.com/photo-1452780212940-6f5c0d14d848?w=400', 2300000, 1, 2300000);

-- ÄÆ¡n hĂ ng 3: Chuáº©n bá»‹ hĂ ng (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'ÄĂ³ng gĂ³i cáº©n tháº­n hĂ ng dá»… vá»¡', N'COD', 3200000, N'Chuáº©n bá»‹ hĂ ng', DATEADD(HOUR, -5, SYSDATETIME()));

DECLARE @Order3 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order3, 4, N'Canon 700d', N'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 3200000, 1, 3200000);

-- ÄÆ¡n hĂ ng 4: Váº­n chuyá»ƒn (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'', N'COD', 1000000, N'Váº­n chuyá»ƒn', DATEADD(DAY, -1, SYSDATETIME()));

DECLARE @Order4 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order4, 6, N'Canon 300D', N'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400', 1000000, 1, 1000000);

-- ÄÆ¡n hĂ ng 5: Giao hĂ ng (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'Shipper vui lĂ²ng gá»i sá»‘ 0333015964', N'COD', 1234400, N'Giao hĂ ng', DATEADD(DAY, -2, SYSDATETIME()));

DECLARE @Order5 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order5, 7, N'Canon hs240', N'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400', 1234400, 1, 1234400);

-- ÄÆ¡n hĂ ng 6: ÄĂ£ giao (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'Giao thĂ nh cĂ´ng, khĂ¡ch Ä‘Ă£ nháº­n hĂ ng', N'COD', 1160000, N'ÄĂ£ giao', DATEADD(DAY, -3, SYSDATETIME()));

DECLARE @Order6 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order6, 8, N'FujiFilm', N'https://images.unsplash.com/photo-1606980707986-49a75ee1cdd2?w=400', 1160000, 1, 1160000);

-- ÄÆ¡n hĂ ng 7: ÄÆ¡n hĂ ng há»§y (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'KhĂ¡ch Ä‘á»•i Ă½ muá»‘n chá»n máº«u khĂ¡c', N'COD', 3000009, N'ÄÆ¡n hĂ ng há»§y', DATEADD(DAY, -4, SYSDATETIME()));

DECLARE @Order7 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order7, 9, N'Nikon z5', N'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400', 3000009, 1, 3000009);

-- ÄÆ¡n hĂ ng 8: ÄÆ¡n hĂ ng hoĂ n (user)
INSERT INTO dbo.Orders (Username, ReceiverName, ReceiverPhone, ReceiverAddress, Notes, PaymentMethod, TotalAmount, Status, CreatedAt)
VALUES (N'user', N'ChĂ¢u Minh PhĂ¡t', N'0333015964', N'1 VĂµ VÄƒn NgĂ¢n, TP. Thá»§ Äá»©c, TP.HCM', N'HĂ ng hoĂ n do sai Ä‘á»‹a chá»‰', N'COD', 30000000, N'ÄÆ¡n hĂ ng hoĂ n', DATEADD(DAY, -5, SYSDATETIME()));

DECLARE @Order8 INT = SCOPE_IDENTITY();
INSERT INTO dbo.OrderDetails (OrderId, ProductId, ProductName, ProductImage, Price, Quantity, SubTotal)
VALUES 
(@Order8, 10, N'Nikon D850', N'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400', 30000000, 1, 30000000);

GO
