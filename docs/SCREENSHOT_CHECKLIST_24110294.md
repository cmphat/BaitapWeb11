# SCREENSHOT CHECKLIST - ĐỀ 04 - 24110294

Mọi ảnh chụp cần hiển thị rõ tên file, package và toàn bộ phần code liên quan.

## Câu 1 - MVC 3 lớp và SiteMesh
- `src/main/webapp/WEB-INF/sitemesh3.xml`
- `src/main/webapp/WEB-INF/decorators/user.jsp`
- `src/main/webapp/WEB-INF/decorators/admin.jsp`
- `src/main/java/vn/iotstar/controller/HomeController_24110294.java`

## Câu 2 - Session, đăng ký, OTP, đăng nhập
- `src/main/java/vn/iotstar/dao/IUserDao_24110294.java`
- `src/main/java/vn/iotstar/dao/impl/UserDao_24110294.java`
- `src/main/java/vn/iotstar/service/IUserService_24110294.java`
- `src/main/java/vn/iotstar/service/impl/UserService_24110294.java`
- `src/main/java/vn/iotstar/controller/LoginController_24110294.java`
- `src/main/java/vn/iotstar/controller/RegisterController_24110294.java`
- `src/main/java/vn/iotstar/controller/VerifyOtpController_24110294.java`
- `src/main/java/vn/iotstar/controller/ResendOtpController_24110294.java`
- `src/main/java/vn/iotstar/controller/LogoutController_24110294.java`
- `src/main/webapp/views/exam04/auth/login.jsp`, `register.jsp`, `verify-otp.jsp`

## Câu 3 - CRUD Users, 6 users/trang
- `src/main/java/vn/iotstar/controller/UserController_24110294.java`
- `src/main/java/vn/iotstar/filter/AdminFilter_24110294.java`
- `src/main/webapp/views/exam04/admin/users/list.jsp`, `form.jsp`, `detail.jsp`
- Các file DAO và Service của User ở Câu 2.

## Câu 4 - Chi tiết Video
- `src/main/java/vn/iotstar/model/VideoDetail_24110294.java`
- `src/main/java/vn/iotstar/dao/impl/VideoDao_24110294.java`
- `src/main/java/vn/iotstar/service/impl/VideoService_24110294.java`
- `src/main/java/vn/iotstar/controller/VideoDetailController_24110294.java`
- `src/main/webapp/views/exam04/videos/detail.jsp`

## Câu 5 - Video theo Category, 3 videos/trang
- `src/main/java/vn/iotstar/controller/VideoController_24110294.java`
- `src/main/java/vn/iotstar/dao/impl/VideoDao_24110294.java`
- `src/main/webapp/views/exam04/videos/list.jsp`

## Câu 6 - Đếm Video theo Category
- `src/main/java/vn/iotstar/dao/impl/CategoryDao_24110294.java`
- `src/main/java/vn/iotstar/service/impl/CategoryService_24110294.java`
- Heading và tab count trong `src/main/webapp/views/exam04/videos/list.jsp`

## Database
- `database/exam_04_24110294.sql`

## Giao diện và asset
- `src/main/webapp/assets/css/exam04.css`
- `src/main/webapp/assets/images/posters/`
- `src/main/webapp/assets/images/categories/`
- `src/main/webapp/assets/images/avatars/`
