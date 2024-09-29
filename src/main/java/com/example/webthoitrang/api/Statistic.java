//package com.example.webthoitrang.api;
//
//import com.example.webthoitrang.dto.StatisticDTO;
//import com.example.webthoitrang.services.StatisticService;
//import com.fasterxml.jackson.core.JsonProcessingException;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//import java.time.LocalDate;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//import java.util.List;
//
//@RestController
//@RequestMapping("/admin/statistic")
//public class Statistic {
//
//    @Autowired
//    private StatisticService statisticService;
//
//    @GetMapping("/order/date")
//    public List<StatisticDTO> orderDate(@RequestParam("startDate") String startDateStr,
//                            @RequestParam("endDate") String endDateStr) throws JsonProcessingException {
//        try {
//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//            LocalDate startDate = LocalDate.parse(startDateStr, formatter);
//            LocalDate endDate = LocalDate.parse(endDateStr, formatter);
//
//            LocalDateTime startDateTime = startDate.atStartOfDay();
//            LocalDateTime endDateTime = endDate.atTime(23, 59, 59);
//
////            if (startDateTime.isAfter(endDateTime)) {
////                return new ResponseEntity<>("Ngày bắt đầu phải bé hơn ngày kết thúc", HttpStatus.BAD_REQUEST);
////            }
//
//            List<StatisticDTO> statisticDTOS = statisticService.getStatisticOrderByDate(startDateTime, endDateTime);
//
//            return statisticDTOS;
////            ObjectMapper objectMapper = new ObjectMapper();
////            String statisticOrderJson = objectMapper.writeValueAsString(statisticDTOS);
//
////            System.out.println("thinh: " + statisticOrderJson);
//
////            return new ResponseEntity<>(statisticOrderJson, HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
////            return new ResponseEntity<>("Đã xảy ra lỗi thống kê hóa đơn theo ngày!!!",HttpStatus.INTERNAL_SERVER_ERROR);
//            return null;
//        }
//    }
//}
