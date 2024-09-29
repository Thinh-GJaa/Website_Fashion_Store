package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.dto.EditBrandDto;
import com.example.webthoitrang.entity.Brand;
import com.example.webthoitrang.entity.Order;
import com.example.webthoitrang.services.BrandService;
import com.example.webthoitrang.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/order") // Định nghĩa đường dẫn chung
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/{status}")
    public ModelAndView orderHome(@PathVariable String status) {


        ModelAndView mav = new ModelAndView("admin/order");

        switch (status) {
            case "pending":
                mav.addObject("orderList", orderService.getAllOrderByStatus(1));
                mav.addObject("status", "pending");
                return mav;
            case "approved":
                mav.addObject("orderList", orderService.getAllOrderByStatus(2));
                mav.addObject("status", "approved");
                return mav;
            case "delivered":
                mav.addObject("orderList", orderService.getAllOrderByStatus(3));
                mav.addObject("status", "delivered");
                return mav;
            case "cancelled":
                mav.addObject("orderList", orderService.getAllOrderByStatus(0));
                mav.addObject("status", "cancelled");
                return mav;
            default:
                throw new IllegalStateException("Unexpected value: " + status);
        }

    }

    @PostMapping("/approve/{orderId}")
    public ResponseEntity<String> approveOrder(@PathVariable int orderId) {
        try{
            Order order = orderService.getOrderById(orderId);
            order.setStatus(2);
            orderService.addOrUpdateOrder(order);
            return new ResponseEntity<>("Cập nhật thành công", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Cập nhật thất bại !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PostMapping("/deliver/{orderId}")
    public ResponseEntity<String> deliverOrder(@PathVariable int orderId) {
        try{
            Order order = orderService.getOrderById(orderId);
            order.setStatus(3);
            orderService.addOrUpdateOrder(order);
            return new ResponseEntity<>("Cập nhật thành công", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Cập nhật thất bại !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PostMapping("/cancel/{orderId}")
    public ResponseEntity<String> cancelOrder(@PathVariable int orderId,
                                              @RequestParam("reason") String reason) {
        try{
            System.out.println("thinh reason: " + reason);
            Order order = orderService.getOrderById(orderId);
            order.setStatus(0);
            order.setReason(reason);
            orderService.addOrUpdateOrder(order);
            return new ResponseEntity<>("Cập nhật thành công", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Cập nhật thất bại !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

}
