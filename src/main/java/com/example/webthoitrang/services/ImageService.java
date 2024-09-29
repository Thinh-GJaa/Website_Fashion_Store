package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ImageService {

    private final ImageRepository imageRepository;

    @Autowired
    ImageService(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }
    public Image addOrUpdateImage(Image image) {return imageRepository.save(image);}
}
