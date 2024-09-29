package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Promotion;
import com.example.webthoitrang.repository.PromotionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PromotionService {

    private final PromotionRepository promotionRepository;

    public PromotionService(PromotionRepository promotionRepository) {
        this.promotionRepository = promotionRepository;
    }

    public List<Promotion> getAllPromotion() {return promotionRepository.findAll();}

    public Promotion getPromotionById(int id) {return promotionRepository.findById(id).orElse(null);}

    public Promotion addOrUpdateProduct(Promotion promotion) {return promotionRepository.save(promotion);}
}
