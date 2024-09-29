package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "material")
public class Material implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "material_id")
    private int materialId;

    @Column(name = "material_name", nullable = false, unique = true)
    private String materialName;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "material", cascade = CascadeType.ALL)
    private Set<Product> products = new HashSet<>();

    // Constructors
    public Material() {
    }

    public Material(int materialId) {
        this.materialId = materialId;
    }

    public Material(String materialName, Set<Product> products) {
		this.materialName = materialName;
		this.products = products;
	}

	// Getters and Setters
    public int getMaterialId() {
        return materialId;
    }

    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public Set<Product> getProducts() {
        return products;
    }

    public void setProducts(Set<Product> products) {
        this.products = products;
    }


}

