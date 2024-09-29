package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.*;

@Entity
@Table(name = "promotion_detail")
public class PromotionDetail implements Serializable {

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "promotionId", column = @Column(name = "promotion_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false))
    })
    private PromotionDetailId promotionDetailId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "promotion_id", nullable = false, insertable = false, updatable = false)
    private Promotion promotion;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", nullable = false, insertable = false, updatable = false)
    private Product product;

    @Column(name = "rate")
    private int rate;

    public PromotionDetail() {
        super();
    }

    public PromotionDetail(PromotionDetailId promotionDetailId) {
        this.promotionDetailId = promotionDetailId;
    }

    public PromotionDetail(PromotionDetailId promotionDetailId, Promotion promotion, Product product, int rate) {
        this.promotionDetailId = promotionDetailId;
        this.promotion = promotion;
        this.product = product;
        this.rate = rate;
    }

    public PromotionDetailId getPromotionDetailId() {
        return promotionDetailId;
    }

    public void setPromotionDetailId(PromotionDetailId promotionDetailId) {
        this.promotionDetailId = promotionDetailId;
    }

    public Promotion getPromotion() {
        return promotion;
    }

    public void setPromotion(Promotion promotion) {
        this.promotion = promotion;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }
}
