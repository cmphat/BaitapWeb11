package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.IUserDao_24110294;
import vn.iotstar.model.User_24110294;

public class UserDao_24110294 extends DBConnection implements IUserDao_24110294 {
    private User_24110294 map(ResultSet rs) throws Exception {
        User_24110294 user = new User_24110294();
        user.setUsername(rs.getString("Username"));
        user.setPassword(rs.getString("Password"));
        user.setPhone(rs.getString("Phone"));
        user.setFullname(rs.getString("Fullname"));
        user.setEmail(rs.getString("Email"));
        user.setAdmin(rs.getBoolean("Admin"));
        user.setActive(rs.getBoolean("Active"));
        user.setImages(rs.getString("Images"));
        return user;
    }

    @Override
    public List<User_24110294> findAll(int page, int pageSize) {
        String sql = "SELECT * FROM Users ORDER BY Username OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        List<User_24110294> users = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, (Math.max(page, 1) - 1) * pageSize);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) users.add(map(rs));
            }
        } catch (Exception e) { throw new IllegalStateException("Không thể tải danh sách người dùng", e); }
        return users;
    }

    @Override
    public int count() {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Users"); ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) { throw new IllegalStateException("Không thể đếm người dùng", e); }
    }

    @Override public User_24110294 findByUsername(String username) { return findOne("SELECT * FROM Users WHERE Username = ?", username); }
    @Override public User_24110294 findByEmail(String email) { return findOne("SELECT * FROM Users WHERE Email = ?", email); }

    private User_24110294 findOne(String sql, String value) {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        } catch (Exception e) { throw new IllegalStateException("Không thể tìm người dùng", e); }
    }

    @Override
    public boolean insert(User_24110294 u) {
        String sql = "INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, u, false);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new IllegalStateException("Không thể thêm người dùng", e); }
    }

    @Override
    public boolean update(User_24110294 u) {
        String sql = "UPDATE Users SET Password=?, Phone=?, Fullname=?, Email=?, Admin=?, Active=?, Images=? WHERE Username=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getPassword()); ps.setString(2, u.getPhone()); ps.setString(3, u.getFullname());
            ps.setString(4, u.getEmail()); ps.setBoolean(5, u.isAdmin()); ps.setBoolean(6, u.isActive());
            ps.setString(7, u.getImages()); ps.setString(8, u.getUsername());
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new IllegalStateException("Không thể cập nhật người dùng", e); }
    }

    private void bind(PreparedStatement ps, User_24110294 u, boolean ignored) throws Exception {
        ps.setString(1, u.getUsername()); ps.setString(2, u.getPassword()); ps.setString(3, u.getPhone());
        ps.setString(4, u.getFullname()); ps.setString(5, u.getEmail()); ps.setBoolean(6, u.isAdmin());
        ps.setBoolean(7, u.isActive()); ps.setString(8, u.getImages());
    }

    @Override
    public boolean delete(String username) {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement("DELETE FROM Users WHERE Username=?")) {
            ps.setString(1, username); return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new IllegalStateException("Không thể xóa người dùng (có thể đang có dữ liệu liên quan)", e); }
    }

    @Override
    public boolean activate(String username) {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement("UPDATE Users SET Active=1 WHERE Username=?")) {
            ps.setString(1, username); return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new IllegalStateException("Không thể kích hoạt tài khoản", e); }
    }
}

