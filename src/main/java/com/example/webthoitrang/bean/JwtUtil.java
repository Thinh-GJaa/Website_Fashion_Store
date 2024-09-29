package com.example.webthoitrang.bean;

import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.services.AccountService;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.SignatureException;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

public class JwtUtil {
    private static final String SECRET_KEY = "webthoitrang"; // Khóa bí mật có thể thay đổi

    @Autowired
    private AccountService accountService;
    //Tạo token
    public static String generateToken(String username) {
        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);
        long expMillis = nowMillis + 36000000; // 10 giờ
        Date exp = new Date(expMillis);

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(now)
                .setExpiration(exp)
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    //Thêm token vào cookie
    public static void addTokenToCookie(HttpServletResponse response, String username) {
        String accessToken = generateToken(username);
        Cookie cookie = new Cookie("accessToken", accessToken);
        cookie.setHttpOnly(true); // Chỉ truy cập qua HTTP, không thể truy cập qua JavaScript
        cookie.setSecure(true); // Chỉ gửi qua HTTPS
        cookie.setPath("/"); // Đặt path cho cookie
        cookie.setMaxAge(36000); // Thời gian sống của cookie (10 giờ)
        response.addCookie(cookie);
    }

    //Giải mã token
    public static Claims decodeToken(String accessToken) {
        try {
            return Jwts.parser()
                    .setSigningKey(SECRET_KEY)
                    .parseClaimsJws(accessToken)
                    .getBody();
        } catch (SignatureException e) {
            throw new RuntimeException("Invalid token");
        }
    }

    //Lấy token từ cookie t
    public static String getEmailFromCookie(HttpServletRequest request) {

        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("accessToken".equals(cookie.getName())) {
                    return decodeToken(cookie.getValue()).getSubject();
                }
            }
        }
        return null;
    }

    public static void deleteCookie(HttpServletResponse response, String cookieName) {
        Cookie cookie = new Cookie(cookieName, "");
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
}
