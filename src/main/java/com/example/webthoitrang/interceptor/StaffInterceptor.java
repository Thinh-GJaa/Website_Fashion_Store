package com.example.webthoitrang.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.services.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class StaffInterceptor implements HandlerInterceptor {

    @Autowired
    private AccountService accountService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("accessToken".equals(cookie.getName())) {
                    String accessToken = cookie.getValue();
                    // Kiểm tra token hợp lệ và quyền truy cập
                    if (isValidStaffToken(request, accessToken)) {
                        return true;
                    }
                }
            }
        }
        response.sendRedirect("/login-admin"); // Chuyển hướng đến trang đăng nhập nếu không có quyền
        return false;
    }

    private boolean isValidStaffToken(HttpServletRequest request, String accessToken) {
        String email = JwtUtil.getEmailFromCookie(request);
        Account account = accountService.getAccountByEmail(email);
        String roleName = account.getRole().getRoleName();
        System.out.println("thinh:" +roleName);
        return roleName.equals("Staff") || roleName.equals("Admin");
    }
}
