# JPA & HIBERNATE SNIPPETS (JAKARTA PERSISTENCE 3.0)

Tổng hợp các cấu trúc và câu lệnh JPQL chuẩn áp dụng cho dự án.

---

## 1. KHAI BÁO ENTITY CƠ BẢN
```java
package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "products")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name", nullable = false, columnDefinition = "NVARCHAR(255)")
    private String name;

    @Column(name = "price")
    private double price;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "status")
    private int status = 1;

    // Quan hệ Many-to-One: Mỗi Product thuộc về 1 Category
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    // Constructor, Getters & Setters
}
```

---

## 2. KHAI BÁO QUAN HỆ 1-N (ONE-TO-MANY) PHÍA CHA
```java
@Entity
@Table(name = "categories")
public class Category implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryid;

    @Column(name = "CategoryName", columnDefinition = "NVARCHAR(255)")
    private String categoryname;

    // Một Category có nhiều Product
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product> products;
}
```

---

## 3. MẪU QUẢN LÝ TRANSACTION TRONG DAO
```java
// THÊM MỚI (INSERT)
EntityManager em = JpaConfig.getEntityManager();
EntityTransaction trans = em.getTransaction();
try {
    trans.begin();
    em.persist(entity);
    trans.commit();
} catch (Exception e) {
    if (trans.isActive()) trans.rollback();
    throw e;
} finally {
    em.close();
}

// CẬP NHẬT (UPDATE)
EntityManager em = JpaConfig.getEntityManager();
EntityTransaction trans = em.getTransaction();
try {
    trans.begin();
    em.merge(entity);
    trans.commit();
} catch (Exception e) {
    if (trans.isActive()) trans.rollback();
    throw e;
} finally {
    em.close();
}

// XÓA (DELETE)
EntityManager em = JpaConfig.getEntityManager();
EntityTransaction trans = em.getTransaction();
try {
    trans.begin();
    Product p = em.find(Product.class, id);
    if (p != null) {
        em.remove(p);
    }
    trans.commit();
} catch (Exception e) {
    if (trans.isActive()) trans.rollback();
    throw e;
} finally {
    em.close();
}
```

---

## 4. JPQL TRUY VẤN DỮ LIỆU
```java
// 1. Tìm theo ID
Product p = em.find(Product.class, id);

// 2. Lấy toàn bộ danh sách
TypedQuery<Product> query = em.createQuery(
    "SELECT p FROM Product p ORDER BY p.id DESC", 
    Product.class
);
List<Product> list = query.getResultList();

// 3. Tìm kiếm LIKE theo từ khóa
TypedQuery<Product> query = em.createQuery(
    "SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(:kw) ORDER BY p.id DESC",
    Product.class
);
query.setParameter("kw", "%" + keyword.trim() + "%");
List<Product> list = query.getResultList();

// 4. Lọc theo Khóa ngoại (Category)
TypedQuery<Product> query = em.createQuery(
    "SELECT p FROM Product p WHERE p.category.categoryid = :catId ORDER BY p.id DESC",
    Product.class
);
query.setParameter("catId", categoryId);
List<Product> list = query.getResultList();

// 5. Đếm tổng số bản ghi
TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Product p", Long.class);
int total = query.getSingleResult().intValue();

// 6. Phân trang trong JPA (Pagination)
TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class);
query.setFirstResult((page - 1) * size);
query.setMaxResults(size);
List<Product> pageList = query.getResultList();
```
