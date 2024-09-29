package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.entity.Customer;
import com.example.webthoitrang.repository.AccountRepository;
import com.example.webthoitrang.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public Customer getCustomerById(int customerId) {return customerRepository.getById(customerId);}

    public List<Customer> getAllCustomer() {return customerRepository.findAll();}

    public Customer addOrUpdateCustomer(Customer customer) {return customerRepository.save(customer);}
}
