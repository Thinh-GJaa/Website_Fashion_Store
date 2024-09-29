package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ReceiptDetailId implements Serializable {

    @Column(name = "size_id")
    private int sizeId;

    @Column(name = "product_id")
    private int productId;

    @Column(name = "receipt_id")
    private int receiptId;



    public ReceiptDetailId() {
    }

    public ReceiptDetailId(int sizeId, int productId , int receiptId) {
        this.sizeId = sizeId;
        this.productId = productId;
        this.receiptId = receiptId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getReceiptId() {
        return receiptId;
    }

    public void setReceiptId(int receiptId) {
        this.receiptId = receiptId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReceiptDetailId that = (ReceiptDetailId) o;
        return sizeId == that.sizeId && productId == that.productId && receiptId == that.receiptId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(sizeId, productId, receiptId);
    }
}
