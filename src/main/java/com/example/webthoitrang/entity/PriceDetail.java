package com.example.webthoitrang.entity;

import java.io.Serializable;

import javax.persistence.*;

@Entity
@Table(name = "price_detail")
public class PriceDetail implements Serializable {

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "staffId", column = @Column(name = "staff_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false)),
            @AttributeOverride(name = "createDate", column = @Column(name = "create_date", nullable = false, length = 10)) })
    private PriceDetailId priceDetailId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "staff_id", nullable = false, insertable = false, updatable = false)
    private Staff staff;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", nullable = false, insertable = false, updatable = false)
    private Product product;

    @Column(name = "new_price")
    private float newPrice;

    public PriceDetail() {
    }

    public PriceDetail(PriceDetailId priceDetailId) {
        this.priceDetailId = priceDetailId;
    }

    public PriceDetail(Staff staff, Product product, float newPrice, PriceDetailId priceDetailId) {
        this.staff = staff;
        this.product = product;
        this.newPrice = newPrice;
        this.priceDetailId = priceDetailId;
    }

    public PriceDetailId getPriceDetailId() {
        return priceDetailId;
    }

    public void setPriceDetailId(PriceDetailId priceDetailId) {
        this.priceDetailId = priceDetailId;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public float getNewPrice() {
        return newPrice;
    }

    public void setNewPrice(float newPrice) {
        this.newPrice = newPrice;
    }

}
