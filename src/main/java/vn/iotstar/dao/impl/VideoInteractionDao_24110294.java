package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.IVideoInteractionDao_24110294;
import vn.iotstar.model.UserInteraction_24110294;
import vn.iotstar.model.VideoAnalytics_24110294;

public class VideoInteractionDao_24110294 extends DBConnection implements IVideoInteractionDao_24110294 {
    @Override
    public void recordView(String videoId, String username, String sessionId) {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement update = con.prepareStatement("UPDATE Videos SET Views=ISNULL(Views,0)+1 WHERE VideoId=?");
                 PreparedStatement log = con.prepareStatement("INSERT INTO VideoInteractions_24110294 (Username,VideoId,ActionType,SessionId) VALUES (?,?,N'VIEW',?)")) {
                update.setString(1, videoId);
                if (update.executeUpdate() != 1) throw new IllegalArgumentException("Video không tồn tại");
                log.setString(1, username); log.setString(2, videoId); log.setString(3, sessionId);
                log.executeUpdate();
                con.commit();
            } catch (Exception e) { con.rollback(); throw e; }
        } catch (Exception e) { throw new IllegalStateException("Không thể ghi nhận lượt xem", e); }
    }

    @Override
    public boolean toggleLike(String videoId, String username) {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try {
                boolean liked;
                try (PreparedStatement find = con.prepareStatement("SELECT COUNT(*) FROM Favorites WHERE VideoId=? AND Username=?")) {
                    find.setString(1, videoId); find.setString(2, username);
                    try (ResultSet rs = find.executeQuery()) { rs.next(); liked = rs.getInt(1) > 0; }
                }
                String sql = liked ? "DELETE FROM Favorites WHERE VideoId=? AND Username=?"
                                   : "INSERT INTO Favorites (LikedDate,VideoId,Username) VALUES (CAST(GETDATE() AS DATE),?,?)";
                try (PreparedStatement change = con.prepareStatement(sql)) {
                    change.setString(1, videoId); change.setString(2, username); change.executeUpdate();
                }
                log(con, username, videoId, liked ? "UNLIKE" : "LIKE", null);
                con.commit();
                return !liked;
            } catch (Exception e) { con.rollback(); throw e; }
        } catch (Exception e) { throw new IllegalStateException("Không thể cập nhật lượt thích", e); }
    }

    @Override
    public boolean isLiked(String videoId, String username) {
        if (username == null) return false;
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Favorites WHERE VideoId=? AND Username=?")) {
            ps.setString(1, videoId); ps.setString(2, username);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() && rs.getInt(1) > 0; }
        } catch (Exception e) { throw new IllegalStateException("Không thể kiểm tra lượt thích", e); }
    }

    @Override
    public void recordShare(String videoId, String username, String email, String sessionId) {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps = con.prepareStatement("INSERT INTO Shares (Emails,SharedDate,Username,VideoId) VALUES (?,CAST(GETDATE() AS DATE),?,?)")) {
                ps.setString(1, email); ps.setString(2, username); ps.setString(3, videoId); ps.executeUpdate();
                log(con, username, videoId, "SHARE", sessionId);
                con.commit();
            } catch (Exception e) { con.rollback(); throw e; }
        } catch (Exception e) { throw new IllegalStateException("Không thể ghi nhận lượt chia sẻ", e); }
    }

    private void log(Connection con, String username, String videoId, String action, String sessionId) throws Exception {
        try (PreparedStatement ps = con.prepareStatement("INSERT INTO VideoInteractions_24110294 (Username,VideoId,ActionType,SessionId) VALUES (?,?,?,?)")) {
            ps.setString(1, username); ps.setString(2, videoId); ps.setString(3, action); ps.setString(4, sessionId); ps.executeUpdate();
        }
    }

    @Override
    public int[] getSummary() {
        String sql = "SELECT ISNULL((SELECT SUM(ISNULL(Views,0)) FROM Videos),0),"
                + "(SELECT COUNT(*) FROM Favorites),(SELECT COUNT(*) FROM Shares),"
                + "(SELECT COUNT(*) FROM VideoInteractions_24110294)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            rs.next(); return new int[]{rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getInt(4)};
        } catch (Exception e) { throw new IllegalStateException("Không thể tải tổng quan tương tác", e); }
    }

    @Override
    public List<VideoAnalytics_24110294> findVideoAnalytics() {
        String sql = "SELECT v.VideoId,v.Title,ISNULL(v.Views,0) Views,"
                + "(SELECT COUNT(*) FROM Favorites f WHERE f.VideoId=v.VideoId) LikeCount,"
                + "(SELECT COUNT(*) FROM Shares s WHERE s.VideoId=v.VideoId) ShareCount "
                + "FROM Videos v ORDER BY Views DESC,v.VideoId";
        List<VideoAnalytics_24110294> result = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                VideoAnalytics_24110294 row = new VideoAnalytics_24110294();
                row.setVideoId(rs.getString("VideoId")); row.setTitle(rs.getString("Title")); row.setViews(rs.getInt("Views"));
                row.setLikeCount(rs.getInt("LikeCount")); row.setShareCount(rs.getInt("ShareCount")); result.add(row);
            }
            return result;
        } catch (Exception e) { throw new IllegalStateException("Không thể tải phân tích video", e); }
    }

    @Override
    public List<UserInteraction_24110294> findRecentInteractions(int limit) {
        String sql = "SELECT TOP (?) i.Username,u.Fullname,i.VideoId,v.Title,i.ActionType,i.ActionAt "
                + "FROM VideoInteractions_24110294 i LEFT JOIN Users u ON u.Username=i.Username "
                + "JOIN Videos v ON v.VideoId=i.VideoId ORDER BY i.ActionAt DESC,i.InteractionId DESC";
        List<UserInteraction_24110294> result = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, Math.max(1, limit));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserInteraction_24110294 row = new UserInteraction_24110294();
                    row.setUsername(rs.getString("Username")); row.setFullname(rs.getString("Fullname"));
                    row.setVideoId(rs.getString("VideoId")); row.setVideoTitle(rs.getString("Title"));
                    row.setActionType(rs.getString("ActionType")); row.setActionAt(rs.getTimestamp("ActionAt").toLocalDateTime()); result.add(row);
                }
            }
            return result;
        } catch (Exception e) { throw new IllegalStateException("Không thể tải lịch sử tương tác", e); }
    }
}
