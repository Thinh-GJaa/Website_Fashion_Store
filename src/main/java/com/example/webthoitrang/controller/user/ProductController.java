package com.example.webthoitrang.controller.user;


import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.entity.Rating;
import com.example.webthoitrang.entity.SizeDetail;
import com.example.webthoitrang.entity.SizeDetailId;
import com.example.webthoitrang.services.ProductService;
import com.example.webthoitrang.services.SizeDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@Controller("UserProductController")
@RequestMapping("/user/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private SizeDetailService sizeDetailService;

    @GetMapping("/{productId}")
    public ModelAndView showProduct(@PathVariable("productId") int productId ) {
        ModelAndView mav = new ModelAndView("user/product");

        Product product = productService.getProductById(productId);

        //Tính trung bình điểm đánh giá
        double ratingScore = 0;

        if(productService.getRatingProduct(productId) != null) {
            ratingScore = productService.getRatingProduct(productId);
        }

        ratingScore /= product.getRatings().size();
        System.out.println("ratingScore = " + ratingScore);


        System.out.println("thinh: " + productService.getDiscountPriceProduct(productId));

        mav.addObject("product", product);
        mav.addObject("price", productService.getPriceProduct(product));
        mav.addObject("discountPrice", productService.getDiscountPriceProduct(productId));
        mav.addObject("rating", ratingScore);
        return mav;
    }

    @PostMapping("/add-cart")
    public ResponseEntity<String> addCart(@RequestBody SizeDetailId sizeDetailId, HttpServletResponse response) {
        try{
            System.out.println("thinh: "+sizeDetailId.getProductId());
            System.out.println("thinh: "+sizeDetailId.getSizeId());
            SizeDetail sizeDetail = sizeDetailService.getSizeDetailById(sizeDetailId);

            if(sizeDetail.getQuantity() <= 0 ) {
                return new ResponseEntity<>("Sản phẩm, size đã hết hàng!!!", HttpStatus.CONFLICT);
            }

            String cookieCart = "cart-"+ sizeDetailId.getProductId()+"-"+sizeDetailId.getSizeId();
            String quantity = "1";

            Cookie cookie = new Cookie(cookieCart, quantity);
            cookie.setMaxAge(1000000); // Đặt thời gian sống của cookie (đơn vị là giây)
            cookie.setPath("/"); // Đặt phạm vi cookie, ở đây là toàn bộ ứng dụng
            response.addCookie(cookie); // Thêm cookie vào phản hồi

            return new ResponseEntity<>("Thêm vào giỏ hàng thành công", HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>("Lỗi thêm vào giỏ hàng!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
