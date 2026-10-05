package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.UserInteraction_24110294;
import vn.iotstar.model.VideoAnalytics_24110294;

public interface IVideoInteractionDao_24110294 {
    void recordView(String videoId, String username, String sessionId);
    boolean toggleLike(String videoId, String username);
    boolean isLiked(String videoId, String username);
    void recordShare(String videoId, String username, String email, String sessionId);
    int[] getSummary();
    List<VideoAnalytics_24110294> findVideoAnalytics();
    List<UserInteraction_24110294> findRecentInteractions(int limit);
}
