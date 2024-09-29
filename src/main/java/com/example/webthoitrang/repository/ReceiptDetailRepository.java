package com.example.webthoitrang.repository;

import com.example.webthoitrang.entity.Receipt;
import com.example.webthoitrang.entity.ReceiptDetail;
import com.example.webthoitrang.entity.ReceiptDetailId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReceiptDetailRepository extends JpaRepository<ReceiptDetail, ReceiptDetailId> {

}
