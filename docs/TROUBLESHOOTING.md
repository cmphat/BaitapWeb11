# TROUBLESHOOTING GUIDE (XỬ LÝ LỖI THỰC TẾ)

Hướng dẫn giải quyết các sự cố thường gặp nhất trong quá trình làm bài thi trên dự án `Exercise`.

---

## 1. CỔNG 8080 ĐÃ BỊ CHIẾM (PORT 8080 ALREADY IN USE)
**Dấu hiệu:** Tomcat báo `Address already in use: bind` hoặc không start được.
**Cách xử lý trên Windows:**
```powershell
# 1. Tìm PID đang chiếm cổng 8080
netstat -ano | findstr :8080

# 2. Giả sử PID tìm được là 1234, tắt tiến trình đó:
taskkill /F /PID 1234
```
*Cách đổi cổng dự phòng:* Mở `E:\Web\Tool\apache-tomcat-10.1.44\conf\server.xml`, đổi `<Connector port="8080"` thành `8088`.

---

## 2. SQL SERVER CONNECTION REFUSED (KHÔNG KẾT NỐI ĐƯỢC CSDL)
**Dấu hiệu:** `The TCP/IP connection to the host localhost, port 1433 has failed.`
**Cách xử lý:**
```powershell
# 1. Kiểm tra trạng thái service
Get-Service MSSQLSERVER

# 2. Khởi động lại service
Restart-Service MSSQLSERVER
```
*Lưu ý:* Kiểm tra trong SQL Server Configuration Manager xem giao thức `TCP/IP` của SQL Server Network Configuration đã được `Enabled` hay chưa.

---

## 3. LOGIN FAILED FOR USER 'SA' (SAI MẬT KHẨU HOẶC QUYỀN SQL SERVER)
**Dấu hiệu:** `Login failed for user 'sa'. ClientConnectionId:...`
**Cách xử lý:**
- Mật khẩu mặc định trong code dự án là `1504`.
- Nếu máy thi dùng mật khẩu khác (ví dụ: `123456`, `root`, `123`):
  1. Cập nhật `src/main/resources/META-INF/persistence.xml` (property `jakarta.persistence.jdbc.password`).
  2. Cập nhật `src/main/java/vn/iotstar/connection/DBConnection.java` (biến `PASSWORD`).
  3. Rebuild lại project (`mvn compile`).

---

## 4. LỖI 404 NOT FOUND KHI TRUY CẬP SERVLET
**Dấu hiệu:** Trình duyệt báo `HTTP Status 404 – Not Found`.
**Nguyên nhân & Cách sửa:**
1. **Thiếu Context Path:** Phải có `/Exercise` phía trước. Ví dụ đúng: `http://localhost:8080/Exercise/sample`, không phải `http://localhost:8080/sample`.
2. **Sai URL Mapping trong Servlet:** Kiểm tra annotation `@WebServlet(urlPatterns = {"/sample", "/sample/*"})`.
3. **Forward nhầm file JSP:** Kiểm tra đường dẫn trong `req.getRequestDispatcher("/views/sample/sample-list.jsp")`. Đảm bảo file JSP thực sự nằm tại `src/main/webapp/views/sample/sample-list.jsp`.

---

## 5. LỖI JSTL TAGLIB (JASPER COMPILATION ERROR)
**Dấu hiệu:** `The absolute uri: [http://java.sun.com/jsp/jstl/core] cannot be resolved in either web.xml or the jar files`
**Nguyên nhân:** Dự án sử dụng **Tomcat 10.1** và **Jakarta EE 10**, KHÔNG sử dụng taglib JSTL cũ của Java EE.
**Cách sửa:**
- Trên đầu tất cả các file JSP, luôn khai báo:
  ```jsp
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
  <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
  ```
- TUYỆT ĐỐI KHÔNG DÙNG: `http://java.sun.com/jsp/jstl/core`.

---

## 6. LỖI FONT TIẾNG VIỆT BỊ HỎNG / DẤU HỎI CHẤM (???)
**Dấu hiệu:** Dữ liệu tiếng Việt nhập từ form hoặc lưu vào CSDL hiển thị thành `???` hoặc ký tự rác.
**Cách xử lý:**
1. Đảm bảo file `src/main/java/vn/iotstar/filter/EncodingFilter.java` đã được đăng ký và chạy trước mọi filter khác trong `web.xml`.
2. Trên đầu mỗi trang JSP phải có:
   ```jsp
   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   ```
3. Trong SQL Server, cột văn bản tiếng Việt phải dùng kiểu `NVARCHAR`, và khi viết câu lệnh INSERT trực tiếp phải có tiền tố `N`: `INSERT INTO ... VALUES (N'Tiếng Việt')`.

---

## 7. TABLE NOT FOUND HOẶC COLUMN NOT FOUND TRONG HIBERNATE
**Dấu hiệu:** `SQLServerException: Invalid object name 'dbo.samples'` hoặc `Invalid column name 'category_id'`.
**Cách xử lý:**
1. Kiểm tra annotation `@Table(name = "samples")` và `@Column(name = "category_id")` trong Entity.
2. Kiểm tra `database/exam_template.sql` xem bảng và cột đã được tạo trong database `ExerciseWeb` chưa.
3. Chạy `database/exam_template.sql` qua `sqlcmd` hoặc SSMS.

---

## 8. NUMBERFORMATEXCEPTION KHI ĐỌC THAM SỐ TỪ REQUEST
**Dấu hiệu:** Servlet bị crash khi gọi `Integer.parseInt(req.getParameter("id"))` vì tham số bị null hoặc rỗng.
**Cách xử lý an toàn:**
```java
String idStr = req.getParameter("id");
if (idStr != null && !idStr.trim().isEmpty()) {
    try {
        int id = Integer.parseInt(idStr.trim());
        // xử lý tiếp
    } catch (NumberFormatException e) {
        req.setAttribute("errorMessage", "ID không hợp lệ!");
        req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        return;
    }
}
```

---

## 9. NULLPOINTEREXCEPTION TRÊN JSP HOẶC SERVLET
**Dấu hiệu:** `java.lang.NullPointerException: Cannot invoke ... because "sample" is null`
**Cách xử lý:**
- Khi tìm kiếm theo ID, luôn kiểm tra xem đối tượng có tồn tại không trước khi đưa sang JSP:
  ```java
  Sample sample = sampleService.findById(id);
  if (sample == null) {
      req.setAttribute("errorMessage", "Bản ghi không tồn tại!");
      req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
      return;
  }
  ```
- Trên JSP, dùng toán tử rỗng của EL hoặc thẻ `<c:if>`:
  ```jsp
  <c:choose>
      <c:when test="${not empty sample.category}">
          ${sample.category.categoryname}
      </c:when>
      <c:otherwise>Không có</c:otherwise>
  </c:choose>
  ```

---

## 10. MAVEN COMPILER LỖI RELEASE 26 TRÊN MÁY THI
**Dấu hiệu:** `Fatal error compiling: error: release version 26 not supported` (do máy thi chỉ cài JDK 17 hoặc JDK 21).
**Cách xử lý nhanh trong 30 giây:**
Mở `pom.xml`, sửa:
```xml
<properties>
    <!-- Đổi 26 thành phiên bản Java của máy thi, ví dụ 17 hoặc 21 -->
    <maven.compiler.release>17</maven.compiler.release>
</properties>
```
Đồng thời cập nhật plugin compiler trong `pom.xml`:
```xml
<configuration>
    <release>17</release>
</configuration>
```
Chạy lại: `mvn clean compile`.
