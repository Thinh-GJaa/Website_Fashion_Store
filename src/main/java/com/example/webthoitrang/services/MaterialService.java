package com.example.webthoitrang.services;


import com.example.webthoitrang.entity.Material;
import com.example.webthoitrang.repository.MaterialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MaterialService {

    private final MaterialRepository materialRepository;

    @Autowired
    public MaterialService(MaterialRepository materialRepository) {this.materialRepository = materialRepository;}

    public List<Material> getAllMaterial() {return materialRepository.findAll();}

    public Material addOrUpdateMaterial(Material material) {return materialRepository.save(material);}

    public Material getMaterialByMaterialName(String materialName) {return materialRepository.findByMaterialName(materialName);}

    public Material getMaterialById(int id) {return materialRepository.findById(id).orElse(null);}


}
