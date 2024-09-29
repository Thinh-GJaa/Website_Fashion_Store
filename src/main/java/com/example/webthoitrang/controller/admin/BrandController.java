package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.dto.EditBrandDto;
import com.example.webthoitrang.entity.Brand;
import com.example.webthoitrang.entity.Category;
import com.example.webthoitrang.services.BrandService;
import com.example.webthoitrang.services.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/admin/brand") // Định nghĩa đường dẫn chung
public class BrandController {

    @Autowired
    private BrandService brandService;

    @GetMapping
    public ModelAndView brandHome() {

        ModelAndView mav = new ModelAndView("admin/brand");
        mav.addObject("brandList", brandService.getAllBrand());
        mav.addObject("brandNew", new Brand());

        return mav;
    }


    @PostMapping
    public ResponseEntity<String> brandAdd(@RequestBody Brand brand) {
        try {
            //Kiểm tra tên thương hiệu đã tồn tại chưa
            if(brandService.getBrandByBrandName(brand.getBrandName()) != null) {
                return new ResponseEntity<>("Tên Thương hiệu đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            brandService.addOrUpdateBrand(brand);
            return new ResponseEntity<>("Thêm Thương hiệu mới thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi Thêm Thương hiệu mới !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping
    public ResponseEntity<String> brandEdit(@RequestBody EditBrandDto brandEdit) {
        try {
            System.out.println("brandId: "+ brandEdit.getBrandId());
            System.out.println("brandName: "+ brandEdit.getBrandName());
            System.out.println("brandNameNew: "+ brandEdit.getBrandNameNew());

            if(brandEdit.getBrandName().equalsIgnoreCase(brandEdit.getBrandNameNew())) {
                return new ResponseEntity<>("Tên không được trùng nhau", HttpStatus.CONFLICT);
            }

            Brand brand = brandService.getBrandById(brandEdit.getBrandId());

            if(brandService.getBrandByBrandName(brandEdit.getBrandNameNew()) != null) {
                return new ResponseEntity<>("Tên Thương hiệu đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            brand.setBrandName(brandEdit.getBrandNameNew());
            brandService.addOrUpdateBrand(brand);
            return new ResponseEntity<>("Sửa Thương hiệu thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi Sửa Thương hiệu !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }



}
