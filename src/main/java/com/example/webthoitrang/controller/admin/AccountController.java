package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.entity.*;
import com.example.webthoitrang.helper.FirebaseHelper;
import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.CustomerService;
import com.example.webthoitrang.services.ImageService;
import com.example.webthoitrang.services.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/account") // Định nghĩa đường dẫn chung
public class AccountController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private StaffService staffService;

    @Autowired
    private ImageService imageService;

    @GetMapping("/customer")
    public ModelAndView customerHome() {

        ModelAndView mav = new ModelAndView("admin/customer");
        mav.addObject("customerList", customerService.getAllCustomer());
        return mav;
    }

    @GetMapping("/staff")
    public ModelAndView staffHome() {

        ModelAndView mav = new ModelAndView("admin/staff");
        mav.addObject("staffList", staffService.getAllStaff());
        mav.addObject("staffEdit", new Staff());
        mav.addObject("staffNew", new Staff());
        return mav;
    }


    @PutMapping("/block/{email}")
    public ResponseEntity<String> blockAccount(@PathVariable("email") String email) {
        try{
            Account account = accountService.getAccountByEmail(email);
            // Kiểm tra id khách hàng tồn tại ko
            if (account == null) {
                return new ResponseEntity<>("Không tìm thấy Tài khoản này trong CSDL !!!",HttpStatus.NOT_FOUND);
            }

            // Kiểm tra trạng thái khách hàng
            if(!account.getStatus()){
                return new ResponseEntity<>("Lỗi khi khóa tài khoản !!!\nVui lòng tải lại trang!!!",HttpStatus.CONFLICT);
            }

            account.setStatus(false);
            accountService.addOrUpdateAccount(account);
            return new ResponseEntity<>("Khóa tài khoản  thành công",HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Khóa tài khoản thất bại!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/unblock/{email}")
    public ResponseEntity<String> unblockAccount(@PathVariable("email") String email) {
        try{
            Account account = accountService.getAccountByEmail(email);
            // Kiểm tra id khách hàng tồn tại ko
            if (account == null) {
                return new ResponseEntity<>("Không tìm thấy Tài khoản trong CSDL !!!",HttpStatus.NOT_FOUND);
            }

            // Kiểm tra trạng thái khách hàng
            if(account.getStatus()){
                return new ResponseEntity<>("Lỗi khi mở khóa tài khoản !!!\nVui lòng tải lại trang!!!",HttpStatus.CONFLICT);
            }

            account.setStatus(true);
            accountService.addOrUpdateAccount(account);
            return new ResponseEntity<>("Mở khóa tài khoản thành công",HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Mở khóa tài khoản thất bại!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/staff")
    public ResponseEntity<String> staffEdit(@ModelAttribute("staffEdit") Staff staff,
                                            @RequestParam("imageStaffEdit") MultipartFile imageStaff) {
        try{
            System.out.println("thinh: "+ staff.getAccount().getEmail());

            Account account = accountService.getAccountById(staff.getAccount().getAccountId());

            //Kiểm tra email đã tồn tại chưa
            if(accountService.getAccountByEmail(staff.getAccount().getEmail()) != null
                && accountService.getAccountByEmail(staff.getAccount().getEmail()).getAccountId() != account.getAccountId()){
                return new ResponseEntity<>("Email này đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            //Kiểm tra số điện thoại đã tồn tại chưa
            if(accountService.getAccountByPhoneNumber(staff.getAccount().getPhoneNumber()) != null
                && accountService.getAccountByPhoneNumber(staff.getAccount().getPhoneNumber()).getAccountId() != account.getAccountId()){
                return new ResponseEntity<>("Số điện thoại này đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            account.setEmail(staff.getAccount().getEmail());
            account.setPhoneNumber(staff.getAccount().getPhoneNumber());

            accountService.addOrUpdateAccount(account);

            Image image = staff.getImage();

            if(image != null){
                image.setLinkImage(FirebaseHelper.uploadImageStaff(staff.getStaffId(), imageStaff));
                imageService.addOrUpdateImage(image);
            }else{
                image = new Image();
                image.setLinkImage(FirebaseHelper.uploadImageStaff(staff.getStaffId(), imageStaff));
                imageService.addOrUpdateImage(image);
                staff.setImage(image);
            }

            staffService.addOrUpdateStaff(staff);
            return new ResponseEntity<>("Chỉnh sửa thông tin Nhân viên thành công.", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi chỉnh sửa thông tin Nhân viên !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/staff")
    public ResponseEntity<String> staffAdd(@ModelAttribute("staffNew") Staff staff,
                                           @RequestParam("imageStaff") MultipartFile imageStaff) {
        try{
            System.out.println("thinh: "+ staff.getAccount().getEmail());

            //Kiểm tra email đã tồn tại chưa
            if(accountService.getAccountByEmail(staff.getAccount().getEmail()) != null){
                return new ResponseEntity<>("Email này đã tồn tại!!!", HttpStatus.CONFLICT);
            }


            //Kiểm tra số điện thoại đã tồn tại chưa
            if(accountService.getAccountByPhoneNumber(staff.getAccount().getPhoneNumber()) != null){
                return new ResponseEntity<>("Số điện thoại này đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            Account account = new Account();
            //Set role =2, tức là quyền staff
            account.setRole(new Role(2));
            account.setEmail(staff.getAccount().getEmail());
            account.setPhoneNumber(staff.getAccount().getPhoneNumber());
            account.setStatus(true);
            //Mật khẩu mặc định là 123456
            account.setPassword("123456");
            accountService.addOrUpdateAccount(account);
            staff.setAccount(account);

            staff = staffService.addOrUpdateStaff(staff);

            //Upload ảnh
            Image image = new Image();

            try{
                image.setLinkImage(FirebaseHelper.uploadImageStaff(staff.getStaffId(), imageStaff));
            }
            catch (Exception e){
                e.printStackTrace();
            }
            image = imageService.addOrUpdateImage(image);

            staff.setImage(image);
            staffService.addOrUpdateStaff(staff);

            return new ResponseEntity<>("Thêm Nhân viên mới thành công.", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi thêm Nhân viên mới!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
