package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Receipt;
import com.example.webthoitrang.repository.ReceiptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReceiptService {

    private final ReceiptRepository receiptRepository;

    @Autowired
    public ReceiptService(ReceiptRepository receiptRepository) {
        this.receiptRepository = receiptRepository;
    }

    public  List<Receipt> getAllReReceipt() {return receiptRepository.findAll();}

    public Receipt addOrUpdateReceipt(Receipt receipt) {return receiptRepository.save(receipt);}



}
