package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.entity.Size;
import com.example.webthoitrang.entity.SizeDetail;
import com.example.webthoitrang.entity.SizeDetailId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeDetailRepository extends JpaRepository<SizeDetail, SizeDetailId> {

    boolean existsBySizeAndProduct(Size size, Product product);

    List<SizeDetail> findAllByOrderByProductProductId();

}
