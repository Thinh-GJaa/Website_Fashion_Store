package com.example.webthoitrang.controller.user;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.Customer;
import com.example.webthoitrang.entity.Order;
import com.example.webthoitrang.entity.OrderDetail;
import com.example.webthoitrang.entity.OrderDetailId;
import com.example.webthoitrang.services.AccountService;
import com.example.webthoitrang.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("userOrder")
@RequestMapping("/user/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private AccountService accountService;

    @GetMapping
    public String order(Model model, HttpServletRequest request) {
        String email = JwtUtil.getEmailFromCookie(request);
        Customer customer = accountService.getAccountByEmail(email).getCustomer();

        List<Order> pendingOrders = orderService.getOrderPendingByCustomer(customer);
        List<Order> approvedOrders = orderService.getOrderApprovedByCustomer(customer);
        List<Order> deliveredOrders = orderService.getOrderDeliveredByCustomer(customer);
        List<Order> cancelledOrders = orderService.getOrderCancelledByCustomer(customer);

        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("approvedOrders", approvedOrders);
        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("cancelledOrders", cancelledOrders);

        return "user/order";
    }

    @PostMapping("/rate")
    public ResponseEntity<String> rate(@RequestParam("orderId") int orderId, @RequestParam("productId") int productId,
                                       @RequestParam("rating") int rating, @RequestParam("sizeId") int sizeId,
                                       HttpServletRequest request){
        try{
            String email = JwtUtil.getEmailFromCookie(request);
            Customer customer = accountService.getAccountByEmail(email).getCustomer();

            System.out.println("thinh: " + orderId);
            System.out.println("thinh: " + productId);
            System.out.println("thinh: " + sizeId);
            System.out.println("thinh: " + rating);

            OrderDetailId orderDetailId = new OrderDetailId(productId,orderId,sizeId);
            OrderDetail orderDetail = new OrderDetail(orderDetailId);
            orderDetail.setRatingScore(rating);
            orderService.addOrUpdateOrderDetail(orderDetail);
            return new ResponseEntity<>("Sản phẩm đã được đánh giá", HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>("Đã xảy ra lỗi", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @PostMapping("/cancel")
    public ResponseEntity<String> cancelOrder(@RequestParam("orderId") int orderId,
                                              @RequestParam("reason") String reason){
        try{
            System.out.println("thinh reason: " + reason);
            Order order = orderService.getOrderById(orderId);
            order.setStatus(0);
            order.setReason(reason);
            orderService.addOrUpdateOrder(order);
            return new ResponseEntity<>("Hủy đon hàng thành công", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi khi hủy đơn hàng!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
