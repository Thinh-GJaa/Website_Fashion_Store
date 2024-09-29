package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findProductsByCategoryCategoryId(int categoryId);

    // Tìm kiếm sản phẩm dựa trên từ khóa
    @Query("SELECT p FROM Product p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(p.brand.brandName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(p.category.categoryName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(p.material.materialName) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Product> searchByKeyword(@Param("keyword") String keyword);
}
