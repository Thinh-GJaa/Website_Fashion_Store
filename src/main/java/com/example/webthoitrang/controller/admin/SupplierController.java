package com.example.webthoitrang.controller.admin;


import com.example.webthoitrang.entity.Supplier;
import com.example.webthoitrang.services.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/admin/supplier") // Định nghĩa đường dẫn chung
public class SupplierController {

    private final SupplierService supplierService;

    public SupplierController(SupplierService supplierService) {
        this.supplierService = supplierService;
    }

    @GetMapping
    public ModelAndView supplierHome() {

        ModelAndView mav = new ModelAndView("admin/supplier");

        List<Supplier> supplierList = supplierService.getAllSuppliers();
        mav.addObject("supplier", new Supplier());
        mav.addObject("supplierList", supplierList);
        return mav;
    }

    @PostMapping
    public ResponseEntity<String> addSupplier(@RequestBody Supplier supplier) {
        try{
            //Kiểm tra tên NCC tồn tại và trả về lỗi
            if(supplierService.getSupplierBySupplierName(supplier.getSupplierName()) != null){
                return new ResponseEntity<>("Tên Nhà cung cấp này đã tồn tại", HttpStatus.CONFLICT);
            }

            //Kiểm tra email tồn tại và trả về lỗi
            if(supplierService.getSupplierByEmail(supplier.getEmail()) != null){
                return new ResponseEntity<>("Email này đã tồn tại", HttpStatus.CONFLICT);
            }

            //Kiểm tra SĐT tồn tại và trả về lỗi
            if(supplierService.getSupplierByPhoneNumber(supplier.getPhoneNumber()) != null){
                return new ResponseEntity<>("SĐT này đã tồn tại", HttpStatus.CONFLICT);
            }

            //Lưu và trả về thành công
            Supplier supplierCheck = supplierService.addOrUpdateSupplier(supplier);
            return new ResponseEntity<>("Thêm Nhà cung cấp thành công", HttpStatus.OK);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi thêm mới Nhà cung cấp !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PutMapping
    public ResponseEntity<String> editSupplier(@RequestBody Supplier supplier) {
        try {
            // Lấy thông tin nhà cung cấp hiện tại từ cơ sở dữ liệu
            Supplier existingSupplier = supplierService.getSupplierById(supplier.getSupplierId());

            // Kiểm tra tên nhà cung cấp
            if (!existingSupplier.getSupplierName().equals(supplier.getSupplierName())
                    && supplierService.getSupplierBySupplierName(supplier.getSupplierName()) != null) {
                return new ResponseEntity<>("Tên Nhà cung cấp này đã tồn tại", HttpStatus.CONFLICT);
            }

            // Kiểm tra email
            if (!existingSupplier.getEmail().equals(supplier.getEmail())
                    && supplierService.getSupplierByEmail(supplier.getEmail()) != null) {
                return new ResponseEntity<>("Email này đã tồn tại", HttpStatus.CONFLICT);
            }

            // Kiểm tra SĐT
            if (!existingSupplier.getPhoneNumber().equals(supplier.getPhoneNumber())
                    && supplierService.getSupplierByPhoneNumber(supplier.getPhoneNumber()) != null) {
                return new ResponseEntity<>("SĐT này đã tồn tại", HttpStatus.CONFLICT);
            }

            // Lưu và trả về thành công
            supplierService.addOrUpdateSupplier(supplier);
            return new ResponseEntity<>("Chỉnh sửa Nhà cung cấp thành công", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Chỉnh sửa Nhà cung cấp thất bại !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }




}
