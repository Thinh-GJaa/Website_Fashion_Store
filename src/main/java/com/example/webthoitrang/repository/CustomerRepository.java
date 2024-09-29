package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {

    int countByGender(int gender);

    int countByAccountStatus(Boolean account_status);

    @Query("SELECT " +
            "CASE " +
            "   WHEN YEAR(CURRENT_DATE) - YEAR(c.dateOfBirth) < 18 THEN 'Dưới 18' " +
            "   WHEN YEAR(CURRENT_DATE) - YEAR(c.dateOfBirth) BETWEEN 18 AND 25 THEN '18-25' " +
            "   WHEN YEAR(CURRENT_DATE) - YEAR(c.dateOfBirth) BETWEEN 26 AND 35 THEN '26-35' " +
            "   WHEN YEAR(CURRENT_DATE) - YEAR(c.dateOfBirth) BETWEEN 36 AND 45 THEN '36-45' " +
            "   WHEN YEAR(CURRENT_DATE) - YEAR(c.dateOfBirth) BETWEEN 46 AND 55 THEN '46-55' " +
            "   ELSE 'Trên 55' " +
            "END AS ageGroup, COUNT(c) AS count " +
            "FROM Customer c " +
            "GROUP BY ageGroup")
    List<Object[]> findAgeStatistics();


}
