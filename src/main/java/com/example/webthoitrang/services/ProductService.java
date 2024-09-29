package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.PriceDetail;
import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final PriceDetailRepository priceDetailRepository;
    private final PromotionRepository promotionRepository;
    private final PromotionDetailRepository promotionDetailRepository;
    private final ProfileService profileService;
    private final OrderDetailRepository orderDetailRepository;

    @Autowired
    public ProductService(ProductRepository productRepository, PriceDetailRepository priceDetailRepository, CategoryRepository categoryRepository, PromotionRepository promotionRepository, PromotionDetailRepository promotionDetailRepository, ProfileService profileService, OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.priceDetailRepository = priceDetailRepository;
        this.categoryRepository = categoryRepository;
        this.promotionRepository = promotionRepository;
        this.promotionDetailRepository = promotionDetailRepository;
        this.profileService = profileService;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Product> getAllProductValid() {
        List<Product> productList = productRepository.findAll();
        List<Product> results = new ArrayList<>();
        System.out.println("thinh: size " + productList.size());

        for (Product product : productList) {
            if (product.getStatus() == 1) {
                if (getPriceProduct(product) != -1) {
                    results.add(product);
                }

            }
        }
        return results;
    }

    public List<Product> getAllProduct(){
        return productRepository.findAll();
    }

    public Product addOrUpdateProduct(Product product) {
        return productRepository.save(product);
    }

    public Product getProductById(int productId) {
        return productRepository.findById(productId).orElse(null);
    }

    public PriceDetail addOrUpdatePriceDetail(PriceDetail priceDetail) {
        return priceDetailRepository.save(priceDetail);
    }

    public float getPriceProduct(Product product) {
        PriceDetail priceDetail = priceDetailRepository.findFirstByProductOrderByPriceDetailIdCreateDateDesc(product);
        if (priceDetail == null) {
            return -1;
        }
        return priceDetail.getNewPrice();
    }

    public List<Product> getProductByCategoryId(int categoryId) {
        List<Product> productList = new ArrayList<>();
        for (Product product : productRepository.findProductsByCategoryCategoryId(categoryId)) {
            if (product.getStatus() == 1) {
                if (getPriceProduct(product) != -1) {
                    productList.add(product);
                }

            }
        }
        return productList;

    }


    public Double getDiscountPriceProduct(int productId) {
        List<Integer> promotionList = promotionDetailRepository.findCurrentPromotionRateByProductId(productId);

        //Nếu không có khuyến mãi trả về null
        if (promotionList.isEmpty()) {
            return null;
        }

//        if(promotionList[0]){}

        //Trả về mức khuyến mãi
        return (double) ((100 - promotionList.get(0)) * getPriceProduct(new Product(productId)) / 100);
    }

    public List<Product> getDiscountProducts() {
        List<Product> productList = productRepository.findAll();
        List<Product> results = new ArrayList<>();

        for (Product product : productList) {
            if (product.getStatus() == 1) {
                if (getPriceProduct(product) != -1) {
                    if (getDiscountPriceProduct(product.getProductId()) != null) {
                        results.add(product);
                    }
                }

            }

        }
        return results;
    }

    public List<Product> getProductsByKeyword(String keyword) {
        List<Product> results = new ArrayList<>();
        List<Product> productList = productRepository.searchByKeyword(keyword);

        //Nếu search ra rỗng thì tách chuỗi và search
        if (productList.isEmpty()) {
            String[] keywords = keyword.split(" ");
            Set<Product> productSet = new HashSet<>();
            for (String keywordTmp : keywords) {
                List<Product> productListTmp = productRepository.searchByKeyword(keywordTmp);
                productSet.addAll(productListTmp);
            }
            return getValidProducts(new ArrayList<>(productSet));

        }

        System.out.println("thinh search: không tách chuỗi");

        return getValidProducts(productList);
    }

    private List<Product> getValidProducts(List<Product> productList) {
        List<Product> results = new ArrayList<>();

        for (Product product : productList) {
            if (product.getStatus() == 1) {
                if (getPriceProduct(product) != -1) {
                    results.add(product);
                }
            }
        }

        return results;
    }

    public Double getRatingProduct(int productId){
        return orderDetailRepository.findAverageRatingByProductId(productId);
    }

}
