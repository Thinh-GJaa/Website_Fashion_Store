package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.*;

@Entity
@Table(name = "receipt_detail")
public class ReceiptDetail implements Serializable {

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "receiptId", column = @Column(name = "receipt_id", nullable = false)),
            @AttributeOverride(name = "sizeId", column = @Column(name = "size_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false))
    })
    private ReceiptDetailId receiptDetailId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumns({
            @JoinColumn(name = "product_id", referencedColumnName = "product_id", insertable = false, updatable = false),
            @JoinColumn(name = "size_id", referencedColumnName = "size_id", insertable = false, updatable = false)
    })
    private SizeDetail sizeDetail;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "receipt_id", nullable = false, insertable = false, updatable = false)
    private Receipt receipt;

    @ManyToOne
    @JoinColumn(name = "staff_id")
    private Staff staff;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "import_price")
    private float importPrice;

    public ReceiptDetail() {
        super();
    }

    public ReceiptDetail(ReceiptDetailId receiptDetailId) {
        this.receiptDetailId = receiptDetailId;
    }

    public ReceiptDetail(SizeDetail sizeDetail, Receipt receipt, Staff staff, int quantity, float importPrice) {
        this.sizeDetail = sizeDetail;
        this.receipt = receipt;
        this.staff = staff;
        this.quantity = quantity;
        this.importPrice = importPrice;
    }

    public float getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(float importPrice) {
        this.importPrice = importPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Receipt getReceipt() {
        return receipt;
    }

    public void setReceipt(Receipt receipt) {
        this.receipt = receipt;
    }

    public SizeDetail getSizeDetail() {
        return sizeDetail;
    }

    public void setSizeDetail(SizeDetail sizeDetail) {
        this.sizeDetail = sizeDetail;
    }

    public ReceiptDetailId getReceiptDetailId() {
        return receiptDetailId;
    }

    public void setReceiptDetailId(ReceiptDetailId receiptDetailId) {
        this.receiptDetailId = receiptDetailId;
    }

}
