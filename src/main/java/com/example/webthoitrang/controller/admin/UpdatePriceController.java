package com.example.webthoitrang.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/product/update-price")
public class UpdatePriceController {

    @GetMapping("/admin/dashboard")
    public ModelAndView dashboard() {
        ModelAndView mav = new ModelAndView("admin/dashboard");
        return mav;
    }

}
