USE master;
GO
IF DB_ID(N'ExerciseWeb') IS NULL CREATE DATABASE ExerciseWeb;
GO
USE ExerciseWeb;
GO

/* ĐỀ 04 - 24110294. Idempotent: không DROP/RENAME/đổi khóa hoặc kiểu cột gốc. */
IF OBJECT_ID(N'dbo.Users', N'U') IS NULL
BEGIN
 CREATE TABLE dbo.Users (Username NVARCHAR(50) NOT NULL PRIMARY KEY, Password NVARCHAR(50) NULL,
 Phone NVARCHAR(15) NULL, Fullname NVARCHAR(50) NULL, Email NVARCHAR(150) NULL,
 Admin BIT NULL, Active BIT NULL, Images NVARCHAR(500) NULL);
END;
GO
IF OBJECT_ID(N'dbo.Category', N'U') IS NULL
BEGIN
 CREATE TABLE dbo.Category (CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 Categoryname NVARCHAR(100) NULL, Categorycode NVARCHAR(100) NULL,
 Images NVARCHAR(500) NULL, Status BIT NULL);
END;
GO
IF OBJECT_ID(N'dbo.Videos', N'U') IS NULL
BEGIN
 CREATE TABLE dbo.Videos (VideoId NVARCHAR(50) NOT NULL PRIMARY KEY, Title NVARCHAR(200) NULL,
 Poster NVARCHAR(50) NULL, Views INT NULL, Description NVARCHAR(500) NULL, Active BIT NULL,
 CategoryId INT NULL, CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES dbo.Category(CategoryId));
END;
GO
IF OBJECT_ID(N'dbo.Favorites', N'U') IS NULL
BEGIN
 CREATE TABLE dbo.Favorites (FavoriteId INT IDENTITY(1,1) NOT NULL PRIMARY KEY, LikedDate DATE NULL,
 VideoId NVARCHAR(50) NULL, Username NVARCHAR(50) NULL,
 CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES dbo.Videos(VideoId),
 CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username));
END;
GO
IF OBJECT_ID(N'dbo.Shares', N'U') IS NULL
BEGIN
 CREATE TABLE dbo.Shares (ShareId INT IDENTITY(1,1) NOT NULL PRIMARY KEY, Emails NVARCHAR(50) NULL,
 SharedDate DATE NULL, Username NVARCHAR(50) NULL, VideoId NVARCHAR(50) NULL,
 CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username),
 CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES dbo.Videos(VideoId));
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Username=N'admin')
 INSERT dbo.Users VALUES (N'admin',N'123456',N'0901000001',N'Quản trị viên',N'admin04@example.com',1,1,NULL);
DECLARE @u INT=1;
WHILE @u<=12
BEGIN
 DECLARE @username NVARCHAR(50)=N'user'+RIGHT(N'0'+CAST(@u AS NVARCHAR(2)),2);
 IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Username=@username)
  INSERT dbo.Users (Username,Password,Phone,Fullname,Email,Admin,Active,Images)
  VALUES (@username,N'123456',N'09010000'+RIGHT(N'0'+CAST(@u+1 AS NVARCHAR(2)),2),N'Người dùng '+CAST(@u AS NVARCHAR(2)),@username+N'@example.com',0,1,NULL);
 SET @u=@u+1;
END;
UPDATE dbo.Users SET Fullname=N'Quản trị viên',Admin=1,Active=1,Images=N'assets/images/avatars/avatar_01.png' WHERE Username=N'admin';
UPDATE dbo.Users SET Fullname=N'Nguyễn Văn An',Images=N'assets/images/avatars/avatar_02.png' WHERE Username=N'user01';
UPDATE dbo.Users SET Fullname=N'Trần Thị Bình',Images=N'assets/images/avatars/avatar_03.png' WHERE Username=N'user02';
UPDATE dbo.Users SET Fullname=N'Lê Minh Cường',Images=N'assets/images/avatars/avatar_04.png' WHERE Username=N'user03';
UPDATE dbo.Users SET Fullname=N'Phạm Thị Dung',Images=N'assets/images/avatars/avatar_05.png' WHERE Username=N'user04';
UPDATE dbo.Users SET Fullname=N'Hoàng Gia Huy',Images=N'assets/images/avatars/avatar_06.png' WHERE Username=N'user05';
UPDATE dbo.Users SET Fullname=N'Võ Ngọc Lan',Images=N'assets/images/avatars/avatar_07.png' WHERE Username=N'user06';
UPDATE dbo.Users SET Fullname=N'Đặng Quốc Minh',Images=N'assets/images/avatars/avatar_08.png' WHERE Username=N'user07';
UPDATE dbo.Users SET Fullname=N'Bùi Thu Nga',Images=N'assets/images/avatars/avatar_09.png' WHERE Username=N'user08';
UPDATE dbo.Users SET Fullname=N'Đỗ Hải Nam',Images=N'assets/images/avatars/avatar_10.png' WHERE Username=N'user09';
UPDATE dbo.Users SET Fullname=N'Ngô Kim Oanh',Images=N'assets/images/avatars/avatar_11.png' WHERE Username=N'user10';
UPDATE dbo.Users SET Fullname=N'Dương Đức Phúc',Images=N'assets/images/avatars/avatar_12.png' WHERE Username=N'user11';
UPDATE dbo.Users SET Fullname=N'Vũ Thanh Tâm',Images=N'assets/images/avatars/avatar_13.png' WHERE Username=N'user12';
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Category WHERE Categorycode=N'WEB')
 INSERT dbo.Category VALUES (N'Lập trình Web',N'WEB',N'assets/images/categories/category_technology.jpg',1);
IF NOT EXISTS (SELECT 1 FROM dbo.Category WHERE Categorycode=N'DATABASE')
 INSERT dbo.Category VALUES (N'Cơ sở dữ liệu',N'DATABASE',N'assets/images/categories/category_photography.jpg',1);
IF NOT EXISTS (SELECT 1 FROM dbo.Category WHERE Categorycode=N'SOFT-SKILLS')
 INSERT dbo.Category VALUES (N'Kỹ năng mềm',N'SOFT-SKILLS',N'assets/images/categories/category_travel.jpg',1);
IF NOT EXISTS (SELECT 1 FROM dbo.Category WHERE Categorycode=N'JAVA')
 INSERT dbo.Category VALUES (N'Công nghệ Java',N'JAVA',N'assets/images/categories/category_food.jpg',1);
UPDATE dbo.Category SET Categoryname=N'Lập trình Web',Images=N'assets/images/categories/category_technology.jpg',Status=1 WHERE Categorycode=N'WEB';
UPDATE dbo.Category SET Categoryname=N'Cơ sở dữ liệu',Images=N'assets/images/categories/category_photography.jpg',Status=1 WHERE Categorycode=N'DATABASE';
UPDATE dbo.Category SET Categoryname=N'Kỹ năng mềm',Images=N'assets/images/categories/category_travel.jpg',Status=1 WHERE Categorycode=N'SOFT-SKILLS';
UPDATE dbo.Category SET Categoryname=N'Công nghệ Java',Images=N'assets/images/categories/category_food.jpg',Status=1 WHERE Categorycode=N'JAVA';
GO

DECLARE @VideoSeed TABLE (VideoId NVARCHAR(50),Title NVARCHAR(200),Views INT,Description NVARCHAR(500),Categorycode NVARCHAR(100));
INSERT @VideoSeed VALUES
(N'VID001',N'Nhập môn Servlet',125,N'Giới thiệu Servlet và vòng đời xử lý request trong Jakarta EE.',N'WEB'),
(N'VID002',N'JSP và JSTL căn bản',98,N'Hiển thị dữ liệu động bằng JSP, EL và thư viện thẻ JSTL.',N'WEB'),
(N'VID003',N'Mô hình MVC ba lớp',156,N'Tổ chức ứng dụng Web rõ ràng theo Controller, Service và DAO.',N'WEB'),
(N'VID004',N'Xử lý Form và Validation',210,N'Tiếp nhận, kiểm tra và phản hồi dữ liệu biểu mẫu an toàn.',N'WEB'),
(N'VID005',N'Kết nối JDBC với SQL Server',87,N'Tạo kết nối JDBC và quản lý tài nguyên bằng try-with-resources.',N'DATABASE'),
(N'VID006',N'Thiết kế DAO Pattern',143,N'Tách mã truy xuất dữ liệu khỏi nghiệp vụ bằng DAO Pattern.',N'DATABASE'),
(N'VID007',N'Truy vấn JOIN hiệu quả',176,N'Kết hợp nhiều bảng và tối ưu truy vấn JOIN trong SQL Server.',N'DATABASE'),
(N'VID008',N'Phân trang dữ liệu',64,N'Phân trang với ORDER BY, OFFSET và FETCH NEXT.',N'DATABASE'),
(N'VID009',N'Kỹ năng thuyết trình',119,N'Chuẩn bị nội dung và trình bày bài làm rõ ràng, mạch lạc.',N'SOFT-SKILLS'),
(N'VID010',N'Làm việc nhóm hiệu quả',132,N'Phối hợp, phân công và giao tiếp hiệu quả trong nhóm.',N'SOFT-SKILLS'),
(N'VID011',N'Quản lý thời gian',105,N'Lập kế hoạch và ưu tiên công việc trong quá trình phát triển.',N'SOFT-SKILLS'),
(N'VID012',N'Kỹ năng giải quyết vấn đề',94,N'Phân tích nguyên nhân và lựa chọn giải pháp phù hợp.',N'SOFT-SKILLS'),
(N'VID013',N'Session và Authentication',188,N'Quản lý đăng nhập và trạng thái người dùng bằng Session.',N'JAVA'),
(N'VID014',N'SiteMesh Decorator',116,N'Tái sử dụng header, navbar và footer bằng SiteMesh.',N'JAVA'),
(N'VID015',N'CRUD với Servlet',169,N'Xây dựng đầy đủ chức năng thêm, xem, sửa và xóa.',N'JAVA'),
(N'VID016',N'Ứng dụng MVC hoàn chỉnh',231,N'Hoàn thiện ứng dụng Java Web theo mô hình MVC ba lớp.',N'JAVA');
MERGE dbo.Videos AS target
USING (SELECT s.VideoId,s.Title,N'/assets/images/posters/poster_'+LOWER(s.VideoId)+N'.jpg' Poster,
 s.Views,s.Description,c.CategoryId FROM @VideoSeed s JOIN dbo.Category c ON c.Categorycode=s.Categorycode) source
ON target.VideoId=source.VideoId
WHEN MATCHED THEN UPDATE SET Title=source.Title,Poster=source.Poster,Description=source.Description,Active=1,CategoryId=source.CategoryId
WHEN NOT MATCHED THEN INSERT (VideoId,Title,Poster,Views,Description,Active,CategoryId)
 VALUES (source.VideoId,source.Title,source.Poster,source.Views,source.Description,1,source.CategoryId);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Favorites WHERE VideoId=N'VID001' AND Username=N'user01') INSERT dbo.Favorites VALUES (CAST(GETDATE() AS DATE),N'VID001',N'user01');
IF NOT EXISTS (SELECT 1 FROM dbo.Favorites WHERE VideoId=N'VID001' AND Username=N'user02') INSERT dbo.Favorites VALUES (CAST(GETDATE() AS DATE),N'VID001',N'user02');
IF NOT EXISTS (SELECT 1 FROM dbo.Favorites WHERE VideoId=N'VID002' AND Username=N'user03') INSERT dbo.Favorites VALUES (CAST(GETDATE() AS DATE),N'VID002',N'user03');
IF NOT EXISTS (SELECT 1 FROM dbo.Favorites WHERE VideoId=N'VID005' AND Username=N'user05') INSERT dbo.Favorites VALUES (CAST(GETDATE() AS DATE),N'VID005',N'user05');
IF NOT EXISTS (SELECT 1 FROM dbo.Shares WHERE VideoId=N'VID001' AND Username=N'user01') INSERT dbo.Shares VALUES (N'friend1@example.com',CAST(GETDATE() AS DATE),N'user01',N'VID001');
IF NOT EXISTS (SELECT 1 FROM dbo.Shares WHERE VideoId=N'VID001' AND Username=N'user02') INSERT dbo.Shares VALUES (N'friend2@example.com',CAST(GETDATE() AS DATE),N'user02',N'VID001');
IF NOT EXISTS (SELECT 1 FROM dbo.Shares WHERE VideoId=N'VID003' AND Username=N'user03') INSERT dbo.Shares VALUES (N'friend3@example.com',CAST(GETDATE() AS DATE),N'user03',N'VID003');
GO

-- Bảng phụ phục vụ thống kê hành vi; không thay đổi cấu trúc các bảng cốt lõi của đề.
IF OBJECT_ID(N'dbo.VideoInteractions_24110294', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.VideoInteractions_24110294 (
        InteractionId BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Username NVARCHAR(50) NULL,
        VideoId NVARCHAR(50) NOT NULL,
        ActionType NVARCHAR(20) NOT NULL,
        SessionId NVARCHAR(100) NULL,
        ActionAt DATETIME2 NOT NULL CONSTRAINT DF_VideoInteractions_24110294_ActionAt DEFAULT SYSDATETIME(),
        CONSTRAINT FK_VideoInteractions_24110294_Users FOREIGN KEY (Username) REFERENCES dbo.Users(Username),
        CONSTRAINT FK_VideoInteractions_24110294_Videos FOREIGN KEY (VideoId) REFERENCES dbo.Videos(VideoId)
    );
    CREATE INDEX IX_VideoInteractions_24110294_Video_Action
        ON dbo.VideoInteractions_24110294 (VideoId, ActionType, ActionAt DESC);
END;
GO
