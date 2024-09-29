package com.example.webthoitrang.entity;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "orders") // Đổi tên thành "orders" để tránh từ khóa SQL "order"
public class Order implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private int orderId;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @Column(name = "create_date", nullable = false)
    private LocalDateTime createDate;

    @Column(name = "recipient_name", nullable = false)
    private String recipientName;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "phone_number", nullable = false)
    private String phoneNumber;

    @Column(name = "total_amount", nullable = false)
    private float totalAmount;

    @Column(name = "total_discount_amount")
    private float totalDiscountAmount;

    @Column(name = "status", nullable = false)
    private int status;

    @Column(name = "reason")
    private String reason;

    @ManyToOne
    @JoinColumn(name = "staff_id")
    private Staff staff;
    
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<OrderDetail> orderDetails = new HashSet<>();

    public Order() {
    }

    public Order(int orderId) {
        this.orderId = orderId;
    }

    // Constructor with fields
    public Order(Customer customer, LocalDateTime createDate, String recipientName, String address, String phoneNumber,
                 float totalAmount, float totalDiscountAmount, int status, Set<OrderDetail> orderDetails) {
        this.customer = customer;
        this.createDate = createDate;
        this.recipientName = recipientName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.totalAmount = totalAmount;
        this.totalDiscountAmount = totalDiscountAmount;
        this.status = status;
        this.orderDetails = orderDetails;
    }

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public float getTotalDiscountAmount() {
        return totalDiscountAmount;
    }

    public void setTotalDiscountAmount(float totalDiscountAmount) {
        this.totalDiscountAmount = totalDiscountAmount;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Set<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(Set<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
