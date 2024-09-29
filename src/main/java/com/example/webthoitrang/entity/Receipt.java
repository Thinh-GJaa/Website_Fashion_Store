package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "receipt")
public class Receipt implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "receipt_id")
    private int receiptId;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    private Supplier supplier;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    @ManyToOne
    @JoinColumn(name = "staff_id")
    private Staff staff;

    @OneToMany(mappedBy = "receipt", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ReceiptDetail> receiptDetails = new HashSet<>();

	public Receipt() {
		super();
	}

	public Receipt(int receiptId) {
		this.receiptId = receiptId;
	}

	public Receipt(Supplier supplier, LocalDateTime createDate, Staff staff, Set<ReceiptDetail> receiptDetails) {
		super();
		this.supplier = supplier;
		this.createDate = createDate;
		this.staff = staff;
		this.receiptDetails = receiptDetails;
	}

	public int getReceiptId() {
		return receiptId;
	}

	public void setReceiptId(int receiptId) {
		this.receiptId = receiptId;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}

	public Set<ReceiptDetail> getReceiptDetails() {
		return receiptDetails;
	}

	public void setReceiptDetails(Set<ReceiptDetail> receiptDetails) {
		this.receiptDetails = receiptDetails;
	}



}
