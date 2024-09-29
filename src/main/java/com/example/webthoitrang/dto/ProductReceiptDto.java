package com.example.webthoitrang.dto;

public class ProductReceiptDto {

    private int productId;
    private String productName;
    private int sizeId;
    private String productSize;
    private String productPrice;
    private String productQuantity;

    ProductReceiptDto(){
    };

    ProductReceiptDto(int productId, String productName, int sizeId, String productSize, String productPrice, String productQuantity) {
        this.productId = productId;
        this.productName = productName;
        this.sizeId = sizeId;
        this.productSize = productSize;
        this.productPrice = productPrice;
        this.productQuantity = productQuantity;
    }

    public int getProductId() {return this.productId;}
    public void setProductId(int productId) {this.productId = productId;}

    public String getProductName() {return this.productName;}
    public void setProductName(String productName) {this.productName = productName;}

    public int getSizeId() {return this.sizeId;}
    public void setSizeId(int sizeId) {this.sizeId = sizeId;}

    public String getProductSize() {return this.productSize;}
    public void setProductSize(String productSize) {this.productSize = productSize;}

    public String getProductPrice() {return this.productPrice;}
    public void setProductPrice(String productPrice) {this.productPrice = productPrice;}

    public String getProductQuantity() {return this.productQuantity;}
    public void setProductQuantity(String productQuantity) {this.productQuantity = productQuantity;}

    @Override
    public String toString() {
        return "ProductReceiptDto [productId=" + productId + ", productName=" + productName + ", sizeId=" + sizeId
                + ", productSize=" + productSize + ", productPrice=" + productPrice + ", productQuantity=" + productQuantity + "]";
    }
}
