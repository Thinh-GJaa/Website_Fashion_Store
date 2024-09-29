package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.dto.EditMaterialDto;
import com.example.webthoitrang.entity.Material;
import com.example.webthoitrang.services.MaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/material") // Định nghĩa đường dẫn chung
public class MaterialController {

    @Autowired
    private MaterialService materialService;

    @GetMapping
    public ModelAndView materialHome() {

        ModelAndView mav = new ModelAndView("admin/material");
        mav.addObject("materialList", materialService.getAllMaterial());
        mav.addObject("material", new Material());
        return mav;
    }


    @PostMapping
    public ResponseEntity<String> materialAdd(@RequestBody Material material) {
        try {
            //Kiểm tra tên thương hiệu đã tồn tại chưa
            if(materialService.getMaterialByMaterialName(material.getMaterialName()) != null) {
                return new ResponseEntity<>("Tên Chất liệu đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            materialService.addOrUpdateMaterial(material);
            return new ResponseEntity<>("Thêm Chất liệu  mới thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi Thêm Chất liệu mới !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping
    public ResponseEntity<String> materialEdit(@RequestBody EditMaterialDto materialEdit) {
        try {
            System.out.println("materialId: "+ materialEdit.getMaterialId());
            System.out.println("materialName: "+ materialEdit.getMaterialName());
            System.out.println("materialNameNew: "+ materialEdit.getMaterialNameNew());

            if(materialEdit.getMaterialName().equalsIgnoreCase(materialEdit.getMaterialNameNew())) {
                return new ResponseEntity<>("Tên không được trùng nhau", HttpStatus.CONFLICT);
            }

            Material material = materialService.getMaterialById(materialEdit.getMaterialId());

            if(materialService.getMaterialByMaterialName(materialEdit.getMaterialNameNew()) != null) {
                return new ResponseEntity<>("Tên Chất liệu đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            material.setMaterialName(materialEdit.getMaterialNameNew());
            materialService.addOrUpdateMaterial(material);
            return new ResponseEntity<>("Sửa Chất liệu thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi Sửa Chất liệu !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }



}
