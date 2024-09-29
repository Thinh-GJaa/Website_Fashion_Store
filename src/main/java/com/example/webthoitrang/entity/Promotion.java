package com.example.webthoitrang.entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "promotion")
public class Promotion implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "promotion_id")
    private int promotionId;

    @Column(name = "promotion_name", nullable = false)
    private String promotionName;

    @Column(name = "start_date", nullable = false)
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    @ManyToOne
    @JoinColumn(name = "staff_id")
    private Staff staff;

    @OneToMany(mappedBy = "promotion", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<PromotionDetail> promotionDetails = new HashSet<>();

    public Promotion() {
        super();
    }

    public Promotion(int promotionId) {
        this.promotionId = promotionId;
    }

    public Promotion(String promotionName, Date startDate, Date endDate, Staff staff,
                     Set<PromotionDetail> promotionDetails) {
		super();
		this.promotionName = promotionName;
		this.startDate = startDate;
		this.endDate = endDate;
		this.staff = staff;
		this.promotionDetails = promotionDetails;
	}

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getPromotionName() {
        return promotionName;
    }

    public void setPromotionName(String promotionName) {
        this.promotionName = promotionName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Set<PromotionDetail> getPromotionDetails() {
        return promotionDetails;
    }

    public void setPromotionDetails(Set<PromotionDetail> promotionDetails) {
        this.promotionDetails = promotionDetails;
    }
}
