package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Customer;
import com.example.webthoitrang.entity.Order;
import com.example.webthoitrang.entity.OrderDetail;
import com.example.webthoitrang.repository.OrderDetailRepository;
import com.example.webthoitrang.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Order> getAllOrder() {return orderRepository.findAll();}

    public Order getOrderById(int orderId) {return orderRepository.findById(orderId).orElse(null);}

    public Order addOrUpdateOrder(Order order) {return orderRepository.save(order);}

    public List<Order> getAllOrderByStatus(int status){return orderRepository.findByStatusOrderByCreateDateDesc(status);}

    public OrderDetail addOrUpdateOrderDetail(OrderDetail orderDetail) {return orderDetailRepository.save(orderDetail);}

    public List<Order> getOrderPendingByCustomer(Customer customer){return orderRepository.findByStatusAndCustomer(1,customer);}

    public List<Order> getOrderApprovedByCustomer(Customer customer){return orderRepository.findByStatusAndCustomer(2,customer);}

    public List<Order> getOrderDeliveredByCustomer(Customer customer){return orderRepository.findByStatusAndCustomer(3,customer);}

    public List<Order> getOrderCancelledByCustomer(Customer customer){return orderRepository.findByStatusAndCustomer(0,customer);}

    public List<Order> getOrdersByCustomer(Customer customer){return orderRepository.findByCustomer(customer);}



}
