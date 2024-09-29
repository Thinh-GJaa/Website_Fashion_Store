package com.example.webthoitrang.controller.user;

import com.example.webthoitrang.dto.ProductCartDto;
import com.example.webthoitrang.entity.SizeDetail;
import com.example.webthoitrang.entity.SizeDetailId;
import com.example.webthoitrang.services.ProductService;
import com.example.webthoitrang.services.SizeDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user/cart")
public class CartController {

    @Autowired
    private SizeDetailService sizeDetailService;

    @Autowired
    private ProductService productService;

    @GetMapping()
    public ModelAndView cart(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/cart");
        List<ProductCartDto> cartItems = new ArrayList<>();

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().startsWith("cart-")) {
                    String[] parts = cookie.getName().split("-");
                    if (parts.length == 3) {
                        try {
                            int productId = Integer.parseInt(parts[1]);
                            int sizeId = Integer.parseInt(parts[2]);
                            int quantity = Integer.parseInt(cookie.getValue());

                            SizeDetailId sizeDetailId = new SizeDetailId(sizeId, productId);
                            SizeDetail sizeDetail = sizeDetailService.getSizeDetailById(sizeDetailId);

                            if (sizeDetail != null) {
                                ProductCartDto productCartDto = new ProductCartDto();
                                productCartDto.setSizeDetail(sizeDetail);
                                productCartDto.setQuantity(quantity);
                                productCartDto.setPrice(productService.getPriceProduct(sizeDetail.getProduct()));

                                Double discountPrice = productService.getDiscountPriceProduct(productId);
                                if (discountPrice != null) {
                                    productCartDto.setPriceDiscount(productService.getDiscountPriceProduct(productId).floatValue());
                                }

                                cartItems.add(productCartDto);
                            }

                        } catch (NumberFormatException e) {
                            // Log lỗi thay vì chỉ in ra console
                            System.err.println("Lỗi định dạng số: " + e.getMessage());
                        }
                    }
                }
            }
        }


        mav.addObject("cartItems", cartItems);
        return mav;
    }

}


