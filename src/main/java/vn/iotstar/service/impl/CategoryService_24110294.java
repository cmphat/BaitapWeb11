package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ICategoryDao_24110294;
import vn.iotstar.dao.impl.CategoryDao_24110294;
import vn.iotstar.model.Category_24110294;
import vn.iotstar.service.ICategoryService_24110294;

public class CategoryService_24110294 implements ICategoryService_24110294 {
    private final ICategoryDao_24110294 dao = new CategoryDao_24110294();
    public List<Category_24110294> findAllWithVideoCount() { return dao.findAllWithVideoCount(); }
    public Category_24110294 findById(int id) { return dao.findById(id); }
}
