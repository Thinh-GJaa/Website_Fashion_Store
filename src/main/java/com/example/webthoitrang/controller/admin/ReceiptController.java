package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.dto.ProductReceiptDto;
import com.example.webthoitrang.entity.*;
import com.example.webthoitrang.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Transactional
@Controller
@RequestMapping("/admin/receipt") // Định nghĩa đường dẫn chung
public class ReceiptController {

    @Autowired
    private ReceiptService receiptService;

    @Autowired
    private ProductService productService;

    @Autowired
    private SupplierService supplierService;

    @Autowired
    private SizeDetailService sizeDetailService;

    @Autowired
    private SizeService sizeService;
    @Autowired
    private AccountService accountService;

    @GetMapping
    public ModelAndView receiptHome() {
        ModelAndView mav = new ModelAndView("admin/receipt");

        //Thêm danh sách Phiếu nhập
        mav.addObject("receiptList", receiptService.getAllReReceipt());

        return mav;
    }

    @GetMapping("/add")
    public ModelAndView receiptAddHome() {
        ModelAndView mav = new ModelAndView("admin/receipt-add");

        //Thêm danh sách các thuộc tính của sản phẩm
        mav.addObject("productList", productService.getAllProduct());
        mav.addObject("supplierList", supplierService.getAllSuppliers());
        mav.addObject("sizeList", sizeService.getAllSize());

        return mav;
    }

    @PostMapping()
    public ResponseEntity<String> receiptAdd(@RequestParam("supplier") int supplierId, @RequestBody List<ProductReceiptDto> productReceiptList,
                                             HttpServletRequest request) {
        try{

            Staff staff = accountService.getAccountByEmail(JwtUtil.getEmailFromCookie(request)).getStaff();

            Receipt receipt = new Receipt();
            receipt = receiptService.addOrUpdateReceipt(receipt);

            Set<ReceiptDetail> receiptDetailList = new HashSet<>();

            for (ProductReceiptDto productReceipt : productReceiptList) {
                System.out.println("productReceiptDto: " + productReceipt.toString());
                ReceiptDetail receiptDetail = new ReceiptDetail();

                SizeDetail sizeDetail = new SizeDetail();

                SizeDetailId sizeDetailId = new SizeDetailId();
                sizeDetailId.setSizeId(productReceipt.getSizeId());
                sizeDetailId.setProductId(productReceipt.getProductId());

                sizeDetail.setSizeDetailId(sizeDetailId);

                //Nếu product size chưa có thì thêm vào nếu có rồi thì cộng số lượng
                if(sizeDetailService.getSizeDetailById(sizeDetailId) == null) {
                    sizeDetail.setQuantity(0);
                    sizeDetailService.addOrUpdateSizeDetail(sizeDetail);
                }
                else{
                    sizeDetail = sizeDetailService.getSizeDetailById(sizeDetailId);
                    sizeDetail.setQuantity(Integer.parseInt(sizeDetail.getQuantity() + productReceipt.getProductQuantity()));
                    sizeDetailService.addOrUpdateSizeDetail(sizeDetail);
                }

                receiptDetail.setSizeDetail(sizeDetail);
                receiptDetail.setImportPrice(Float.parseFloat(productReceipt.getProductPrice()));
                receiptDetail.setQuantity(Integer.parseInt(productReceipt.getProductQuantity()));

                ReceiptDetailId receiptDetailId = new ReceiptDetailId();
                receiptDetailId.setReceiptId(receipt.getReceiptId());
                receiptDetailId.setProductId(productReceipt.getProductId());
                receiptDetailId.setSizeId(productReceipt.getSizeId());

                receiptDetail.setReceiptDetailId(receiptDetailId);

                receiptDetailList.add(receiptDetail);

            }

            LocalDateTime createDate = LocalDateTime.now();

            Supplier supplier = new Supplier(supplierId);
            receipt.setSupplier(supplier);
            receipt.setReceiptDetails(receiptDetailList);
            receipt.setCreateDate(createDate);
            receipt.setStaff(staff);
            receiptService.addOrUpdateReceipt(receipt);

            return new ResponseEntity<>("Thêm Phiếu nhập hàng thành công", HttpStatus.OK);
        }catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi thêm Phiếu nhập hàng!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }





}
