package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ISampleDao;
import vn.iotstar.dao.impl.SampleDao;
import vn.iotstar.entity.Sample;
import vn.iotstar.service.ISampleService;

public class SampleServiceImpl implements ISampleService {

    private final ISampleDao sampleDao = new SampleDao();

    @Override
    public void insert(Sample sample) {
        sampleDao.insert(sample);
    }

    @Override
    public void update(Sample sample) {
        sampleDao.update(sample);
    }

    @Override
    public void delete(int id) {
        sampleDao.delete(id);
    }

    @Override
    public Sample findById(int id) {
        return sampleDao.findById(id);
    }

    @Override
    public List<Sample> findAll() {
        return sampleDao.findAll();
    }

    @Override
    public List<Sample> search(String keyword) {
        return sampleDao.search(keyword);
    }

    @Override
    public List<Sample> findByCategory(int categoryId) {
        return sampleDao.findByCategory(categoryId);
    }

    @Override
    public List<Sample> findByStatus(int status) {
        return sampleDao.findByStatus(status);
    }

    @Override
    public List<Sample> findPaginated(int page, int size) {
        return sampleDao.findPaginated(page, size);
    }

    @Override
    public int count() {
        return sampleDao.count();
    }
}
