package com.example.webthoitrang.controller.admin;


import com.example.webthoitrang.dto.StatisticDTO;
import com.example.webthoitrang.dto.StatisticProductDTO;
import com.example.webthoitrang.services.EmailService;
import com.example.webthoitrang.services.ProductService;
import com.example.webthoitrang.services.StatisticService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/statistic")
public class StatisticController {

    @Autowired
    private StatisticService statisticService;

    @Autowired
    private ProductService productService;

    @Autowired
    private EmailService emailService;


    @GetMapping("/account")
    public ModelAndView account() throws JsonProcessingException, ParseException {
        ModelAndView modelAndView = new ModelAndView("admin/statistic-account");

        //Lấy thông tin thông kê
        List<StatisticDTO> statisticGenderCustomer = statisticService.statisticGenderCustomer();
        List<StatisticDTO> statisticAgeCustomer = statisticService.statisticAgeCustomer();

        // Đặt khoảng thời gian mặc định là 30 ngày gần nhất
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        Date endDate = calendar.getTime();
        calendar.add(Calendar.DAY_OF_MONTH, -30);
        Date startDate = calendar.getTime();

        //Chuyển đổi list thành Json
        ObjectMapper objectMapper = new ObjectMapper();
        String statisticGenderCustomerJson = objectMapper.writeValueAsString(statisticGenderCustomer);
        String statisticAgeCustomerJson = objectMapper.writeValueAsString(statisticAgeCustomer);
        String statisticCreateDateCustomerJson = objectMapper.writeValueAsString(statisticService.statisticCreateDateCustomer(startDate, endDate));

        //Thêm vào model
        modelAndView.addObject("numberCustomer", statisticService.countCustomer());
        modelAndView.addObject("numberStatusBlockCustomer", statisticService.countCustomerByStatus(false));
        modelAndView.addObject("numberStatusActivityCustomer", statisticService.countCustomerByStatus(true));

        //Thêm vào model
        modelAndView.addObject("numberStaff", statisticService.countStaff());
        modelAndView.addObject("numberStatusBlockStaff", statisticService.countStaffByStatus(false));
        modelAndView.addObject("numberStatusActivityStaff", statisticService.countStaffByStatus(true));


        modelAndView.addObject("statisticGenderCustomerJson", statisticGenderCustomerJson);
        modelAndView.addObject("statisticAgeCustomerJson", statisticAgeCustomerJson);
        modelAndView.addObject("statisticCreateDateCustomerJson", statisticCreateDateCustomerJson);


        return modelAndView;
    }

    @GetMapping("/product")
    public ModelAndView product() throws JsonProcessingException, ParseException {
        ModelAndView modelAndView = new ModelAndView("admin/statistic-product");

        modelAndView.addObject("productList", productService.getAllProduct());
        modelAndView.addObject("topSellingProduct", statisticService.getTopSellingProducts(0, 5));
        System.out.println("thinh: " +  statisticService.getTopSellingProducts(0, 5));


        return modelAndView;
    }

    @GetMapping("/top-product/date")
    public ResponseEntity<String> productDateTop(@RequestParam("startDate") String startDateStr,
                                              @RequestParam("endDate") String endDateStr) throws JsonProcessingException {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(startDateStr, formatter);
            LocalDate endDate = LocalDate.parse(endDateStr, formatter);

            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

            if(startDateTime.isAfter(endDateTime)) {
                return new ResponseEntity<>("Ngày bắt đầu phải bé hơn ngày kết thúc", HttpStatus.BAD_REQUEST);
            }
            List<StatisticProductDTO> statisticProductDTOS = statisticService.getTopSellingProductsByDate(startDateTime, endDateTime);

            ObjectMapper objectMapper = new ObjectMapper();
            String statisticProductJson = objectMapper.writeValueAsString(statisticProductDTOS);

            System.out.println("thinh: " +statisticProductJson);

            return new ResponseEntity<>(statisticProductJson, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/product/date")
    public ResponseEntity<String> productDate(@RequestParam("productId") int productId,
                                                @RequestParam("startDate") String startDateStr,
                                              @RequestParam("endDate") String endDateStr) throws JsonProcessingException {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(startDateStr, formatter);
            LocalDate endDate = LocalDate.parse(endDateStr, formatter);

            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

            if(startDateTime.isAfter(endDateTime)) {
                return new ResponseEntity<>("Ngày bắt đầu phải bé hơn ngày kết thúc", HttpStatus.BAD_REQUEST);
            }

            List<StatisticDTO> statisticDTOS = statisticService.getStatisticProductByDate(productId,startDateTime, endDateTime);

            ObjectMapper objectMapper = new ObjectMapper();
            String statisticProductJson = objectMapper.writeValueAsString(statisticDTOS);

            System.out.println("thinh: " +statisticProductJson);

            return new ResponseEntity<>(statisticProductJson, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi thống kê sản phẩm theo ngày",HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/order")
    public ModelAndView order() throws JsonProcessingException {
        ModelAndView modelAndView = new ModelAndView("admin/statistic-order");

        // Lấy thời gian hiện tại
        LocalDateTime endDateTime = LocalDateTime.now();

        // Lấy thời gian 30 ngày trước
        LocalDateTime startDateTime = endDateTime.minus(30, ChronoUnit.DAYS);

        System.out.println("thinh: " +statisticService.getStatisticOrderByDate(startDateTime, endDateTime));

        ObjectMapper objectMapper = new ObjectMapper();
        String statisticOrderByDateJson = objectMapper.writeValueAsString(statisticService.getStatisticOrderByDate(startDateTime, endDateTime));

        modelAndView.addObject("statisticOrderByDateJson", statisticOrderByDateJson);

        return modelAndView;
    }

    @GetMapping("/order/date")
    public ResponseEntity<String> orderDate(@RequestParam("startDate") String startDateStr,
                                            @RequestParam("endDate") String endDateStr) throws JsonProcessingException {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(startDateStr, formatter);
            LocalDate endDate = LocalDate.parse(endDateStr, formatter);

            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

            if (startDateTime.isAfter(endDateTime)) {
                return new ResponseEntity<>("Ngày bắt đầu phải bé hơn ngày kết thúc", HttpStatus.BAD_REQUEST);
            }

            List<StatisticDTO> statisticDTOS = statisticService.getStatisticOrderByDate(startDateTime, endDateTime);

            ObjectMapper objectMapper = new ObjectMapper();
            String statisticOrderJson = objectMapper.writeValueAsString(statisticDTOS);

            System.out.println("thinh: " + statisticOrderJson);

            return new ResponseEntity<>(statisticOrderJson, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi thống kê hóa đơn theo ngày!!!",HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/sales/date")
    public ResponseEntity<String> salesDate(@RequestParam("startDate") String startDateStr,
                                            @RequestParam("endDate") String endDateStr) throws JsonProcessingException {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(startDateStr, formatter);
            LocalDate endDate = LocalDate.parse(endDateStr, formatter);

            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

            if (startDateTime.isAfter(endDateTime)) {
                return new ResponseEntity<>("Ngày bắt đầu phải bé hơn ngày kết thúc", HttpStatus.BAD_REQUEST);
            }

            List<StatisticDTO> statisticDTOS = statisticService.getStatisticSalesByDate(startDateTime, endDateTime);

            ObjectMapper objectMapper = new ObjectMapper();
            String statisticSaleDateJson = objectMapper.writeValueAsString(statisticDTOS);

            System.out.println("thinh: " + statisticSaleDateJson);

            return new ResponseEntity<>(statisticSaleDateJson, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi thống kê doanh thu theo ngày!!!",HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/sales/month")
    public ResponseEntity<String> salesMonth() throws JsonProcessingException {
        try {

            List<StatisticDTO> statisticDTOS = statisticService.getStatisticSalesByMonth();

            ObjectMapper objectMapper = new ObjectMapper();
            String statisticSalesMonthJson = objectMapper.writeValueAsString(statisticDTOS);

            System.out.println("thinh: " + statisticSalesMonthJson);

            return new ResponseEntity<>(statisticSalesMonthJson, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi thống kê doanh thu theo tháng!!!",HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/sales/year")
    public ResponseEntity<String> salesYear() throws JsonProcessingException {
        try {

            List<StatisticDTO> statisticDTOS = statisticService.getStatisticSalesByYear();

            ObjectMapper objectMapper = new ObjectMapper();
            String statisticSalesYearJson = objectMapper.writeValueAsString(statisticDTOS);

            System.out.println("thinh: " + statisticSalesYearJson);


            return new ResponseEntity<>(statisticSalesYearJson, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi thống kê doanh thu theo năm!!!",HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }





}
