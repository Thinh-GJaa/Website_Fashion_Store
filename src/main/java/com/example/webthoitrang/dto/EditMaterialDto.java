package com.example.webthoitrang.dto;

public class EditMaterialDto {
    private int materialId;
    private String materialName;
    private String materialNameNew;

    public EditMaterialDto() {}

    public EditMaterialDto(int materialId, String materialName, String materialNameNew) {
        this.materialId = materialId;
        this.materialName = materialName;
        this.materialNameNew = materialNameNew;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public String getMaterialNameNew() {
        return materialNameNew;
    }

    public void setMaterialNameNew(String materialNameNew) {
        this.materialNameNew = materialNameNew;
    }

    public int getMaterialId() {
        return materialId;
    }

    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

}
