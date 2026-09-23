package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.VideoDetail_24110294;

public interface IVideoService_24110294 {
    VideoDetail_24110294 findDetail(String id);
    List<VideoDetail_24110294> findByCategory(int categoryId, int page, int pageSize);
    int countByCategory(int categoryId);
}

