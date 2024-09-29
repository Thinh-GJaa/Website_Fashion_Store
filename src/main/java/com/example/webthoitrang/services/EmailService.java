package com.example.webthoitrang.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender emailSender;

    public void sendEmail(String recipient, String subject, String text) throws MessagingException, UnsupportedEncodingException {
        try {
            // Tạo MimeMessage
            MimeMessage message = emailSender.createMimeMessage();

            // Sử dụng MimeMessageHelper để thiết lập thông tin email
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom("xthinh04052002@gmail.com", "GJaa Fashion Shop"); // Đặt tên người gửi và địa chỉ email
            helper.setTo(recipient);
            helper.setSubject(subject);
            helper.setText(text, true); // true để gửi nội dung văn bản html

            // Gửi email
            emailSender.send(message);

        }catch (MessagingException e){
            e.printStackTrace();

        }
    }

    public void sendEmailOrder(String recipient, String subject, String text) throws MessagingException, UnsupportedEncodingException {
        try {
            // Tạo MimeMessage
            MimeMessage message = emailSender.createMimeMessage();

            // Sử dụng MimeMessageHelper để thiết lập thông tin email
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom("xthinh04052002@gmail.com", "GJaa Fashion Shop"); // Đặt tên người gửi và địa chỉ email
            helper.setTo(recipient);
            helper.setSubject(subject);
            helper.setText(text, true); // true để gửi nội dung văn bản html

            // Gửi email
            emailSender.send(message);

        }catch (MessagingException e){
            e.printStackTrace();

        }
    }


}
