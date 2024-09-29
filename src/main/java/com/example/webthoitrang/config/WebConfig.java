package com.example.webthoitrang.config;

import com.example.webthoitrang.interceptor.AdminInterceptor;
import com.example.webthoitrang.interceptor.StaffInterceptor;
import com.example.webthoitrang.interceptor.UserInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final UserInterceptor userInterceptor;

    private final StaffInterceptor staffInterceptor;

    private final AdminInterceptor adminInterceptor;

    public WebConfig(StaffInterceptor staffInterceptor, UserInterceptor userInterceptor, AdminInterceptor adminInterceptor) {
        this.staffInterceptor = staffInterceptor;
        this.userInterceptor = userInterceptor;
        this.adminInterceptor = adminInterceptor;
    }

    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer.defaultContentType(MediaType.APPLICATION_FORM_URLENCODED);
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/404").setViewName("error404");
        registry.addViewController("/500").setViewName("error404");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(userInterceptor)
//                .addPathPatterns("/user/**") // Áp dụng cho các đường dẫn của user
//                .excludePathPatterns("/login", "/signup","/user/home","/user/category/**","user/cart/**"); // Loại trừ các đường dẫn không cần kiểm tra

        registry.addInterceptor(staffInterceptor)
                .addPathPatterns("/admin/**") // Áp dụng cho các đường dẫn của nhân viên
                .excludePathPatterns("/login-admin"); // Loại trừ các đường dẫn không cần kiểm tra
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns("/admin/statistic/**","/admin/account/**");

    }
}
