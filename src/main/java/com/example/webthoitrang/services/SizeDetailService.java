package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.entity.Size;
import com.example.webthoitrang.entity.SizeDetail;
import com.example.webthoitrang.entity.SizeDetailId;
import com.example.webthoitrang.repository.SizeDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeDetailService {

    private final SizeDetailRepository sizeDetailRepository;

    @Autowired
    public SizeDetailService(SizeDetailRepository sizeDetailRepository) {this.sizeDetailRepository = sizeDetailRepository;}


    public void addOrUpdateSizeDetail(SizeDetail sizeDetail) {
        sizeDetailRepository.save(sizeDetail);
    }

    public SizeDetail getSizeDetailById(SizeDetailId sizeDetailId) {return sizeDetailRepository.findById(sizeDetailId).orElse(null);}

    public boolean isExistSizeDetail(SizeDetailId sizeDetailId) {return sizeDetailRepository.existsById(sizeDetailId);}

    public boolean isExistSizeAndProduct(Size size, Product product){
        return sizeDetailRepository.existsBySizeAndProduct(size, product);
    }

    public List<SizeDetail> getAllSizeDetailOrderByProduct(){return sizeDetailRepository.findAllByOrderByProductProductId();}

}
