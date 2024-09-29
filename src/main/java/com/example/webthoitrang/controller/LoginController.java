package com.example.webthoitrang.controller;


import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.entity.Customer;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.entity.Role;
import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.CustomerService;
import com.example.webthoitrang.services.EmailService;
import com.example.webthoitrang.services.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import static com.example.webthoitrang.bean.JwtUtil.addTokenToCookie;

@Controller
public class LoginController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private EmailService emailService;

    @GetMapping("/login-admin")
    public ModelAndView loginAdmin() {

        ModelAndView mav = new ModelAndView("login-admin");
        return mav;
    }

    @PostMapping("/login-admin")
    public ModelAndView loginAdmin(@RequestParam String username, @RequestParam String password,
                                   HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        Account account = accountService.authenticateAdmin(username, password);

        System.out.println("thinh: " + username + " " + password);

        if (account == null) {
            ModelAndView mav = new ModelAndView("login-admin");
            mav.addObject("message", "Tên đăng nhập hoặc mật khẩu không đúng");
            return mav;
        }


        if (!account.getStatus()) {
            ModelAndView mav = new ModelAndView("login-admin");
            mav.addObject("message", "Tài khoản này đã bị khóa!!!<br>Vui lòng liên hệ quản lý để biết thêm thông tin");
            return mav;

        }

        ModelAndView mav = new ModelAndView("redirect:/admin/order/pending");

        addTokenToCookie(response, account.getEmail());

        // Lưu tên vào session
        HttpSession session = request.getSession();
        session.setAttribute("usernameAdmin", account.getStaff().getStaffFullName());
        session.setAttribute("imageAdmin", account.getStaff().getImage().getLinkImage());
        session.setMaxInactiveInterval(10 * 60 * 60); // 10 giờ, đơn vị là giây

        return mav;

    }

    @GetMapping("/admin/logout")
    public ModelAndView logoutAdmin(HttpServletResponse response) {

        String accessToken = "accessToken";
        JwtUtil.deleteCookie(response, accessToken);
        ModelAndView mav = new ModelAndView("redirect:/login-admin");
        return mav;
    }

    @GetMapping("/login")
    public ModelAndView loginCustomer() {

        ModelAndView mav = new ModelAndView("login");
        mav.addObject("username", "");
        mav.addObject("password", "");
        return mav;
    }

    @PostMapping("/login")
    public ModelAndView loginUser(@RequestParam String username, @RequestParam String password,
                                  HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        Account account = accountService.authenticateCustomer(username, password);

        System.out.println("thinhuser: " + username + " " + password);

        if (account == null) {
            ModelAndView mav = new ModelAndView("login");
            mav.addObject("username", username);
            mav.addObject("password", password);
            mav.addObject("message", "Tên đăng nhập hoặc mật khẩu không đúng");
            return mav;
        }


        if (!account.getStatus()) {
            ModelAndView mav = new ModelAndView("login");
            mav.addObject("username", username);
            mav.addObject("password", password);
            mav.addObject("message", "Tài khoản này đã bị khóa!!!<br>Vui lòng liên hệ cửa hàng để biết thêm thông tin");
            return mav;

        }

        ModelAndView mav = new ModelAndView("redirect:/user/home");
        addTokenToCookie(response, account.getEmail());

        // Lưu tên vào session
        HttpSession session = request.getSession();
        session.setAttribute("username", account.getCustomer().getCustomerName());
        session.setMaxInactiveInterval(10 * 60 * 60); // 10 giờ, đơn vị là giây

        return mav;


    }

    @GetMapping("/user/logout")
    public ModelAndView logoutUser(HttpServletResponse response, HttpServletRequest request) {

        String accessToken = "accessToken";
        JwtUtil.deleteCookie(response, accessToken);

        // Xóa username khỏi session
        HttpSession session = request.getSession();
        session.removeAttribute("username");

        ModelAndView mav = new ModelAndView("redirect:/login");
        return mav;
    }

    @GetMapping("/forgot-password")
    public ModelAndView forgotPassword() {
        ModelAndView mav = new ModelAndView("forgot-password");
        return mav;
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<String> forgotPasswordPost(@RequestParam("email") String email) {
        try{
            Account account = accountService.getAccountByEmail(email);
            System.out.println("thinh email: " + email);

            if (account == null) {
                return new ResponseEntity<>("Email này chưa được đăng kí tài khoản", HttpStatus.BAD_REQUEST);
            }

            if (!account.getStatus()) {
                return new ResponseEntity<>("Email này đã bị khóa.<br>Vui lòng liên hệ cửa hàng để biết thêm thông tin", HttpStatus.BAD_REQUEST);
            }

            //Link tồn tại trong 90s
            String time = LocalDateTime.now().plusSeconds(90).toString();
            System.out.println("thinh time: " + time);
            String forgotPwdId = account.getEmail() + "#" + time;
            forgotPwdId = JwtUtil.generateToken(forgotPwdId);
            String link = "http://localhost:8080/forgot-password-email/" + forgotPwdId;
            System.out.println("forgotPwdId: " + link);

            String text = "Link chỉ tồn tại trong 90s.\nNhấn vào link dưới lấy mật khẩu mới: \n" + link;

            emailService.sendEmail(account.getEmail(), "Quên mật khẩu", text);

            return new ResponseEntity<>("Vui lòng kiểm tra tin nhắn Email", HttpStatus.OK);

        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("/forgot-password-email/{token}")
    public ModelAndView forgotPasswordEmail(@PathVariable String token) {

        String time = JwtUtil.decodeToken(token).getSubject().split("#")[1];

        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
        LocalDateTime dateTime = LocalDateTime.parse(time, formatter);

        if (dateTime.isBefore(LocalDateTime.now())) {
            return new ModelAndView("error404");
        }

        ModelAndView mav = new ModelAndView("forgot-password-email");
        mav.addObject("token", token);
        return mav;
    }

    @PostMapping("/forgot-password-email")
    public ResponseEntity<String> forgotPasswordEmailPost(@RequestParam("token") String token,
                                                          @RequestParam("password") String password,
                                                          @RequestParam("confirmPassword") String confirmPassword) {

        try{

            String email = JwtUtil.decodeToken(token).getSubject().split("#")[0];
            Account account = accountService.getAccountByEmail(email);

            if (account == null) {
                return new ResponseEntity<>("Email này chưa được đăng kí!!!", HttpStatus.BAD_REQUEST);
            }

            if (!account.getStatus()) {
                return new ResponseEntity<>("Email này đã cin khóa.!!!<br>" +
                        "Vui lòng liên hệ cửa hàng để biết thêm", HttpStatus.BAD_REQUEST);

            }

            if(password.length() < 6){
                return new ResponseEntity<>("Mật khẩu tối đa 6 kí tự!!", HttpStatus.BAD_REQUEST);
            }

            if(!password.equals(confirmPassword)){
                return new ResponseEntity<>("Mật khẩu xác nhận không trùng khớp", HttpStatus.BAD_REQUEST);
            }

            account.setPassword(password);
            accountService.addOrUpdateAccount(account);

            return new ResponseEntity<>("Đã đổi mật khẩu mới thành công", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Đã xãy ra lỗi !!!", HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    @GetMapping("/signup")
    public ModelAndView signup() {
        ModelAndView mav = new ModelAndView("signup");
        mav.addObject("customer", new Customer());
        return mav;
    }

    @PostMapping("/signup")
    public ResponseEntity<String> processSignup(@ModelAttribute("customer") Customer customer, @RequestParam("confirmPwd") String confirmPwd,
                                                HttpServletResponse response, HttpServletRequest request,
                                                HttpSession session) {
        try {
            // Kiểm tra email đã tồn tại chưa
            if (accountService.getAccountByEmail(customer.getAccount().getEmail()) != null) {
                return new ResponseEntity<>("Email này đã tồn tại", HttpStatus.BAD_REQUEST);
            }

            // Kiểm tra pass ít nhất 6 kí tự
            if (customer.getAccount().getPassword().length() < 6) {
                return new ResponseEntity<>("Mật khẩu ít nhất 6 kí tự!!!", HttpStatus.BAD_REQUEST);
            }

            // Kiểm tra pass trùng khớp không
            if (!customer.getAccount().getPassword().equals(confirmPwd)) {
                return new ResponseEntity<>("Mật khẩu không trùng khớp!!!", HttpStatus.BAD_REQUEST);
            }

            // Kiểm tra SĐT đã tồn tại chưa
            if (accountService.getAccountByPhoneNumber(customer.getAccount().getPhoneNumber()) != null) {
                return new ResponseEntity<>("Số điện thoại này đã tồn tại!!!", HttpStatus.BAD_REQUEST);
            }



            Account account = customer.getAccount();
            account.setRole(new Role(3));
            account.setStatus(true);
            account.setCreateDate( new Date());
            accountService.addOrUpdateAccount(account);

            if(session.getAttribute("pictureSignup") != null) {
                Image image = new Image();
                image.setLinkImage((String) session.getAttribute("pictureSignup"));
                imageService.addOrUpdateImage(image);
                customer.setImage(image);
            }

            customer = customerService.addOrUpdateCustomer(customer);

            JwtUtil.addTokenToCookie(response, customer.getAccount().getEmail());

            // Lưu tên vào session
            session = request.getSession();
            session.setAttribute("username", customer.getCustomerName());
            session.setMaxInactiveInterval(10 * 60 * 60); // 10 giờ, đơn vị là giây

            session.removeAttribute("emailSignup");
            session.removeAttribute("nameSignup");
            session.removeAttribute("pictureSignup");

            // Nếu không có lỗi
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi đăng kí tài khoản!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


}
