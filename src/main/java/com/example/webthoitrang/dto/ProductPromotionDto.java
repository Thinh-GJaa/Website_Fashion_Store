package com.example.webthoitrang.dto;


public class ProductPromotionDto {
    private int productId;
    private String productName;
    private int promotionRate;

    public ProductPromotionDto() {
    }

    public ProductPromotionDto(int promotionRate, String productName, int productId) {
        this.promotionRate = promotionRate;
        this.productName = productName;
        this.productId = productId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPromotionRate() {
        return promotionRate;
    }

    public void setPromotionRate(int promotionRate) {
        this.promotionRate = promotionRate;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", promotionRate=" + promotionRate +
                '}';
    }
}