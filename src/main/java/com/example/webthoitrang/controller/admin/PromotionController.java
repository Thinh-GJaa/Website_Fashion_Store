package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.dto.ProductPromotionDto;
import com.example.webthoitrang.dto.PromotionDto;
import com.example.webthoitrang.entity.*;

import com.example.webthoitrang.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashSet;
import java.util.Set;

@Controller
@RequestMapping("/admin/promotion") // Định nghĩa đường dẫn chung
public class PromotionController {

    @Autowired
    private ProductService productService;

    @Autowired
    private PromotionService promotionService;


    @GetMapping
    public ModelAndView promotionHome() {
        ModelAndView mav = new ModelAndView("admin/promotion");
        mav.addObject("promotionList", promotionService.getAllPromotion());
        return mav;
    }

    @GetMapping("/add")
    public ModelAndView customerHome() {
        ModelAndView mav = new ModelAndView("admin/promotion-add");
        mav.addObject("promotion", new Promotion());
        mav.addObject("productList", productService.getAllProductValid());
        return mav;
    }

    @PostMapping
    public ResponseEntity<String> savePromotion(@RequestBody PromotionDto promotionDto) {
        try{
            System.out.println("thinh:" + promotionDto.toString());

            Promotion promotion = new Promotion();
            promotion.setPromotionName(promotionDto.getPromotionName());
            promotion.setStartDate(promotionDto.getStartDate());
            promotion.setEndDate(promotionDto.getEndDate());
            promotion.setStaff(new Staff(1));

            promotion = promotionService.addOrUpdateProduct(promotion);

            Set<PromotionDetail> promotionDetails = new HashSet<>();

            for(ProductPromotionDto p : promotionDto.getPromotionDetails()){
                PromotionDetailId promotionDetailId = new PromotionDetailId();
                promotionDetailId.setPromotionId(promotion.getPromotionId());
                promotionDetailId.setProductId(p.getProductId());

                PromotionDetail promotionDetail = new PromotionDetail(promotionDetailId);
                promotionDetail.setRate(p.getPromotionRate());
                promotionDetails.add(promotionDetail);
            }
            promotion.setPromotionDetails(promotionDetails);
            promotion = promotionService.addOrUpdateProduct(promotion);

            return new ResponseEntity<>(HttpStatus.CREATED);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi khi tạo khuyến mãi mới!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
