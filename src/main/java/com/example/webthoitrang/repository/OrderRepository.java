package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.Customer;
import com.example.webthoitrang.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {

    List<Order> findByStatusOrderByCreateDateDesc(int status);

    List<Order> findByStatusAndCustomer(int status, Customer customer);

    List<Order> findByCustomer(Customer customer);


    //Thống kê số lượng hóa đơn theo khoảng thời gian
    @Query("SELECT o.createDate, COUNT(o) FROM Order o WHERE o.createDate BETWEEN :startDate AND :endDate GROUP BY o.createDate")
    List<Object[]> findStatisticByDate(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    //Thống kê doanh thu theo khoản thời gian
    @Query("SELECT o.createDate, SUM(o.totalDiscountAmount) FROM Order o WHERE o.createDate BETWEEN :startDate AND :endDate GROUP BY o.createDate")
    List<Object[]> findStatisticSalesByDate(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    // Thống kê doanh thu theo tháng
    @Query(value = "SELECT FUNCTION('MONTH', o.createDate) AS month, SUM(o.totalDiscountAmount) AS totalRevenue " +
            "FROM Order o " +
            "WHERE FUNCTION('YEAR', o.createDate) = :year " +
            "GROUP BY FUNCTION('MONTH', o.createDate) " +
            "ORDER BY month")
    List<Object[]> findStatisticSalesByMonth(@Param("year") int year);

    // Thống kê doanh thu theo năm
    @Query("SELECT FUNCTION('YEAR', o.createDate) AS year, SUM(o.totalAmount) AS totalRevenue " +
            "FROM Order o " +
            "GROUP BY FUNCTION('YEAR', o.createDate) " +
            "ORDER BY year")
    List<Object[]> findStatisticSalesByYear();
}
