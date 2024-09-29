package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Account;
import com.example.webthoitrang.repository.AccountRepository;
import org.springframework.stereotype.Service;

@Service
public class AccountService {

    private final AccountRepository accountRepository;

    public AccountService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    public Account getAccountById(int accountId) {
        return accountRepository.findById(accountId).orElse(null);
    }


    public Account getAccountByEmail(String email) {
        return accountRepository.findByEmail(email);
    }

    public Account getAccountByPhoneNumber(String phoneNumber) {
        return accountRepository.findByPhoneNumber(phoneNumber);
    }


    public void addOrUpdateAccount(Account account) {
        accountRepository.save(account);
    }


    public Account authenticateAdmin(String username, String password) {
        //Lấy account theo gmail
        Account account = accountRepository.findByEmail(username);

        // Kiểm tra gmail có tồn tại không và mật khẩu có trùng ko
        if (account != null && account.getPassword().equals(password)) {
            if (account.getRole().getRoleName().equals("Admin") || account.getRole().getRoleName().equals("Staff")) {
                return account;
            }

        }

        // Nếu ko tìm ra gmail thì tìm theo SĐT
        account = accountRepository.findByPhoneNumber(username);
        if (account != null && account.getPassword().equals(password)) {
            if (account.getRole().getRoleName().equals("Admin") || account.getRole().equals("Staff")) {
                return account;
            }
        }

        return null;
    }


    public Account authenticateCustomer(String username, String password) {
        //Lấy account theo gmail
        Account account = accountRepository.findByEmail(username);

        // Kiểm tra gmail có tồn tại không và mật khẩu có trùng ko
        if (account != null && account.getPassword().equals(password)) {
            System.out.println("thinh: " + "email: " + account.getEmail());
            if (account.getRole().getRoleName().equals("Customer")) {
                return account;
            }

        }

        // Nếu ko tìm ra gmail thì tìm theo SĐT
        account = accountRepository.findByPhoneNumber(username);
        if (account != null && account.getPassword().equals(password)) {
            if (account.getRole().getRoleName().equals("Customer")) {
                return account;
            }

        }
        System.out.println("thinh: " + "account null");
        return null;
    }
}
