package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.PriceDetail;
import com.example.webthoitrang.entity.PriceDetailId;
import com.example.webthoitrang.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PriceDetailRepository extends JpaRepository<PriceDetail, PriceDetailId> {
    PriceDetail findFirstByProductOrderByPriceDetailIdCreateDateDesc(Product product);

}
