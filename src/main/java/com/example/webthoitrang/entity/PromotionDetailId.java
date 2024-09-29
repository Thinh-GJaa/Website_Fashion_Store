package com.example.webthoitrang.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class PromotionDetailId implements Serializable {

    @Column(name = "promotion_id")
    private int promotionId;

    @Column(name = "product_id")
    private int productId;

    public PromotionDetailId() {
    }

    public PromotionDetailId(int promotionId, int productId) {
        this.promotionId = promotionId;
        this.productId = productId;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
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
        PromotionDetailId that = (PromotionDetailId) o;
        return promotionId == that.promotionId && productId == that.productId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(promotionId, productId);
    }
}
