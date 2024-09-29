package com.example.webthoitrang.dto;

public class EditSizeDto {
    private int sizeId;
    private String sizeName;
    private String sizeNameNew;

    public EditSizeDto() {}

    public EditSizeDto(int sizeId, String sizeName, String sizeNameNew) {
        this.sizeId = sizeId;
        this.sizeName = sizeName;
        this.sizeNameNew = sizeNameNew;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public String getSizeNameNew() {
        return sizeNameNew;
    }

    public void setSizeNameNew(String sizeNameNew) {
        this.sizeNameNew = sizeNameNew;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

}
