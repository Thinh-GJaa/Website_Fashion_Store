package com.example.webthoitrang.controller;


import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.helper.FirebaseHelper;
import com.example.webthoitrang.services.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping
public class TmpController {

    @Autowired
    private AccountService accountService;

    @GetMapping("user/tmp")
    public ModelAndView tmp() {

        return new ModelAndView("user/tmp");
    }


}
