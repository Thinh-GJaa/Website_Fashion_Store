package com.example.webthoitrang.controller.user;


import com.example.webthoitrang.dto.ProductDto;
import com.example.webthoitrang.entity.Category;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.services.AprioriService;
import com.example.webthoitrang.services.CategoryService;
import com.example.webthoitrang.services.ProductService;
import com.example.webthoitrang.services.StatisticService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/user/home")
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private StatisticService statisticService;

    @Autowired
    private AprioriService aprioriService;

    @GetMapping
    public ModelAndView home(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/home");

        // Lấy danh sách sản phẩm
        List<Product> productList = null;

        // Lấy danh sách danh mục
        List<Category> categoryList = categoryService.getAllCategory();

        // Lấy danh sách sản phẩm bán chạy trong 30 ngày gần nhất
        List<ProductDto> topSellingProducts = convertDto(statisticService.getTop8SellingProductsByDate(LocalDateTime.now().minusDays(30),LocalDateTime.now()));

        // Lấy danh sách sản phẩm khuyến mãi
        Set<ProductDto> discountedProducts =new HashSet<>(convertDto(productService.getDiscountProducts())) ;

        // Lấy danh sách sản phẩm gợi ý
        Set<ProductDto> recommendedProducts = aprioriService.getRecommentProduct(request);

        // Lấy danh sách sản phẩm mới
        List<Product> newProducts = null;

        // Thêm các đối tượng vào ModelAndView
        mav.addObject("productList", productList);
        mav.addObject("categoryList", categoryList);
        mav.addObject("topSellingProducts", topSellingProducts);
        mav.addObject("discountedProducts", discountedProducts);
        mav.addObject("recommendedProducts", recommendedProducts);
        mav.addObject("newProducts", newProducts);

        return mav;
    }

    @GetMapping("/products")
    public ModelAndView products(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/home");
        List<ProductDto> productList = convertDto(productService.getAllProductValid());
        System.out.println("thinh size: " + productList.size());
        List<Category> categoryList = categoryService.getAllCategory();

        List<ProductDto> topSellingProducts = null;
        Set<ProductDto> discountedProducts = null;
        Set<ProductDto> recommendedProducts = null;
        List<Product> newProducts = null;

        // Thêm các đối tượng vào ModelAndView
        mav.addObject("productList", productList);
        mav.addObject("categoryList", categoryList);
        mav.addObject("topSellingProducts", topSellingProducts);
        mav.addObject("discountedProducts", discountedProducts);
        mav.addObject("recommendedProducts", recommendedProducts);
        mav.addObject("newProducts", newProducts);
        return mav;
    }


    @GetMapping("/promotions")
    public ModelAndView promotions(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/home");
        List<Category> categoryList = categoryService.getAllCategory();
        List<ProductDto> discountedProducts = convertDto(productService.getDiscountProducts());

        List<ProductDto> topSellingProducts = null;
        Set<ProductDto> recommendedProducts = null;
        List<Product> newProducts = null;
        List<ProductDto> productList = null;


        // Thêm các đối tượng vào ModelAndView
        mav.addObject("productList", productList);
        mav.addObject("categoryList", categoryList);
        mav.addObject("topSellingProducts", topSellingProducts);
        mav.addObject("discountedProducts", discountedProducts);
        mav.addObject("recommendedProducts", recommendedProducts);
        mav.addObject("newProducts", newProducts);
        return mav;
    }

    @GetMapping("/search")
    public ModelAndView search(HttpServletRequest request,
                                   @RequestParam("keyword") String keyword) {
        ModelAndView mav = new ModelAndView("user/search");
        List<ProductDto> productList = convertDto(productService.getProductsByKeyword(keyword));
        mav.addObject("productList", productList);
        mav.addObject("keyword", keyword);
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

            if (discountPrice != null) {
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
        }
        return productDtoList;
    }
}


