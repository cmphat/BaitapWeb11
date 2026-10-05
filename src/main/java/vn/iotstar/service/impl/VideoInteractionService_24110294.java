package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.IVideoInteractionDao_24110294;
import vn.iotstar.dao.impl.VideoInteractionDao_24110294;
import vn.iotstar.model.UserInteraction_24110294;
import vn.iotstar.model.VideoAnalytics_24110294;
import vn.iotstar.service.IVideoInteractionService_24110294;

public class VideoInteractionService_24110294 implements IVideoInteractionService_24110294 {
    private final IVideoInteractionDao_24110294 dao = new VideoInteractionDao_24110294();
    public void recordView(String videoId,String username,String sessionId){dao.recordView(videoId,username,sessionId);}
    public boolean toggleLike(String videoId,String username){return dao.toggleLike(videoId,username);}
    public boolean isLiked(String videoId,String username){return dao.isLiked(videoId,username);}
    public void recordShare(String videoId,String username,String email,String sessionId){dao.recordShare(videoId,username,email,sessionId);}
    public int[] getSummary(){return dao.getSummary();}
    public List<VideoAnalytics_24110294> findVideoAnalytics(){return dao.findVideoAnalytics();}
    public List<UserInteraction_24110294> findRecentInteractions(int limit){return dao.findRecentInteractions(limit);}
}
