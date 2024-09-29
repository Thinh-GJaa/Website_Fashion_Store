package com.example.webthoitrang.controller.user;

import com.example.webthoitrang.dto.ProductDto;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.services.CategoryService;
import com.example.webthoitrang.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller("user")
@RequestMapping("/user/category")
public class CategoryController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("{categoryId}")
    public ModelAndView category(@PathVariable int categoryId) {

        ModelAndView mav = new ModelAndView("user/category");
        mav.addObject("productList", convertDto(productService.getProductByCategoryId(categoryId)) );
        mav.addObject("category", categoryService.getCategoryById(categoryId));
        return mav;

    }


    private List<ProductDto> convertDto(List<Product> productList) {
        List<ProductDto> productDtoList = new ArrayList<>();

        for (Product product : productList) {
            ProductDto productDto = new ProductDto();
            productDto.setProductId(product.getProductId());
            productDto.setProductName(product.getProductName());
            productDto.setPrice(productService.getPriceProduct(product));

            Double discountPrice = productService.getDiscountPriceProduct(product.getProductId());

            if(discountPrice != null) {
                productDto.setDiscountPrice(discountPrice);
            }

            Iterator<Image> iterator = product.getImages().iterator();
            if (iterator.hasNext()) {
                Image image = iterator.next();
                if(image != null){
                    productDto.setProductImage(image.getLinkImage());
                }
            }
            productDtoList.add(productDto);


            System.out.println("thinh: " + productDto.getProductName());
            System.out.println("thinh: " + productDto.getDiscountPrice());
        }
        return productDtoList;
    }
}
