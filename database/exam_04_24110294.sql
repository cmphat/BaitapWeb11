USE master;
GO

IF DB_ID(N'ExerciseWeb') IS NULL
    CREATE DATABASE ExerciseWeb;
GO

USE ExerciseWeb;
GO

-- Script đề 04 có thể chạy lại: xóa đúng các bảng của đề theo thứ tự khóa ngoại.
IF OBJECT_ID(N'dbo.Shares', N'U') IS NOT NULL DROP TABLE dbo.Shares;
IF OBJECT_ID(N'dbo.Favorites', N'U') IS NOT NULL DROP TABLE dbo.Favorites;
IF OBJECT_ID(N'dbo.Videos', N'U') IS NOT NULL DROP TABLE dbo.Videos;
IF OBJECT_ID(N'dbo.Category', N'U') IS NOT NULL DROP TABLE dbo.Category;
IF OBJECT_ID(N'dbo.Users', N'U') IS NOT NULL DROP TABLE dbo.Users;
GO

CREATE TABLE dbo.Users (
    Username NVARCHAR(50) NOT NULL PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15) NULL,
    Fullname NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Admin BIT NOT NULL CONSTRAINT DF_Users_Admin DEFAULT 0,
    Active BIT NOT NULL CONSTRAINT DF_Users_Active DEFAULT 0,
    Images NVARCHAR(500) NULL
);

CREATE TABLE dbo.Category (
    CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Categoryname NVARCHAR(100) NOT NULL,
    Categorycode NVARCHAR(100) NOT NULL UNIQUE,
    Images NVARCHAR(500) NULL,
    Status BIT NOT NULL CONSTRAINT DF_Category_Status DEFAULT 1
);

CREATE TABLE dbo.Videos (
    VideoId NVARCHAR(50) NOT NULL PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Poster NVARCHAR(500) NULL,
    Views INT NOT NULL CONSTRAINT DF_Videos_Views DEFAULT 0,
    Description NVARCHAR(500) NULL,
    Active BIT NOT NULL CONSTRAINT DF_Videos_Active DEFAULT 1,
    CategoryId INT NOT NULL,
    CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES dbo.Category(CategoryId)
);

CREATE TABLE dbo.Favorites (
    FavoriteId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    LikedDate DATE NOT NULL,
    VideoId NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES dbo.Videos(VideoId),
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username)
);

CREATE TABLE dbo.Shares (
    ShareId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Emails NVARCHAR(50) NOT NULL,
    SharedDate DATE NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    VideoId NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username),
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES dbo.Videos(VideoId)
);
GO

INSERT dbo.Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES
(N'admin', N'123456', N'0901000001', N'Quản trị viên', N'admin04@example.com', 1, 1, NULL),
(N'user01', N'123456', N'0901000002', N'Nguyễn Văn An', N'user01@example.com', 0, 1, NULL),
(N'user02', N'123456', N'0901000003', N'Trần Thị Bình', N'user02@example.com', 0, 1, NULL),
(N'user03', N'123456', N'0901000004', N'Lê Minh Cường', N'user03@example.com', 0, 1, NULL),
(N'user04', N'123456', N'0901000005', N'Phạm Thị Dung', N'user04@example.com', 0, 1, NULL),
(N'user05', N'123456', N'0901000006', N'Hoàng Gia Huy', N'user05@example.com', 0, 1, NULL),
(N'user06', N'123456', N'0901000007', N'Võ Ngọc Lan', N'user06@example.com', 0, 1, NULL),
(N'user07', N'123456', N'0901000008', N'Đặng Quốc Minh', N'user07@example.com', 0, 1, NULL),
(N'user08', N'123456', N'0901000009', N'Bùi Thu Nga', N'user08@example.com', 0, 1, NULL),
(N'user09', N'123456', N'0901000010', N'Đỗ Hải Nam', N'user09@example.com', 0, 1, NULL),
(N'user10', N'123456', N'0901000011', N'Ngô Kim Oanh', N'user10@example.com', 0, 1, NULL),
(N'user11', N'123456', N'0901000012', N'Dương Đức Phúc', N'user11@example.com', 0, 1, NULL),
(N'user12', N'123456', N'0901000013', N'Vũ Thanh Tâm', N'user12@example.com', 0, 1, NULL);

INSERT dbo.Category (Categoryname, Categorycode, Images, Status) VALUES
(N'Lập trình Web', N'WEB', NULL, 1),
(N'Cơ sở dữ liệu', N'DATABASE', NULL, 1),
(N'Kỹ năng mềm', N'SOFT-SKILLS', NULL, 1);

INSERT dbo.Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId) VALUES
(N'VID001', N'Nhập môn Servlet', N'https://placehold.co/600x360/0d6efd/ffffff?text=Servlet', 125, N'Giới thiệu Servlet với Jakarta EE.', 1, 1),
(N'VID002', N'JSP và JSTL căn bản', N'https://placehold.co/600x360/198754/ffffff?text=JSP+JSTL', 98, N'Hiển thị dữ liệu động bằng JSP và JSTL.', 1, 1),
(N'VID003', N'Mô hình MVC ba lớp', N'https://placehold.co/600x360/6f42c1/ffffff?text=MVC', 156, N'Tổ chức ứng dụng Web theo MVC ba lớp.', 1, 1),
(N'VID004', N'Kết nối JDBC SQL Server', N'https://placehold.co/600x360/dc3545/ffffff?text=JDBC', 210, N'Thực hành JDBC với PreparedStatement.', 1, 1),
(N'VID005', N'Thiết kế cơ sở dữ liệu', N'https://placehold.co/600x360/fd7e14/ffffff?text=Database', 87, N'Nguyên tắc thiết kế cơ sở dữ liệu quan hệ.', 1, 2),
(N'VID006', N'Truy vấn JOIN hiệu quả', N'https://placehold.co/600x360/20c997/ffffff?text=SQL+JOIN', 143, N'Sử dụng JOIN trong SQL Server.', 1, 2),
(N'VID007', N'Phân trang SQL Server', N'https://placehold.co/600x360/0dcaf0/ffffff?text=Pagination', 176, N'OFFSET và FETCH NEXT trong SQL Server.', 1, 2),
(N'VID008', N'Kỹ năng thuyết trình', N'https://placehold.co/600x360/ffc107/212529?text=Presentation', 64, N'Cách chuẩn bị một bài thuyết trình rõ ràng.', 1, 3),
(N'VID009', N'Làm việc nhóm hiệu quả', N'https://placehold.co/600x360/6610f2/ffffff?text=Teamwork', 119, N'Phối hợp và giao tiếp trong nhóm.', 1, 3),
(N'VID010', N'Quản lý thời gian', N'https://placehold.co/600x360/adb5bd/212529?text=Time', 132, N'Các phương pháp quản lý thời gian.', 1, 3);

INSERT dbo.Favorites (LikedDate, VideoId, Username) VALUES
(CAST(GETDATE() AS DATE), N'VID001', N'user01'), (CAST(GETDATE() AS DATE), N'VID001', N'user02'),
(CAST(GETDATE() AS DATE), N'VID002', N'user03'), (CAST(GETDATE() AS DATE), N'VID004', N'user04'),
(CAST(GETDATE() AS DATE), N'VID005', N'user05'), (CAST(GETDATE() AS DATE), N'VID005', N'user06'),
(CAST(GETDATE() AS DATE), N'VID007', N'user07'), (CAST(GETDATE() AS DATE), N'VID008', N'user08');

INSERT dbo.Shares (Emails, SharedDate, Username, VideoId) VALUES
(N'friend1@example.com', CAST(GETDATE() AS DATE), N'user01', N'VID001'),
(N'friend2@example.com', CAST(GETDATE() AS DATE), N'user02', N'VID001'),
(N'friend3@example.com', CAST(GETDATE() AS DATE), N'user03', N'VID003'),
(N'friend4@example.com', CAST(GETDATE() AS DATE), N'user04', N'VID005'),
(N'friend5@example.com', CAST(GETDATE() AS DATE), N'user05', N'VID007'),
(N'friend6@example.com', CAST(GETDATE() AS DATE), N'user06', N'VID009');
GO

