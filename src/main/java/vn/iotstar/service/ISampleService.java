package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Sample;

public interface ISampleService {

    void insert(Sample sample);

    void update(Sample sample);

    void delete(int id);

    Sample findById(int id);

    List<Sample> findAll();

    List<Sample> search(String keyword);

    List<Sample> findByCategory(int categoryId);

    List<Sample> findByStatus(int status);

    List<Sample> findPaginated(int page, int size);

    int count();
}
