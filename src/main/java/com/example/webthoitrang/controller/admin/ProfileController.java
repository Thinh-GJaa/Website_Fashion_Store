package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.entity.Staff;
import com.example.webthoitrang.helper.FirebaseHelper;
import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.ImageService;
import com.example.webthoitrang.services.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin/profile") // Định nghĩa đường dẫn chung
public class ProfileController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private StaffService staffService;

    @Autowired
    private ImageService imageService;

    @GetMapping
    public ModelAndView profile(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("admin/profile");
        String email = JwtUtil.getEmailFromCookie(request);
        Account account = accountService.getAccountByEmail(email);
        Staff staff = account.getStaff();
        modelAndView.addObject("staff", staff);
        return modelAndView;
    }

    @PutMapping
    public ResponseEntity<String> editProfile(@ModelAttribute("staff") Staff staff,
                                              @RequestParam("imageInput") MultipartFile imageInput) {
        try{
            System.out.println("thinh-staffId:" + staff.getStaffId());
            System.out.println("thinh:" + staff.getAccount().getEmail());
            System.out.println("thinh:" + staff.getAddress());

            if(!imageInput.isEmpty()){
                String linkImage = FirebaseHelper.uploadImageStaff(staff.getStaffId(), imageInput);
                Image image = staff.getImage();
                image.setLinkImage(linkImage);
                imageService.addOrUpdateImage(image);
            }

            staffService.addOrUpdateStaff(staff);

            Account account = accountService.getAccountById(staff.getAccount().getAccountId());
            account.setEmail(staff.getAccount().getEmail());
            account.setPhoneNumber(staff.getAccount().getPhoneNumber());
            accountService.addOrUpdateAccount(account);

            return new ResponseEntity<>("Đã cập nhật thông tin cá  nhân", HttpStatus.OK);
        }
        catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi cập nhật thông tin cá nhân!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
