# ĐỀ THI GIẢ LẬP (MOCK EXAM)

**Môn thi:** Lập trình Web Java (Servlet / JSP / JSTL / JPA / SQL Server)  
**Thời gian:** 180 phút  

---

## YÊU CẦU ĐỀ BÀI: XÂY DỰNG MODULE QUẢN LÝ SẢN PHẨM (PRODUCT MANAGEMENT)

### 1. Cơ sở dữ liệu (Microsoft SQL Server)
Tạo bảng `dbo.products` thuộc database `ExerciseWeb`:
- `id`: Số nguyên tự tăng (INT IDENTITY(1,1)), Khóa chính (PRIMARY KEY).
- `name`: Tên sản phẩm, kiểu `NVARCHAR(255)`, bắt buộc nhập (NOT NULL).
- `price`: Đơn giá sản phẩm, kiểu số thực `FLOAT` hoặc `DECIMAL(18,2)`.
- `quantity`: Số lượng tồn kho, kiểu số nguyên `INT`.
- `description`: Mô tả chi tiết, kiểu `NVARCHAR(MAX)`.
- `status`: Trạng thái kinh doanh, kiểu `INT` (1: Đang bán / Kích hoạt, 0: Tạm ngừng).
- `category_id`: Khóa ngoại tham chiếu đến bảng `categories(CategoryId)` (Cho phép NULL).

Chèn sẵn tối thiểu 5 dòng dữ liệu mẫu vào bảng `dbo.products`.

---

### 2. Kiến trúc & Công nghệ
- Sử dụng mô hình MVC 3-Tier:
  - **Entity:** `vn.iotstar.entity.Product` ánh xạ JPA Hibernate.
  - **DAO:** `IProductDao` và `ProductDao` sử dụng `EntityManager` từ `JpaConfig`.
  - **Service:** `IProductService` và `ProductServiceImpl`.
  - **Controller:** `ProductServlet` (HttpServlet mapped tại `/product-exam` hoặc `/product`).
  - **View:** Các trang JSP trong `src/main/webapp/views/product-exam/` hoặc tương đương.
  - **Giao diện:** Chuẩn Bootstrap 5.3.3 + SiteMesh Decorator 3.

---

### 3. Các chức năng bắt buộc
1. **Hiển thị danh sách (List):**
   - Xem toàn bộ danh sách sản phẩm dạng bảng (Table).
   - Hiển thị đầy đủ: ID, Tên sản phẩm, Danh mục, Đơn giá, Số lượng, Trạng thái (Badge xanh/đỏ).
   - Nút hành động: Xem chi tiết (Detail), Chỉnh sửa (Edit), Xóa (Delete).
2. **Thêm mới sản phẩm (Add / Insert):**
   - Form nhập thông tin sản phẩm.
   - Dropdown chọn Danh mục từ CSDL.
   - Nút Lưu (Save) và Hủy bỏ (Cancel).
3. **Chỉnh sửa sản phẩm (Edit / Update):**
   - Điền sẵn dữ liệu cũ của sản phẩm vào form theo ID.
   - Cập nhật thành công chuyển hướng về danh sách và hiển thị thông báo.
4. **Xóa sản phẩm (Delete):**
   - Bấm nút Xóa kèm hộp thoại xác nhận (Confirm popup).
   - Xóa xong chuyển về trang danh sách.
5. **Xem chi tiết sản phẩm (Detail):**
   - Hiển thị đầy đủ thông tin sản phẩm trong Bootstrap Card.
   - Nút quay lại danh sách.
6. **Tìm kiếm (Search):**
   - Ô tìm kiếm theo Tên sản phẩm (name LIKE '%keyword%').
   - Giữ lại từ khóa trong ô tìm kiếm sau khi submit.
7. **Validation dữ liệu (Kiểm tra hợp lệ):**
   - `name`: Bắt buộc nhập, không được để trống hoặc chỉ có khoảng trắng.
   - `price`: Phải là số thực và có giá trị `>= 0`.
   - `quantity`: Phải là số nguyên và có giá trị `>= 0`.
   - Khi dữ liệu không hợp lệ: Không thêm/sửa vào DB, giữ lại dữ liệu người dùng vừa nhập, hiển thị thông báo lỗi rõ ràng trên form mà không làm ứng dụng bị crash (không văng lỗi 500).
