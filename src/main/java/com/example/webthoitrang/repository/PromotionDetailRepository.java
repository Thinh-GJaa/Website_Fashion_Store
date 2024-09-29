package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.PromotionDetail;
import com.example.webthoitrang.entity.PromotionDetailId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface PromotionDetailRepository extends JpaRepository<PromotionDetail, PromotionDetailId> {
    @Query("SELECT pd.rate FROM PromotionDetail pd " +
            "WHERE pd.promotion.startDate <= CURRENT_DATE " +
            "AND pd.promotion.endDate >= CURRENT_DATE " +
            "AND pd.promotionDetailId.productId = :productId " +
            "ORDER BY pd.promotion.startDate DESC")
    List<Integer> findCurrentPromotionRateByProductId(@Param("productId") int productId);

    @Query("SELECT pd.product.productId FROM PromotionDetail pd " +
            "WHERE pd.promotion.startDate <= CURRENT_DATE " +
            "AND pd.promotion.endDate >= CURRENT_DATE " +
            "ORDER BY pd.rate DESC")
    Set<Integer> findPromotedProductsSortedByRate();
}
