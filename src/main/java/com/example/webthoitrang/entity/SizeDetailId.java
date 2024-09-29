package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class SizeDetailId implements Serializable {

    @Column(name = "size_id")
    private int sizeId;

    @Column(name = "product_id")
    private int productId;

    public SizeDetailId() {
    }

    public SizeDetailId(int sizeId, int productId) {
        this.sizeId = sizeId;
        this.productId = productId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SizeDetailId that = (SizeDetailId) o;
        return sizeId == that.sizeId &&
                productId == that.productId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(sizeId, productId);
    }
}
