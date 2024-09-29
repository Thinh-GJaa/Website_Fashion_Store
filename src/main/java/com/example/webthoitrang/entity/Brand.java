package com.example.webthoitrang.entity;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "brand")
public class Brand implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "brand_id")
    private int brandId;

    @Column(name = "brand_name", nullable = false, unique = true)
    private String brandName;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "brand")
    private Set<Product> products = new HashSet<>();

	public Brand() {
		super();
	}

	public Brand(int brandId) {
		this.brandId = brandId;
	}

	public Brand(String brandName, Set<Product> products) {
		this.brandName = brandName;
		this.products = products;
	}

	public int getBrandId() {
		return brandId;
	}

	public void setBrandId(int brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public Set<Product> getProducts() {
		return products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

    

    
}