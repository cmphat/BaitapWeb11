# FILE UPLOAD TEMPLATE (JAKARTA SERVLET 6 @MultipartConfig)

Tài liệu mẫu cho chức năng Upload file ảnh/tệp tin trong bài thi Java Web.

---

## 1. ANNOTATION TRÊN SERVLET
Bắt buộc phải thêm `@MultipartConfig` trên đầu Servlet xử lý upload:
```java
@WebServlet(urlPatterns = {"/upload-example"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,       // 1 MB buffer tạm trong RAM
    maxFileSize = 5 * 1024 * 1024,        // Tối đa 5 MB cho 1 file
    maxRequestSize = 10 * 1024 * 1024     // Tối đa 10 MB cho toàn bộ request
)
public class UploadServlet extends HttpServlet {
    // ...
}
```

---

## 2. XỬ LÝ LƯU FILE TRONG `doPost`
```java
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
        throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    // Lấy Part từ form
    Part filePart = req.getPart("image"); // name của thẻ <input type="file">
    String fileName = null;

    if (filePart != null && filePart.getSize() > 0) {
        // Lấy tên file gốc
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Tạo tên file ngẫu nhiên để chống trùng lặp
        String extension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            extension = originalFileName.substring(dotIndex);
        }
        fileName = System.currentTimeMillis() + extension;

        // Thư mục lưu trữ: webapp/uploads
        String uploadDir = req.getServletContext().getRealPath("/uploads");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Lưu file vào đĩa
        filePart.write(uploadDir + File.separator + fileName);
    }

    // Lưu tên file vào Entity / Database
    // entity.setImages(fileName);
}
```

---

## 3. FORM GIAO DIỆN TRÊN JSP
```jsp
<form action="${pageContext.request.contextPath}/upload-example" method="post" enctype="multipart/form-data">
    <div class="mb-3">
        <label for="image" class="form-label">Chọn hình ảnh</label>
        <input class="form-control" type="file" id="image" name="image" accept="image/*">
    </div>
    <button type="submit" class="btn btn-primary">Tải lên</button>
</form>

<!-- Hiển thị ảnh đã upload -->
<c:if test="${not empty entity.images}">
    <img src="${pageContext.request.contextPath}/uploads/${entity.images}" class="img-thumbnail" width="150">
</c:if>
```
