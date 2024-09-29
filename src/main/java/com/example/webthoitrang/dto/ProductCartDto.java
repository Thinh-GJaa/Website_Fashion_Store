package com.example.webthoitrang.dto;

import com.example.webthoitrang.entity.SizeDetail;

public class ProductCartDto {
    private SizeDetail sizeDetail;
    private float price;
    private float priceDiscount; ;
    private int quantity;

    public ProductCartDto() {
    }



    public ProductCartDto(SizeDetail sizeDetail, float price, float priceDiscount, int quantity) {
        this.sizeDetail = sizeDetail;
        this.price = price;
        this.priceDiscount = priceDiscount;
        this.quantity = quantity;
    }

    public SizeDetail getSizeDetail() {
        return sizeDetail;
    }

    public void setSizeDetail(SizeDetail sizeDetail) {
        this.sizeDetail = sizeDetail;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPriceDiscount() {
        return priceDiscount;
    }

    public void setPriceDiscount(float priceDiscount) {
        this.priceDiscount = priceDiscount;
    }

    @Override
    public String toString() {
        return "ProductCartDto{" +
                "sizeDetail=" + sizeDetail +
                ", price=" + price +
                ", priceDiscount=" + priceDiscount +
                ", quantity=" + quantity +
                '}';
    }
}
