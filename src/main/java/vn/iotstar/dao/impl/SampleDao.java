package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.ISampleDao;
import vn.iotstar.entity.Sample;

public class SampleDao implements ISampleDao {

    @Override
    public void insert(Sample sample) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(sample);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Sample sample) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(sample);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Sample sample = em.find(Sample.class, id);
            if (sample != null) {
                em.remove(sample);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Sample findById(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.find(Sample.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Sample> findAll() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            TypedQuery<Sample> query = em.createQuery(
                    "SELECT s FROM Sample s ORDER BY s.id DESC",
                    Sample.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Sample> search(String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            TypedQuery<Sample> query = em.createQuery(
                    "SELECT s FROM Sample s WHERE LOWER(s.name) LIKE LOWER(:keyword) OR LOWER(s.description) LIKE LOWER(:keyword) ORDER BY s.id DESC",
                    Sample.class
            );
            query.setParameter("keyword", "%" + (keyword == null ? "" : keyword.trim()) + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Sample> findByCategory(int categoryId) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            TypedQuery<Sample> query = em.createQuery(
                    "SELECT s FROM Sample s WHERE s.category.categoryid = :catId ORDER BY s.id DESC",
                    Sample.class
            );
            query.setParameter("catId", categoryId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Sample> findByStatus(int status) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            TypedQuery<Sample> query = em.createQuery(
                    "SELECT s FROM Sample s WHERE s.status = :status ORDER BY s.id DESC",
                    Sample.class
            );
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Sample> findPaginated(int page, int size) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            TypedQuery<Sample> query = em.createQuery(
                    "SELECT s FROM Sample s ORDER BY s.id DESC",
                    Sample.class
            );
            query.setFirstResult((Math.max(page, 1) - 1) * size);
            query.setMaxResults(size);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public int count() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(s) FROM Sample s",
                    Long.class
            );
            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}
