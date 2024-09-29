package com.example.webthoitrang.entity;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "order_detail")
public class OrderDetail implements Serializable {

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "orderId", column = @Column(name = "order_id", nullable = false)),
            @AttributeOverride(name = "sizeId", column = @Column(name = "size_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false))
    })
    private OrderDetailId orderDetailId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumns({
            @JoinColumn(name = "product_id", referencedColumnName = "product_id", insertable = false, updatable = false),
            @JoinColumn(name = "size_id", referencedColumnName = "size_id", insertable = false, updatable = false)
    })
    private SizeDetail sizeDetail;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id", nullable = false, insertable = false, updatable = false)
    private Order order;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "rating_score", columnDefinition = "INT DEFAULT 0")
    private int ratingScore;

    @Column(name = "price", columnDefinition = "DOUBLE DEFAULT 0")
    private double price;


    public OrderDetail() {
    }

    public OrderDetail(OrderDetailId orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public OrderDetail(OrderDetailId orderDetailId, Order order, SizeDetail sizeDetail, int quantity, int ratingScore) {
        this.orderDetailId = orderDetailId;
        this.order = order;
        this.sizeDetail = sizeDetail;
        this.quantity = quantity;
        this.ratingScore = ratingScore;
    }

    public OrderDetailId getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(OrderDetailId orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public SizeDetail getSizeDetail() {
        return sizeDetail;
    }

    public void setSizeDetail(SizeDetail sizeDetail) {
        this.sizeDetail = sizeDetail;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getRatingScore() {
        return ratingScore;
    }

    public void setRatingScore(int ratingScore) {
        this.ratingScore = ratingScore;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}