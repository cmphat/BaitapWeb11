package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.IVideoDao_24110294;
import vn.iotstar.dao.impl.VideoDao_24110294;
import vn.iotstar.model.VideoDetail_24110294;
import vn.iotstar.service.IVideoService_24110294;

public class VideoService_24110294 implements IVideoService_24110294 {
    private final IVideoDao_24110294 dao = new VideoDao_24110294();
    public VideoDetail_24110294 findDetail(String id) { return dao.findDetail(id); }
    public List<VideoDetail_24110294> findByCategory(int id, int page, int size) { return dao.findByCategory(id,page,size); }
    public int countByCategory(int id) { return dao.countByCategory(id); }
}

