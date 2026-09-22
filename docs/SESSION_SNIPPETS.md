# SESSION SNIPPETS (QUẢN LÝ SESSION & COOKIE TRONG SERVLET)

Các đoạn code chuẩn, dễ dùng trong phòng thi về `HttpSession` và `Cookie`.

---

## 1. LẤY HOẶC TẠO SESSION
```java
// Lấy session hiện tại hoặc tạo mới nếu chưa có
HttpSession session = req.getSession();

// Lấy session hiện tại, KHÔNG tạo mới nếu chưa có (trả về null nếu chưa có)
HttpSession session = req.getSession(false);
```

---

## 2. LƯU DỮ LIỆU VÀO SESSION (SET ATTRIBUTE)
```java
// Lưu thông tin người dùng / đối tượng đăng nhập
session.setAttribute("account", user);

// Lưu role hoặc thông báo flash
session.setAttribute("role", user.getRoleid());
session.setAttribute("flashMessage", "Đăng nhập thành công!");
```

---

## 3. ĐỌC DỮ LIỆU TỪ SESSION (GET ATTRIBUTE)
```java
// Đọc đối tượng từ session trong Servlet
User account = (User) session.getAttribute("account");
if (account == null) {
    // Chưa đăng nhập -> redirect về trang login
    resp.sendRedirect(req.getContextPath() + "/login");
    return;
}
```

Trên trang JSP:
```jsp
<!-- Kiểm tra đăng nhập bằng JSTL -->
<c:if test="${not empty sessionScope.account}">
    <span>Xin chào, ${sessionScope.account.fullname}!</span>
</c:if>

<c:if test="${empty sessionScope.account}">
    <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
</c:if>
```

---

## 4. XÓA BẢN GHI HOẶC HỦY TOÀN BỘ SESSION (LOGOUT)
```java
// Xóa một attribute cụ thể
session.removeAttribute("account");

// Hủy toàn bộ session (Đăng xuất hoàn toàn)
session.invalidate();

// Chuyển hướng về trang đăng nhập hoặc trang chủ
resp.sendRedirect(req.getContextPath() + "/login?msg=logged_out");
```

---

## 5. LÀM VIỆC VỚI COOKIE (NHỚ TÀI KHOẢN)
### Ghi nhớ Cookie khi đăng nhập:
```java
// Tạo cookie lưu username trong 30 ngày (hoặc 30 phút)
Cookie userCookie = new Cookie("remember_username", username);
userCookie.setMaxAge(30 * 24 * 60 * 60); // 30 ngày tính bằng giây
userCookie.setPath(req.getContextPath());
resp.addCookie(userCookie);
```

### Xóa Cookie khi bỏ chọn hoặc logout:
```java
Cookie userCookie = new Cookie("remember_username", "");
userCookie.setMaxAge(0); // 0 giây = xóa ngay lập tức
userCookie.setPath(req.getContextPath());
resp.addCookie(userCookie);
```

### Đọc Cookie trong Servlet / JSP:
```java
Cookie[] cookies = req.getCookies();
String rememberedUser = "";
if (cookies != null) {
    for (Cookie c : cookies) {
        if ("remember_username".equals(c.getName())) {
            rememberedUser = c.getValue();
            break;
        }
    }
}
req.setAttribute("rememberedUser", rememberedUser);
```
