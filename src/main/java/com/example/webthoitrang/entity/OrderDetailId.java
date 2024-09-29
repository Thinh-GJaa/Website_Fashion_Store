package com.example.webthoitrang.entity;

import com.google.common.base.Objects;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class OrderDetailId implements Serializable {

    private int orderId;
    private int sizeId;
    private int productId;

    public OrderDetailId() {
    }

    public OrderDetailId(int productId, int orderId, int sizeId) {
        this.productId = productId;
        this.orderId = orderId;
        this.sizeId = sizeId;
    }

    public int getOrderId() {return this.orderId;}
    public void setOrderId(int orderId) {this.orderId = orderId;}

    public int getSizeId() {return this.sizeId;}
    public void setSizeId(int sizeId) {this.sizeId = sizeId;}

    public int getProductId() {return this.productId;}
    public void setProductId(int productId) {this.productId = productId;}

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OrderDetailId)) return false;
        OrderDetailId that = (OrderDetailId) o;
        return orderId == that.orderId && sizeId == that.sizeId && productId == that.productId;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(orderId, sizeId, productId);
    }
}
