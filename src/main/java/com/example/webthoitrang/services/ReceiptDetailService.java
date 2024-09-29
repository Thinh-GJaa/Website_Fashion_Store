package com.example.webthoitrang.services;


import com.example.webthoitrang.entity.ReceiptDetail;
import com.example.webthoitrang.repository.ReceiptDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ReceiptDetailService {

    private final ReceiptDetailRepository receiptDetailRepository;

    @Autowired
    public ReceiptDetailService(ReceiptDetailRepository receiptDetailRepository) {
        this.receiptDetailRepository = receiptDetailRepository;
    }


    public ReceiptDetail addOrUpdateReceiptDetail(ReceiptDetail receiptDetail) {return receiptDetailRepository.save(receiptDetail);}



}
