# AUTHENTICATION & AUTHORIZATION TEMPLATE

Tài liệu hướng dẫn triển khai kiểm tra đăng nhập và phân quyền trong kỳ thi Java Web.

---

## 1. MÔ HÌNH XÁC THỰC CỦA DỰ ÁN
Dự án đã có sẵn module tài khoản:
- Entity / Model: `vn.iotstar.model.User`
- DAO: `vn.iotstar.dao.impl.UserDaoImpl`
- Service: `vn.iotstar.service.impl.UserServiceImpl`
- Controller: `vn.iotstar.controller.LoginServlet`, `LogoutServlet`, `RegisterServlet`
- Dữ liệu tài khoản test trong CSDL (`ExerciseWeb`):
  - **Username:** `admin` | **Password:** `123` | **Role:** `1` (Admin)
  - **Username:** `user` | **Password:** `123` | **Role:** `2` (User)

---

## 2. LOGIN SERVLET FLOW
```java
@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 1. Kiểm tra validation form
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Tên đăng nhập và mật khẩu không được rỗng!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 2. Xác thực với CSDL
        User user = userService.login(username.trim(), password.trim());
        if (user != null) {
            // 3. Đăng nhập thành công -> lưu vào session
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            // Điều hướng theo quyền (Admin vs User)
            if (user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/sample?action=list");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            // 4. Đăng nhập thất bại
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
```

---

## 3. CHECK AUTH TRONG CONTROLLER / SERVLET BẢO VỆ
Khi đề thi yêu cầu một chức năng chỉ dành cho người dùng đã đăng nhập hoặc Admin:
```java
HttpSession session = req.getSession(false);
User account = (session != null) ? (User) session.getAttribute("account") : null;

if (account == null) {
    // Chưa đăng nhập -> redirect login
    resp.sendRedirect(req.getContextPath() + "/login?error=please_login");
    return;
}

// Nếu đề thi yêu cầu quyền Admin:
if (account.getRoleid() != 1) {
    req.setAttribute("errorMessage", "Bạn không có quyền truy cập chức năng này (Yêu cầu quyền Quản trị viên)!");
    req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
    return;
}
```

---

## 4. HIỂN THỊ THÔNG TIN USER TRÊN JSP
```jsp
<c:choose>
    <c:when test="${not empty sessionScope.account}">
        <span class="navbar-text text-white me-3">
            <i class="bi bi-person-fill"></i> ${sessionScope.account.fullname}
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-light">Đăng xuất</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-light">Đăng nhập</a>
    </c:otherwise>
</c:choose>
```
