package com.example.webthoitrang.dto;


import java.sql.Date;
import java.util.List;

public class PromotionDto {
    private String promotionName;
    private Date startDate;
    private Date endDate ;

    List<ProductPromotionDto> promotionDetails;

    public PromotionDto() {
    }

    public PromotionDto(String promotionName, Date startDate, Date endDate, List<ProductPromotionDto> promotionDetails) {
        this.promotionName = promotionName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.promotionDetails = promotionDetails;
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

    public List<ProductPromotionDto> getPromotionDetails() {
        return promotionDetails;
    }

    public void setPromotionDetails(List<ProductPromotionDto> promotionDetails) {
        this.promotionDetails = promotionDetails;
    }

    public String getPromotionName() {
        return promotionName;
    }

    public void setPromotionName(String promotionName) {
        this.promotionName = promotionName;
    }

    @Override
    public String toString() {
        return "PromotionDto{" +
                "promotionName='" + promotionName + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", promotionDetails=" + promotionDetails +
                '}';
    }

}
