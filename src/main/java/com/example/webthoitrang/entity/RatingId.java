package com.example.webthoitrang.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RatingId implements Serializable {

    @Column(name = "customer_id")
    private int customerId;

    @Column(name = "product_id")
    private int productId;

    public RatingId() {
    }

    public RatingId(int customerId, int productId) {
        this.customerId = customerId;
        this.productId = productId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
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
        RatingId ratingId = (RatingId) o;
        return customerId == ratingId.customerId && productId == ratingId.productId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(customerId, productId);
    }
}
