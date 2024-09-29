package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.dto.EditSizeDto;
import com.example.webthoitrang.entity.Size;
import com.example.webthoitrang.services.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/size") // Định nghĩa đường dẫn chung
public class SizeController {

    @Autowired
    private SizeService sizeService;

    @GetMapping
    public ModelAndView sizeHome() {

        ModelAndView mav = new ModelAndView("admin/size");
        mav.addObject("sizeList", sizeService.getAllSize());
        mav.addObject("sizeNew", new Size());

        return mav;
    }


    @PostMapping
    public ResponseEntity<String> sizeAdd(@RequestBody Size size) {
        try {
            //Kiểm tra tên thương hiệu đã tồn tại chưa
            if(sizeService.getSizeBySizeName(size.getSizeName()) != null) {
                return new ResponseEntity<>("Tên Size đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            sizeService.addOrUpdateSize(size);
            return new ResponseEntity<>("Thêm Size mới thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi Thêm Size mới !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping
    public ResponseEntity<String> sizeEdit(@RequestBody EditSizeDto sizeEdit) {
        try {
            System.out.println("sizeId: "+ sizeEdit.getSizeId());
            System.out.println("sizeName: "+ sizeEdit.getSizeName());
            System.out.println("sizeNameNew: "+ sizeEdit.getSizeNameNew());

            if(sizeEdit.getSizeName().equalsIgnoreCase(sizeEdit.getSizeNameNew())) {
                return new ResponseEntity<>("Tên Size không được trùng nhau", HttpStatus.CONFLICT);
            }

            Size size = sizeService.getSizeById(sizeEdit.getSizeId());

            if(sizeService.getSizeBySizeName(sizeEdit.getSizeNameNew()) != null) {
                return new ResponseEntity<>("Tên Size đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            size.setSizeName(sizeEdit.getSizeNameNew());
            sizeService.addOrUpdateSize(size);
            return new ResponseEntity<>("Sửa Size thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi Sửa Size !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }



}
