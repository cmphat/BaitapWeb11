# JDBC SNIPPETS (MICROSOFT SQL SERVER)

Các đoạn code JDBC thuần sử dụng `vn.iotstar.connection.DBConnection` cho dự án.

---

## 1. MẪU KẾT NỐI VÀ TRY-WITH-RESOURCES
```java
DBConnection db = new DBConnection();
String sql = "SELECT * FROM dbo.samples WHERE status = 1 ORDER BY id DESC";

try (Connection conn = db.getConnection();
     PreparedStatement ps = conn.prepareStatement(sql);
     ResultSet rs = ps.executeQuery()) {

    List<Sample> list = new ArrayList<>();
    while (rs.next()) {
        Sample s = new Sample();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setDescription(rs.getString("description"));
        s.setStatus(rs.getInt("status"));
        list.add(s);
    }
    return list;
} catch (Exception e) {
    e.printStackTrace();
}
```

---

## 2. INSERT VÀ LẤY GENERATED KEY
```java
String sql = "INSERT INTO dbo.samples (name, description, status, category_id) VALUES (?, ?, ?, ?)";

try (Connection conn = new DBConnection().getConnection();
     PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

    ps.setString(1, sample.getName());
    ps.setString(2, sample.getDescription());
    ps.setInt(3, sample.getStatus());
    if (sample.getCategory() != null) {
        ps.setInt(4, sample.getCategory().getCategoryid());
    } else {
        ps.setNull(4, java.sql.Types.INTEGER);
    }

    int affectedRows = ps.executeUpdate();
    if (affectedRows > 0) {
        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                sample.setId(generatedKeys.getInt(1));
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}
```

---

## 3. UPDATE & DELETE
```java
// UPDATE
String updateSql = "UPDATE dbo.samples SET name = ?, description = ?, status = ? WHERE id = ?";
try (Connection conn = new DBConnection().getConnection();
     PreparedStatement ps = conn.prepareStatement(updateSql)) {
    ps.setString(1, sample.getName());
    ps.setString(2, sample.getDescription());
    ps.setInt(3, sample.getStatus());
    ps.setInt(4, sample.getId());
    ps.executeUpdate();
} catch (Exception e) {
    e.printStackTrace();
}

// DELETE
String deleteSql = "DELETE FROM dbo.samples WHERE id = ?";
try (Connection conn = new DBConnection().getConnection();
     PreparedStatement ps = conn.prepareStatement(deleteSql)) {
    ps.setInt(1, id);
    ps.executeUpdate();
} catch (Exception e) {
    e.printStackTrace();
}
```

---

## 4. TÌM KIẾM (SEARCH LIKE)
```java
String sql = "SELECT * FROM dbo.samples WHERE LOWER(name) LIKE LOWER(?) ORDER BY id DESC";
try (Connection conn = new DBConnection().getConnection();
     PreparedStatement ps = conn.prepareStatement(sql)) {
    ps.setString(1, "%" + keyword.trim() + "%");
    try (ResultSet rs = ps.executeQuery()) {
        // Đọc dữ liệu ra List
    }
} catch (Exception e) {
    e.printStackTrace();
}
```

---

## 5. QUẢN LÝ TRANSACTION TRONG JDBC
```java
Connection conn = null;
try {
    conn = new DBConnection().getConnection();
    conn.setAutoCommit(false); // Bắt đầu transaction

    // Thực thi bước 1
    PreparedStatement ps1 = conn.prepareStatement("...");
    ps1.executeUpdate();

    // Thực thi bước 2
    PreparedStatement ps2 = conn.prepareStatement("...");
    ps2.executeUpdate();

    conn.commit(); // Xác nhận transaction
} catch (Exception e) {
    if (conn != null) {
        try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
    }
    e.printStackTrace();
} finally {
    if (conn != null) {
        try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
    }
}
```
