package com.example.webthoitrang.controller;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.services.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    @Autowired
    private AccountService accountService;

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        Object status = request.getAttribute("javax.servlet.error.status_code");
        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            if (statusCode == 404) {
                return "error404";
            } else if (statusCode == 500) {
                return "error404";
            }
        }
        return "error404";
    }

    @GetMapping("/take-me-away")
    public ModelAndView takeAway(HttpServletRequest request) {
        String email = JwtUtil.getEmailFromCookie(request);
        Account account = accountService.getAccountByEmail(email);
        if (account == null || account.getRole().getRoleName().equals("Customer")) {
            return new ModelAndView("redirect:/user/home");
        }
        return new ModelAndView("redirect:/admin/dashboard");
    }

}
