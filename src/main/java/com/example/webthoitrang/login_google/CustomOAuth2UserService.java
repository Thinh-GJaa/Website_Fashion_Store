package com.example.webthoitrang.login_google;

import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final HttpSession session;

    @Autowired
    public CustomOAuth2UserService(HttpSession session) {
        this.session = session;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        // Lấy các thuộc tính từ oAuth2User
        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");
        String picture = oAuth2User.getAttribute("picture");

        // Lưu vào session
        session.setAttribute("emailSignup", email);
        session.setAttribute("nameSignup", name);
        session.setAttribute("pictureSignup", picture);


        System.out.println("thinh: " + email);
        System.out.println("thinh: " + name);
        System.out.println("thinh: " + picture);
        System.out.println("thinh: " + oAuth2User.getAttributes());

        return oAuth2User;
    }
}
