package com.example.webthoitrang.controller.user;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.dto.ProductCartDto;
import com.example.webthoitrang.entity.*;
import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.OrderService;
import com.example.webthoitrang.services.ProductService;
import com.example.webthoitrang.services.SizeDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/user")
public class CheckoutController {

    @Autowired
    private SizeDetailService sizeDetailService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private AccountService accountService;
    @Autowired
    private ProductService productService;

    @PostMapping("/checkout")
    public ModelAndView checkout(
            @RequestParam("selectedProductIds") String productIds,
            @RequestParam("selectedSizeIds") String sizeIds,
            @RequestParam("selectedQuantities") String quantities,
            @RequestParam("selectedPrices") String prices,
            @RequestParam("selectedDiscountPrices") String discountPrices,
            HttpSession session
    ) {
        List<ProductCartDto> productList = new ArrayList<>();
        float totalAmount = 0;
        float totalDiscountAmount = 0;

        // Phân tách các giá trị từ các tham số
        String[] productIdsArray = productIds.split(",");
        String[] sizeIdsArray = sizeIds.split(",");
        String[] quantitiesArray = quantities.split(",");
        String[] pricesArray = prices.split(",");
        String[] discountPricesArray = discountPrices.split(",");

//        for (String gia : discountPricesArray) {System.out.println("thinh: km " + gia);}


        // Xử lý dữ liệu giỏ hàng ở đây
        for (int i = 0; i < productIdsArray.length; i++) {
            int productId = Integer.parseInt(productIdsArray[i]);;
            int sizeId = Integer.parseInt(sizeIdsArray[i]);;
            int quantity = Integer.parseInt(quantitiesArray[i]);
            float price = Float.parseFloat(pricesArray[i]);
            float discount = Float.parseFloat(discountPricesArray[i]);

            System.out.println("thinh:" + productId + " " + sizeId + " " + quantity + " " + price);

            SizeDetailId sizeDetailId = new SizeDetailId(sizeId, productId);
            SizeDetail sizeDetail = sizeDetailService.getSizeDetailById(sizeDetailId);

            ProductCartDto productCartDto = new ProductCartDto();
            productCartDto.setSizeDetail(sizeDetail);
            productCartDto.setQuantity(quantity);
            productCartDto.setPrice(price);
            productCartDto.setPriceDiscount(discount);

            productList.add(productCartDto);

            totalDiscountAmount += discount* quantity;

            totalAmount += price * quantity;

        }


        // Chuyển hướng hoặc trả về view phù hợp
        ModelAndView mav = new ModelAndView("user/checkout");
        mav.addObject("productList", productList);
        // Lưu danh sách vào session
        session.setAttribute("productCartList", productList);
        System.out.println("thinh: " + productList);
        mav.addObject("totalDiscountAmount", totalDiscountAmount);
        mav.addObject("totalAmount", totalAmount);

        return mav;
    }

    @PostMapping("/paying")
    public ResponseEntity<String> paying(@ModelAttribute Order order, HttpSession session,HttpServletRequest request) {
        try{
            List<ProductCartDto> productList = (List<ProductCartDto>) session.getAttribute("productCartList");

            System.out.println("thinh: " + productList);
            System.out.println("thinh: " + order.getRecipientName());
            System.out.println("thinh: " + order.getAddress());
            System.out.println("thinh: " + order.getPhoneNumber());
            System.out.println("thinh: " + order.getTotalAmount());
            System.out.println("thinh: " + order.getTotalDiscountAmount());

            //Kiểm tra xem tồn kho đủ không
            for (ProductCartDto productCartDto: productList){
                SizeDetail sizeDetail = sizeDetailService.getSizeDetailById(new SizeDetailId(productCartDto.getSizeDetail().getSizeDetailId().getSizeId(),productCartDto.getSizeDetail().getSizeDetailId().getProductId()));

                if(sizeDetail.getQuantity() < productCartDto.getQuantity()){
                    return new ResponseEntity<>("Sản phẩm: " + sizeDetail.getProduct().getProductName()
                            +"\nSize: " + sizeDetail.getSize().getSizeName()
                            +"\nChỉ còn lại "+ sizeDetail.getQuantity()+ " sản phẩm"
                            ,HttpStatus.BAD_REQUEST);
                }
            }

            LocalDateTime createDate = LocalDateTime.now();
            System.out.println("thinh: " + createDate);

            String email = JwtUtil.getEmailFromCookie(request);

            Customer customer = accountService.getAccountByEmail(email).getCustomer();

            order.setCustomer(customer);
            order.setCreateDate(createDate);
            order.setStatus(1);  //Trạng thái chờ duyệt

            order = orderService.addOrUpdateOrder(order);

            Set<OrderDetail> orderDetails = new HashSet<>();

            for (ProductCartDto productCartDto: productList){

                System.out.println("thinh dto: " + productCartDto.toString());

                SizeDetail sizeDetail = sizeDetailService.getSizeDetailById(new SizeDetailId(productCartDto.getSizeDetail().getSizeDetailId().getSizeId(),productCartDto.getSizeDetail().getSizeDetailId().getProductId()));

                sizeDetail.setQuantity(sizeDetail.getQuantity() - productCartDto.getQuantity());
                sizeDetailService.addOrUpdateSizeDetail(sizeDetail);

                OrderDetailId orderDetailId = new OrderDetailId();
                orderDetailId.setOrderId(order.getOrderId());
                orderDetailId.setProductId(productCartDto.getSizeDetail().getProduct().getProductId());
                orderDetailId.setSizeId(productCartDto.getSizeDetail().getSize().getSizeId());

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderDetailId(orderDetailId);
                orderDetail.setQuantity(productCartDto.getQuantity());
                orderDetail.setPrice(productCartDto.getPriceDiscount());

//                orderService.addOrUpdateOrderDetail(orderDetail);

                orderDetails.add(orderDetail);

            }
            order.setOrderDetails(orderDetails);
            order = orderService.addOrUpdateOrder(order);

            return ResponseEntity.ok("Cảm ơn bạn đã mua hàng shop <3");
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi trong quá trình mua hàng!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

}
