package com.example.webthoitrang.entity;

import com.example.webthoitrang.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "product")
public class Product implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private int productId;

    @Column(name = "product_name", nullable = false)
    private String productName;

    @Column(name = "description")
    private String description;

    @Column(name = "status")
    private int status;

    @Column(name = "gender")
    private int gender;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    private Brand brand;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "material_id")
    private Material material;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<Image> images = new HashSet<>();

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<PriceDetail> priceDetails = new HashSet<>();

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<PromotionDetail> promotionDetails = new HashSet<>();

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<SizeDetail> sizeDetails = new HashSet<>();

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<Rating> ratings = new HashSet<>();

  
    public Product() {
		super();
	}

    public Product(int productId) {
        this.productId = productId;
    }

    public Product(String productName, String description, int status, int gender, Category category, Brand brand,
                   Material material, Set<Image> images, Set<PriceDetail> priceDetails, Set<PromotionDetail> promotionDetails,
                   Set<SizeDetail> sizeDetails, Set<Rating> ratings) {
		super();
		this.productName = productName;
		this.description = description;
		this.status = status;
		this.gender = gender;
		this.category = category;
		this.brand = brand;
		this.material = material;
		this.images = images;
		this.priceDetails = priceDetails;
		this.promotionDetails = promotionDetails;
		this.sizeDetails = sizeDetails;
		this.ratings = ratings;
	}




	// Getters and setters

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public Set<Image> getImages() {
        return images;
    }

    public void setImages(Set<Image> images) {
        this.images = images;
    }

    public Set<PriceDetail> getPriceDetails() {
        return priceDetails;
    }

    public void setPriceDetails(Set<PriceDetail> priceDetails) {
        this.priceDetails = priceDetails;
    }

    public Set<PromotionDetail> getPromotionDetails() {
        return promotionDetails;
    }

    public void setPromotionDetails(Set<PromotionDetail> promotionDetails) {
        this.promotionDetails = promotionDetails;
    }

    public Set<SizeDetail> getSizeDetails() {
        return sizeDetails;
    }

    public void setSizeDetails(Set<SizeDetail> sizeDetails) {
        this.sizeDetails = sizeDetails;
    }

    public Set<Rating> getRatings() {
        return ratings;
    }

    public void setRatings(Set<Rating> ratings) {
        this.ratings = ratings;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return productId == product.productId && status == product.status && gender == product.gender && Objects.equals(productName, product.productName) && Objects.equals(description, product.description) && Objects.equals(category, product.category) && Objects.equals(brand, product.brand) && Objects.equals(material, product.material) && Objects.equals(images, product.images) && Objects.equals(priceDetails, product.priceDetails) && Objects.equals(promotionDetails, product.promotionDetails) && Objects.equals(sizeDetails, product.sizeDetails) && Objects.equals(ratings, product.ratings);
    }

    @Override
    public int hashCode() {
        return Objects.hash(productId, productName, description, status, gender, category, brand, material, images, priceDetails, promotionDetails, sizeDetails, ratings);
    }
}
