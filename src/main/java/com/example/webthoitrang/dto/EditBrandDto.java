package com.example.webthoitrang.dto;

public class EditBrandDto {
    private int brandId;
    private String brandName;
    private String brandNameNew;

    public EditBrandDto() {}

    public EditBrandDto(int brandId, String brandName, String brandNameNew) {
        this.brandId = brandId;
        this.brandName = brandName;
        this.brandNameNew = brandNameNew;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getBrandNameNew() {
        return brandNameNew;
    }

    public void setBrandNameNew(String brandNameNew) {
        this.brandNameNew = brandNameNew;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

}
