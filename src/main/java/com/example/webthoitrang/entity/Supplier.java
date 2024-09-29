package com.example.webthoitrang.entity;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "supplier")
public class Supplier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplier_id")
    private int supplierId;

    @Column(name = "supplier_name", nullable = false)
    private String supplierName;

    @Column(name = "email")
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "address")
    private String address;

    @Column(name = "representative")
    private String representative;

    @OneToMany(mappedBy = "supplier", fetch = FetchType.LAZY)
    private Set<Receipt> receipts = new HashSet<>();

	public Supplier() {
		super();
	}

	public Supplier(int supplierId) {
		super();
		this.supplierId = supplierId;
	}


	public Supplier(String supplierName, String email, String phoneNumber, String address, String representative,
			Set<Receipt> receipts) {
		super();
		this.supplierName = supplierName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.representative = representative;
		this.receipts = receipts;
	}

	public int getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRepresentative() {
		return representative;
	}

	public void setRepresentative(String representative) {
		this.representative = representative;
	}

	public Set<Receipt> getReceipts() {
		return receipts;
	}

	public void setReceipts(Set<Receipt> receipts) {
		this.receipts = receipts;
	}

}
