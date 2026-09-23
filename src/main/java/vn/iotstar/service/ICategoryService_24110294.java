package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.Category_24110294;

public interface ICategoryService_24110294 {
    List<Category_24110294> findAllWithVideoCount();
    Category_24110294 findById(int id);
}

