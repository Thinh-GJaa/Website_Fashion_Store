package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.services.CategoryService;
import com.example.webthoitrang.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

    @Autowired
    private ProductService productService;

    @GetMapping("/admin/dashboard")
    public ModelAndView dashboard() {
        ModelAndView mav = new ModelAndView("admin/dashboard");
        return mav;
    }

    @GetMapping("/admin/tmp")
    public ModelAndView home() {

        ModelAndView mav = new ModelAndView("admin/tmp");

        return mav;
    }
}
