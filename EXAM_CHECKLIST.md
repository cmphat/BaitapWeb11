# EXAM CHECKLIST (BẢNG KIỂM TRA BÀI THI)

---

## 1. BEFORE EXAM (TRƯỚC GIỜ THI)
- [ ] Java hoạt động (`java -version` -> hiển thị đúng JDK 26 hoặc JDK máy thi)
- [ ] Maven hoạt động (`mvn -version` -> hiển thị Maven 3.9+)
- [ ] Tomcat hoạt động (Tomcat 10.1 có thể start/stop bình thường)
- [ ] Database service hoạt động (SQL Server service `MSSQLSERVER` đang running)
- [ ] Database `ExerciseWeb` kết nối được bằng tài khoản `sa` / `1504`
- [ ] Project build thành công (`mvn clean package -DskipTests` -> BUILD SUCCESS)
- [ ] Project chạy được trên Tomcat và mở được trang chủ: `http://localhost:8080/Exercise/`
- [ ] Trang mẫu `/sample` hiển thị danh sách 15 dòng dữ liệu test
- [ ] Git backup tồn tại (tag `before-exam-template` và tag `exam-ready` đã tạo)
- [ ] File `PROJECT_CONTEXT.md` đã sẵn sàng
- [ ] File `EXAM_PROMPT.md` đã sẵn sàng

---

## 2. AFTER RECEIVING EXAM (KHI NHẬN ĐỀ THI)
- [ ] Đọc lướt toàn bộ đề thi 1 lần để nắm yêu cầu tổng thể
- [ ] Dán toàn bộ nội dung đề thi vào phần `[PASTE QUESTION HERE]` trong `EXAM_PROMPT.md`
- [ ] Xác định danh sách các Entity cần quản lý
- [ ] Xác định các mối quan hệ (1-1, 1-N, N-N)
- [ ] Xác định các chức năng CRUD được yêu cầu
- [ ] Xác định yêu cầu Tìm kiếm (Search), Lọc (Filter), Phân trang (Pagination)
- [ ] Xác định ràng buộc dữ liệu & validation (not null, min, format, duplicate)
- [ ] Chạy AI để thực hiện chuyển đổi từ mẫu `Sample` sang Entity của đề thi
- [ ] Kiểm tra lại danh sách các file AI đã thay đổi
- [ ] Chạy lệnh build: `mvn clean compile`
- [ ] Chạy ứng dụng và kiểm thử các tính năng:
  - [ ] Hiển thị danh sách (List)
  - [ ] Thêm mới (Add / Insert)
  - [ ] Chỉnh sửa (Edit / Update)
  - [ ] Xem chi tiết (Detail)
  - [ ] Xóa (Delete)
  - [ ] Tìm kiếm (Search)
  - [ ] Validation hiển thị lỗi đúng, không làm crash ứng dụng
- [ ] Kiểm tra dữ liệu thực tế trong bảng SQL Server đã thay đổi tương ứng
- [ ] Chạy build sạch lần cuối: `mvn clean package -DskipTests`

---

## 3. BEFORE SUBMIT (TRƯỚC KHI NỘP BÀI)
- [ ] Không còn lỗi compile (`mvn compile` hoàn tất không lỗi)
- [ ] Không xuất hiện lỗi HTTP 500 hoặc stack trace ra giao diện người dùng
- [ ] Không có liên kết chết (broken links / 404)
- [ ] Đã export / lưu script tạo CSDL (`database/exam_db.sql`) kèm dữ liệu mẫu
- [ ] Chụp đầy đủ ảnh màn hình các chức năng nếu đề thi yêu cầu
- [ ] Nén đúng thư mục dự án theo quy định của giám thị / giảng viên
- [ ] Kiểm tra dung lượng file nộp (xóa thư mục `target/` trước khi nén để file nhẹ)
