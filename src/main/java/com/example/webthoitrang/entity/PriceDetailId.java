package com.example.webthoitrang.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

@Embeddable
public class PriceDetailId implements Serializable {

    @Column(name = "staff_id")
    private int staffId;

    @Column(name = "product_id")
    private int productId;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    public PriceDetailId() {
    }

    public PriceDetailId(int staffId, int productId, LocalDateTime createDate) {
        this.staffId = staffId;
        this.productId = productId;
        this.createDate = createDate;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PriceDetailId that = (PriceDetailId) o;
        return staffId == that.staffId && productId == that.productId && Objects.equals(createDate, that.createDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(staffId, productId, createDate);
    }
}
