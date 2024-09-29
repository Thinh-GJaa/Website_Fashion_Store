package com.example.webthoitrang.login_google;

import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.services.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static com.example.webthoitrang.bean.JwtUtil.addTokenToCookie;

@Component
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired
    private AccountService accountService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // Lấy email từ session hoặc từ authentication
        String email = (String) request.getSession().getAttribute("emailSignup");

        // Kiểm tra nếu email đã tồn tại trong database
        Account account = accountService.getAccountByEmail(email);

        if (account != null) {
            // Chuyển hướng đến trang home nếu email đã tồn tại
            addTokenToCookie(response, account.getEmail());

            // Lưu tên vào session
            HttpSession session = request.getSession();
            session.setAttribute("username", account.getCustomer().getCustomerName());
            session.setMaxInactiveInterval(24 * 60 * 60); // 24 giờ, đơn vị là giây
            setDefaultTargetUrl("/user/home");
        } else {
            // Chuyển hướng đến trang đăng ký nếu email chưa tồn tại
            setDefaultTargetUrl("/signup");
        }

        // Gọi phương thức cha để hoàn thành quá trình xác thực thành công
        super.onAuthenticationSuccess(request, response, authentication);
    }
}
