package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.OrderDetail;
import com.example.webthoitrang.entity.OrderDetailId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, OrderDetailId> {

    @Query("SELECT od.sizeDetail.product.productId AS productId, SUM(od.quantity) AS totalQuantity " +
            "FROM OrderDetail od " +
            "WHERE od.order.status != 0 " +
            "GROUP BY od.sizeDetail.product.productId " +
            "ORDER BY totalQuantity DESC")
    List<Object[]> findTopSellingProducts(Pageable pageable);

    @Query("SELECT od.sizeDetail.product.productId AS productId, SUM(od.quantity) AS totalQuantity " +
            "FROM OrderDetail od " +
            "WHERE od.order.createDate BETWEEN :startDate AND :endDate " +
            "AND od.order.status != 0 "+
            "GROUP BY od.sizeDetail.product.productId " +
            "ORDER BY totalQuantity DESC")
    List<Object[]> findTopSellingProducts(@Param("startDate") LocalDateTime startDate,
                                          @Param("endDate") LocalDateTime endDate,
                                          Pageable pageable);

    @Query("SELECT od.order.createDate, " +
            "SUM(od.quantity) " +
            "FROM OrderDetail od " +
            "WHERE od.sizeDetail.product.productId = :productId " +
            "AND od.order.status != 0 "+
            "AND od.order.createDate BETWEEN :startDate AND :endDate " +
            "GROUP BY od.order.createDate " +
            "ORDER BY od.order.createDate ASC")
    List<Object[]> findSalesProductByDay(
            @Param("productId") int productId,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    @Query("SELECT AVG(od.ratingScore) FROM OrderDetail od WHERE od.orderDetailId.productId = :productId AND od.ratingScore != 0")
    Double findAverageRatingByProductId(@Param("productId") int productId);


}
