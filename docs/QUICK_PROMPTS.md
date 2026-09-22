# QUICK PROMPTS (CÁC PROMPT DÙNG NHANH TRONG PHÒNG THI)

Copy và paste các prompt dưới đây trực tiếp vào chat với AI khi cần xử lý nhanh từng tình huống cụ thể trong phòng thi.

---

### 1. Tạo CRUD cho một Entity mới hoàn toàn
> "Read PROJECT_CONTEXT.md. Create a full CRUD module for entity `[EntityName]` (fields: `[field1, field2, ...]`) following the exact pattern of `Sample` (Entity, DAO, Service, Servlet, and JSPs in `views/[entity-name]/`). Update `persistence.xml`. Build project after changes."

---

### 2. Thêm một trường (field) mới vào Entity hiện có
> "Read PROJECT_CONTEXT.md. Add field `[fieldName]` of type `[type]` to entity `[EntityName]`. Update database table `[tableName]`, update DAO queries/mappings, update controller parameters, and update form/table in JSP. Build to verify."

---

### 3. Tạo bảng mới trong CSDL
> "Read PROJECT_CONTEXT.md. Write a SQL Server script to create table `dbo.[tableName]` with columns `[col1, col2, ...]`, primary key IDENTITY(1,1), and foreign key referencing `[parentTable]`. Provide insert script with 5 sample rows."

---

### 4. Thiết lập quan hệ 1 - N (One-to-Many / Many-to-One)
> "Read PROJECT_CONTEXT.md. Set up a 1-N relationship between `[ParentEntity]` and `[ChildEntity]` via foreign key `[fk_column]`. Update JPA annotations (`@ManyToOne`, `@JoinColumn`), DAO query, and JSP dropdown in form. Build after changes."

---

### 5. Thêm tính năng Tìm kiếm (Search)
> "Read PROJECT_CONTEXT.md. Add search functionality by `[fieldName]` to `[EntityServlet]`. Use case-insensitive JPQL LIKE query in DAO. Keep search keyword retained in JSP search input. Build after changes."

---

### 6. Thêm bộ lọc dữ liệu (Filter)
> "Read PROJECT_CONTEXT.md. Add filter by `[filterProperty]` (e.g. status or category) to `[EntityServlet]`. Provide dropdown filter in JSP list page that auto-submits on change. Preserve filter state. Build after changes."

---

### 7. Thêm phân trang (Pagination)
> "Read PROJECT_CONTEXT.md. Implement simple pagination (page number, size = 5) for `[EntityName]` using JPQL `setFirstResult` and `setMaxResults`. Add Bootstrap pagination links (Previous, page numbers, Next) to the JSP list page. Build after changes."

---

### 8. Thêm Validation dữ liệu cho Form
> "Read PROJECT_CONTEXT.md. Add server-side validation for `[EntityName]` in `[EntityServlet]`: check `[field1]` is not empty, `[field2]` is a positive number, `[field3]` is valid email. If invalid, retain user inputs and display error message on JSP without crashing."

---

### 9. Thêm bảo vệ Login / Session cho chức năng
> "Read PROJECT_CONTEXT.md. Protect URL `[urlPattern]` so only logged-in users with role `[roleid]` can access it. Check session `account`. If not logged in, redirect to `/login`. If unauthorized, show access denied error in `views/error.jsp`."

---

### 10. Chỉnh sửa giao diện JSP
> "Read PROJECT_CONTEXT.md. Improve the layout of `views/[jspFile].jsp` using Bootstrap 5. Ensure it uses SiteMesh decorator, displays proper table formatting, status badges, and action buttons. Keep all JSTL tags working."

---

### 11. Sửa lỗi Build Maven
> "Read PROJECT_CONTEXT.md. Maven build failed with error: `[paste error message]`. Diagnose the exact missing import, syntax, or configuration error and fix it immediately. Run `mvn compile` to confirm."

---

### 12. Sửa lỗi Database / Hibernate Exception
> "Read PROJECT_CONTEXT.md. Database connection or Hibernate query threw exception: `[paste exception]`. Check `persistence.xml`, table schema in SQL Server, and JPQL query syntax. Fix the issue and test."

---

### 13. Sửa lỗi 404 Not Found trên Servlet
> "Read PROJECT_CONTEXT.md. Requesting `[URL]` returns 404. Check `@WebServlet` urlPatterns, `web.xml`, and context path. Ensure request forward or redirect URL matches exactly."

---

### 14. Sửa lỗi JSTL Taglib
> "Read PROJECT_CONTEXT.md. JSP page throws JasperException or JSTL tags `<c:...>` are not recognized. Verify `jakarta.tags.core` taglib URI and JSTL dependencies in `pom.xml`."

---

### 15. Sửa lỗi hiển thị tiếng Việt (Encoding UTF-8)
> "Read PROJECT_CONTEXT.md. Vietnamese text is displayed as `???` or garbled characters. Check `EncodingFilter`, request/response character encoding, and JSP page directive `contentType=\"text/html; charset=UTF-8\"`."
