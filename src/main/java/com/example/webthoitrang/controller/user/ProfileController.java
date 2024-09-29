package com.example.webthoitrang.controller.user;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.entity.Customer;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.entity.Staff;
import com.example.webthoitrang.helper.FirebaseHelper;
import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.CustomerService;
import com.example.webthoitrang.services.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller("userProfileController")
@RequestMapping("/user")
public class ProfileController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ImageService imageService;


    @GetMapping("/profile")
    public ModelAndView profile(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("user/profile");
        String email = JwtUtil.getEmailFromCookie(request);
        Account account = accountService.getAccountByEmail(email);
        Customer customer = account.getCustomer();
        modelAndView.addObject("customer", customer);
        return modelAndView;
    }

    @PutMapping("/profile")
    public ResponseEntity<String> editProfile(@ModelAttribute("customer") Customer customer,
                                              @RequestParam("imageInput") MultipartFile imageInput) {
        try{
            System.out.println("thinh-staffId:" + customer.getCustomerId());
            System.out.println("thinh:" + customer.getAccount().getEmail());

            if(!imageInput.isEmpty()){
                String linkImage = FirebaseHelper.uploadImageStaff(customer.getCustomerId(), imageInput);
                Image image = customer.getImage();
                image.setLinkImage(linkImage);
                imageService.addOrUpdateImage(image);
            }

            customerService.addOrUpdateCustomer(customer);

            Account account = accountService.getAccountById(customer.getAccount().getAccountId());
            account.setEmail(customer.getAccount().getEmail());
            account.setPhoneNumber(customer.getAccount().getPhoneNumber());
            accountService.addOrUpdateAccount(account);

            return new ResponseEntity<>("Đã cập nhật thông tin cá  nhân", HttpStatus.OK);
        }
        catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi cập nhật thông tin cá nhân!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("/change-password")
    public ModelAndView changePassword(HttpServletRequest request) {
        return new ModelAndView("user/change-password");
    }



    @PostMapping("change-password")
    public ResponseEntity<String> changePwd(@RequestParam("currentPassword") String currentPassword,
                                            @RequestParam("newPassword") String newPassword,
                                            HttpServletRequest request) {
        try{
            String email = JwtUtil.getEmailFromCookie(request);

            Account account = accountService.getAccountByEmail(email);

            if(!currentPassword.equals(account.getPassword())){
                return new ResponseEntity<>("Nhập mật khẩu cũ không đúng!!!", HttpStatus.BAD_REQUEST);
            }

            account.setPassword(newPassword);
            accountService.addOrUpdateAccount(account);

            return new ResponseEntity<>("Đã thay đổi mật khẩu mới!!", HttpStatus.OK);

        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi thay đổi mật khẩu mới!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
