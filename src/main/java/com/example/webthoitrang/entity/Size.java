package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "size")
public class Size implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int sizeId;
    
    private String sizeName;
    
    @OneToMany(mappedBy = "size")
    private Set<SizeDetail> sizeDetails = new HashSet<>();

    // Constructors, getters, and setters
    
    public Size() {
    }

    public Size(int sizeId) {
        this.sizeId = sizeId;
    }

    public Size(String sizeName) {
        this.sizeName = sizeName;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public Set<SizeDetail> getSizeDetails() {
        return sizeDetails;
    }

    public void setSizeDetails(Set<SizeDetail> sizeDetails) {
        this.sizeDetails = sizeDetails;
    }

}
