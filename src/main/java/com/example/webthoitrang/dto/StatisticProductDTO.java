package com.example.webthoitrang.dto;


public class StatisticProductDTO {
    private int productId;
    private String productName;
    private String productImage;
    private long quantity;


    public StatisticProductDTO() {
    }

    public StatisticProductDTO(long quantity, String productImage, String productName, int productId) {
        this.quantity = quantity;
        this.productImage = productImage;
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

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }
}
