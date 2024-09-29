package com.example.webthoitrang.repository;

import com.example.webthoitrang.dto.StatisticDTO;
import com.example.webthoitrang.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    Account findByEmail(String email);
    Account findByPhoneNumber(String phoneNumber);
    Boolean existsAccountByEmail(String email);

    @Query(value = "SELECT DATE_FORMAT(a.create_date, '%Y-%m-%d') AS date, COUNT(*) AS count " +
            "FROM account a " +
            "JOIN role r ON a.role_id = r.role_id " +
            "WHERE a.create_date BETWEEN :startDate AND :endDate " +
            "AND r.role_name = 'Customer' " +
            "GROUP BY DATE_FORMAT(a.create_date, '%Y-%m-%d')", nativeQuery = true)
    List<Object[]> findAccountStatisticsByDay(@Param("startDate") Date startDate,
                                              @Param("endDate") Date endDate);

}
