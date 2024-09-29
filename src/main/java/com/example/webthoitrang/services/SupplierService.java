package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Supplier;
import com.example.webthoitrang.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SupplierService {

    private final SupplierRepository supplierRepository;

    @Autowired
    public SupplierService(SupplierRepository supplierRepository) {
        this.supplierRepository = supplierRepository;
    }

    public List<Supplier> getAllSuppliers() {
        return supplierRepository.findAll();
    }

    public Supplier addOrUpdateSupplier(Supplier supplier) {
        return supplierRepository.save(supplier);
    }

    public Supplier getSupplierByEmail(String email) {
        return supplierRepository.findByEmail(email);
    }

    public Supplier getSupplierByPhoneNumber(String phoneNumber) {
        return supplierRepository.findByPhoneNumber(phoneNumber);
    }

    public Supplier getSupplierBySupplierName(String supplierName) {
        return supplierRepository.findBySupplierName(supplierName);
    }

    public Supplier getSupplierById(int supplierId) {
        return supplierRepository.findById(supplierId).orElse(null);
    }
}
