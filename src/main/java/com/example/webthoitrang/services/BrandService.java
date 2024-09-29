package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.entity.Brand;
import com.example.webthoitrang.repository.AccountRepository;
import com.example.webthoitrang.repository.BrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {

    private final BrandRepository brandRepository;

    @Autowired
    public BrandService(BrandRepository brandRepository) {this.brandRepository = brandRepository;}

    public List<Brand> getAllBrand() {return brandRepository.findAll();}

    public Brand addOrUpdateBrand(Brand brand) {return brandRepository.save(brand);}

    public Brand getBrandByBrandName(String brandName) {return brandRepository.findByBrandName(brandName);}

    public Brand getBrandById(int brandId){return brandRepository.findById(brandId).orElse(null);}
}
