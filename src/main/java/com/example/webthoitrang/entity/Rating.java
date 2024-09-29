package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.*;

@Entity
@Table(name = "rating")
public class Rating implements Serializable {

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "customerId", column = @Column(name = "customer_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false))
    })
    private RatingId ratingId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id", nullable = false, insertable = false, updatable = false)
    private Customer customer;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", nullable = false, insertable = false, updatable = false)
    private Product product;

    @Column(name = "point")
    private int point;

    public Rating() {
    }

    public Rating(RatingId ratingId) {
        this.ratingId = ratingId;
    }

    public Rating(Product product, Customer customer, int point) {
        this.product = product;
        this.customer = customer;
        this.point = point;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public RatingId getRatingId() {
        return ratingId;
    }

    public void setRatingId(RatingId ratingId) {
        this.ratingId = ratingId;
    }
}
