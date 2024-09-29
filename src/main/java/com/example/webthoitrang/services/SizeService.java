package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Size;
import com.example.webthoitrang.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {

    private final SizeRepository sizeRepository;

    @Autowired
    public SizeService(SizeRepository sizeRepository) {this.sizeRepository = sizeRepository;}

    public List<Size> getAllSize() {return sizeRepository.findAll();}

    public Size addOrUpdateSize(Size size) {return sizeRepository.save(size);}

    public Size getSizeById(int id) {return sizeRepository.findById(id).orElse(null);}

    public Size getSizeBySizeName(String sizeName) {return sizeRepository.findBySizeName(sizeName);}
}
