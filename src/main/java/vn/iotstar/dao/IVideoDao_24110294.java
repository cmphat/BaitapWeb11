package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.VideoDetail_24110294;

public interface IVideoDao_24110294 {
    VideoDetail_24110294 findDetail(String videoId);
    List<VideoDetail_24110294> findByCategory(int categoryId, int page, int pageSize);
    int countByCategory(int categoryId);
}
