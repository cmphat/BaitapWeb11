package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.IVideoDao_24110294;
import vn.iotstar.model.VideoDetail_24110294;

public class VideoDao_24110294 extends DBConnection implements IVideoDao_24110294 {
    private static final String SELECT_DETAIL = "SELECT v.VideoId,v.Title,v.Poster,v.Views,v.Description,v.CategoryId,c.Categoryname,"
            + "(SELECT COUNT(*) FROM Shares s WHERE s.VideoId=v.VideoId) ShareCount,"
            + "(SELECT COUNT(*) FROM Favorites f WHERE f.VideoId=v.VideoId) LikeCount "
            + "FROM Videos v JOIN Category c ON v.CategoryId=c.CategoryId ";

    @Override
    public VideoDetail_24110294 findDetail(String id) {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(SELECT_DETAIL + "WHERE v.VideoId=?")) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        } catch (Exception e) { throw new IllegalStateException("Không thể tải chi tiết video", e); }
    }

    @Override
    public List<VideoDetail_24110294> findByCategory(int categoryId, int page, int pageSize) {
        String sql = SELECT_DETAIL + "WHERE v.CategoryId=? AND v.Active=1 ORDER BY v.VideoId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        List<VideoDetail_24110294> result = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryId); ps.setInt(2, (Math.max(page, 1)-1)*pageSize); ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) result.add(map(rs)); }
        } catch (Exception e) { throw new IllegalStateException("Không thể tải video theo danh mục", e); }
        return result;
    }

    @Override
    public int countByCategory(int categoryId) {
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Videos WHERE CategoryId=? AND Active=1")) {
            ps.setInt(1, categoryId); try (ResultSet rs = ps.executeQuery()) { return rs.next() ? rs.getInt(1) : 0; }
        } catch (Exception e) { throw new IllegalStateException("Không thể đếm video", e); }
    }

    private VideoDetail_24110294 map(ResultSet rs) throws Exception {
        VideoDetail_24110294 v = new VideoDetail_24110294();
        v.setVideoId(rs.getString("VideoId")); v.setTitle(rs.getString("Title")); v.setPoster(rs.getString("Poster"));
        v.setViews(rs.getInt("Views")); v.setDescription(rs.getString("Description"));
        v.setCategoryId(rs.getInt("CategoryId")); v.setCategoryName(rs.getString("Categoryname"));
        v.setShareCount(rs.getInt("ShareCount")); v.setLikeCount(rs.getInt("LikeCount")); return v;
    }
}

