package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "size_detail")
public class SizeDetail implements Serializable {

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "sizeId", column = @Column(name = "size_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false))
    })
    private SizeDetailId sizeDetailId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "size_id", nullable = false, insertable = false, updatable = false)
    private Size size;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", nullable = false, insertable = false, updatable = false)
    private Product product;

    @Column(name = "quantity")
    private int quantity;

    @OneToMany(mappedBy = "sizeDetail")
    private Set<OrderDetail> orderDetails = new HashSet<>();

    @OneToMany(mappedBy = "sizeDetail")
    private Set<ReceiptDetail> receiptDetails = new HashSet<>();

    public SizeDetail() {
        super();
    }

    public SizeDetail(SizeDetailId sizeDetailId) {
        this.sizeDetailId = sizeDetailId;
    }

    public SizeDetail(Product product, Size size, SizeDetailId sizeDetailId, Set<ReceiptDetail> receiptDetails, Set<OrderDetail> orderDetails, int quantity) {
        this.product = product;
        this.size = size;
        this.sizeDetailId = sizeDetailId;
        this.receiptDetails = receiptDetails;
        this.orderDetails = orderDetails;
        this.quantity = quantity;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public SizeDetailId getSizeDetailId() {
        return sizeDetailId;
    }

    public void setSizeDetailId(SizeDetailId sizeDetailId) {
        this.sizeDetailId = sizeDetailId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Set<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(Set<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Set<ReceiptDetail> getReceiptDetails() {
        return receiptDetails;
    }

    public void setReceiptDetails(Set<ReceiptDetail> receiptDetails) {
        this.receiptDetails = receiptDetails;
    }


}
