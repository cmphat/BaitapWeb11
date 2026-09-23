package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.ICategoryDao_24110294;
import vn.iotstar.model.Category_24110294;

public class CategoryDao_24110294 extends DBConnection implements ICategoryDao_24110294 {
    @Override
    public List<Category_24110294> findAllWithVideoCount() {
        String sql = "SELECT c.CategoryId,c.Categoryname,c.Categorycode,c.Images,c.Status,COUNT(v.VideoId) VideoCount "
                + "FROM Category c LEFT JOIN Videos v ON c.CategoryId=v.CategoryId "
                + "GROUP BY c.CategoryId,c.Categoryname,c.Categorycode,c.Images,c.Status ORDER BY c.CategoryId";
        List<Category_24110294> result = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) result.add(map(rs, true));
        } catch (Exception e) { throw new IllegalStateException("Không thể tải danh mục", e); }
        return result;
    }

    @Override
    public Category_24110294 findById(int id) {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement("SELECT *,0 VideoCount FROM Category WHERE CategoryId=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs, true) : null; }
        } catch (Exception e) { throw new IllegalStateException("Không thể tìm danh mục", e); }
    }

    private Category_24110294 map(ResultSet rs, boolean withCount) throws Exception {
        Category_24110294 c = new Category_24110294();
        c.setCategoryId(rs.getInt("CategoryId")); c.setCategoryName(rs.getString("Categoryname"));
        c.setCategoryCode(rs.getString("Categorycode")); c.setImages(rs.getString("Images"));
        c.setStatus(rs.getBoolean("Status")); if (withCount) c.setVideoCount(rs.getInt("VideoCount"));
        return c;
    }
}

