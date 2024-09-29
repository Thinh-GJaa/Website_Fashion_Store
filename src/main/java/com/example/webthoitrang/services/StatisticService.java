package com.example.webthoitrang.services;

import com.example.webthoitrang.dto.StatisticDTO;
import com.example.webthoitrang.dto.StatisticProductDTO;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.entity.Product;
import com.example.webthoitrang.repository.*;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import org.springframework.data.domain.Pageable;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


@Service
public class StatisticService {

    private final AccountRepository accountRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CustomerRepository customerRepository;
    private final StaffRepository staffRepository;
    private final ProductService productService;


    public StatisticService(AccountRepository accountRepository, ProductRepository productRepository, OrderRepository orderRepository, OrderDetailRepository orderDetailRepository, CustomerRepository customerRepository, StaffRepository staffRepository, ProductService productService) {
        this.accountRepository = accountRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.customerRepository = customerRepository;
        this.staffRepository = staffRepository;
        this.productService = productService;
    }

    //Đếm số khách hàng
    public long countCustomer(){return customerRepository.count();}

    //Đếm số nhân viên
    public long countStaff(){return staffRepository.count();}

    //Đếm số đơn hng
    public long countOrder(){return orderRepository.count();}

    //Đếm số khách hàng theo giới tính
    public int countCustomerByGender(int gender){return customerRepository.countByGender(gender);}

    //Đếm số khách hàng theo trạng thái ( khóa, hoạt động)
    public int countCustomerByStatus(boolean status){return customerRepository.countByAccountStatus(status);}

    //Đếm số nhân viên theo trạng thái ( khóa, hoạt động)
    public int countStaffByStatus(boolean status){return staffRepository.countByAccountStatus(status);}

    //Thống kê theo giới tính
    public List<StatisticDTO>  statisticGenderCustomer(){
        List<StatisticDTO> statisticGenderCustomer = new ArrayList<>();
        double countCustomerDouble = (double) countCustomer();
        statisticGenderCustomer.add(new StatisticDTO("Nữ", countCustomerByGender(0) / countCustomerDouble * 100));
        statisticGenderCustomer.add(new StatisticDTO("Nam", countCustomerByGender(1) / countCustomerDouble * 100));
        statisticGenderCustomer.add(new StatisticDTO("Khác", countCustomerByGender(2) / countCustomerDouble * 100));

        return statisticGenderCustomer;
    }


    //Thông kê độ tuổi khách hàng: Dưới 18, 18-25, 26-35, 36-45. 46-55
    public List<StatisticDTO>  statisticAgeCustomer(){
        List<Object[]> results = customerRepository.findAgeStatistics();
        List<StatisticDTO> statistics = new ArrayList<>();
        double countCustomerDouble = (double) countCustomer();
        for (Object[] result : results) {
            String label = (String) result[0];
            long count = (long) result[1];
            statistics.add(new StatisticDTO(label, (double) count/countCustomerDouble * 100));
        }

        return statistics;
    }


    //Thống kê tài khoản mới tạo trong một khoảng thời gian
    public List<StatisticDTO> statisticCreateDateCustomer(Date startDate, Date endDate) {
        List<Object[]> results = accountRepository.findAccountStatisticsByDay(startDate, endDate);
        List<StatisticDTO> statistics = new ArrayList<>();

        for (Object[] result : results) {
            String label = (String) result[0];  // Ngày dưới dạng chuỗi
            long value = ((BigInteger) result[1]).longValue();  // Số lượng dưới dạng long
            statistics.add(new StatisticDTO(label, (double) value));  // Chuyển đổi long sang double nếu cần
        }

        return statistics;
    }

    //Thống kê sản phẩm bán được nhiều nhất
    public List<StatisticProductDTO> getTopSellingProducts(int page, int size) {
        Pageable pageable = (Pageable) PageRequest.of(page, size); // Tạo đối tượng Pageable
        List<Object[]> results = orderDetailRepository.findTopSellingProducts(pageable); // Gọi phương thức repository
        return getStatisticProductDTOS(results);
    }

    //Thống kê sản phẩm bán được nhiều nhất theo khoảng thời gian
    public List<StatisticProductDTO> getTopSellingProductsByDate(LocalDateTime startDate, LocalDateTime endDate) {
        Pageable pageable = (Pageable) PageRequest.of(0, 5); // Tạo đối tượng Pageable
        List<Object[]> results = orderDetailRepository.findTopSellingProducts(startDate, endDate , pageable); // Gọi phương thức repository
        return getStatisticProductDTOS(results);
    }

    //Thống kê sản phẩm bán được nhiều nhất theo khoảng thời gian top4
    public List<Product> getTop8SellingProductsByDate(LocalDateTime startDate, LocalDateTime endDate) {
        Pageable pageable = (Pageable) PageRequest.of(0, 8); // Tạo đối tượng Pageable
        List<Object[]> results = orderDetailRepository.findTopSellingProducts(startDate, endDate , pageable); // Gọi phương thức repository
        List<Product> products = new ArrayList<>();

        for (Object[] result : results) {
            int productId = (int) result[0];
            Product product = productRepository.findById(productId).orElse(null);

            if(product.getStatus() == 1){
                if(productService.getPriceProduct(product) != -1){
                    products.add(product);
                }

            }

        }

        return products;
    }

    //Thống kê sp theo ngày
    public List<StatisticDTO> getStatisticProductByDate(int productId, LocalDateTime startDate, LocalDateTime endDate) {
        List<Object[]> results = orderDetailRepository.findSalesProductByDay(productId, startDate, endDate);
        List<StatisticDTO> statistics = new ArrayList<>();

        for (Object[] result : results) {

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateTime = (LocalDateTime) result[0];
            String label = dateTime.format(formatter);;  // Ngày dưới dạng chuỗi
            long value = (long) result[1] ; // Số lượng dưới dạng long
            statistics.add(new StatisticDTO(label, (double) value));  // Chuyển đổi long sang double nếu cần

            System.out.println("thinh: " + label + " - " + value);
        }
        return statistics;

    }

    //Thống kê số lượng hóa đơn theo khoảng thời gian
    public List<StatisticDTO> getStatisticOrderByDate(LocalDateTime startDate, LocalDateTime endDate) {
        List<Object[]> results = orderRepository.findStatisticByDate(startDate, endDate);
        List<StatisticDTO> statistics = new ArrayList<>();
        for (Object[] result : results) {

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateTime = (LocalDateTime) result[0];
            String label = dateTime.format(formatter);;  // Ngày dưới dạng chuỗi
            long value = (long) result[1] ; // Số lượng dưới dạng long
            statistics.add(new StatisticDTO(label, (double) value));  // Chuyển đổi long sang double nếu cần

            System.out.println("thinh: " + label + " - " + value);
        }
        return statistics;

    }

    //Thống kê doanh thu theo khoảng thời gian ngày
    public List<StatisticDTO> getStatisticSalesByDate(LocalDateTime startDate, LocalDateTime endDate) {
        List<Object[]> results = orderRepository.findStatisticSalesByDate(startDate, endDate);
        List<StatisticDTO> statistics = new ArrayList<>();

        for (Object[] result : results) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateTime = (LocalDateTime) result[0];
            String label = dateTime.format(formatter);;  // Ngày dưới dạng chuỗi
            double value = (double) result[1] ; // Số lượng dưới dạng long
            statistics.add(new StatisticDTO(label, value));  // Chuyển đổi long sang double nếu cần

            System.out.println("thinh: " + label + " - " + value);
        }
        return statistics;
    }

    // Thống kê doanh thu theo tháng trong năm
    public List<StatisticDTO> getStatisticSalesByMonth() {

        // Lấy năm hiện tại
        int currentYear = LocalDateTime.now().getYear();

        List<Object[]> results = orderRepository.findStatisticSalesByMonth(currentYear);
        List<StatisticDTO> statistics = new ArrayList<>();

        // Tạo một mảng hoặc danh sách chứa tất cả các tháng với giá trị ban đầu là 0
        double[] monthlyRevenue = new double[12]; // Mặc định các giá trị là 0

        // Ghi đè giá trị doanh thu cho các tháng có doanh thu
        for (Object[] result : results) {
            int month = ((Number) result[0]).intValue() - 1; // Lấy tháng, trừ 1 để phù hợp với chỉ số mảng
            double value = ((Number) result[1]).doubleValue(); // Lấy doanh thu
            monthlyRevenue[month] = value; // Ghi đè doanh thu vào mảng
        }

        // Tạo danh sách kết quả cuối cùng, đảm bảo tất cả các tháng đều có mặt
        for (int month = 0; month < 12; month++) {
            String label = "Tháng " + (month + 1); // Đặt nhãn cho tháng
            double value = monthlyRevenue[month]; // Lấy giá trị doanh thu từ mảng
            statistics.add(new StatisticDTO(label, (long) value));
        }

        return statistics;
    }

    //Thống kê doanh thu theo các năm
    public List<StatisticDTO> getStatisticSalesByYear() {
        List<Object[]> results = orderRepository.findStatisticSalesByYear();
        List<StatisticDTO> statistics = new ArrayList<>();

        for (Object[] result : results) {
            String label = result[0].toString();
            double value = ((Number) result[1]).doubleValue();
            System.out.println("thinh: " + label + " - " + value);
            statistics.add(new StatisticDTO(label, value));
        }
        return statistics;
    }




    //Chuyển đổi Object sang StatisticProductDTO
    private List<StatisticProductDTO> getStatisticProductDTOS(List<Object[]> results) {
        List<StatisticProductDTO> statistics = new ArrayList<>();

        for (Object[] result : results) {
            System.out.println("thinh: " + result[0].toString() + " " + result[1].toString());
            Product productTmp = productRepository.getById((int)result[0]);

            StatisticProductDTO statisticProductDTO = new StatisticProductDTO();
            statisticProductDTO.setProductId(productTmp.getProductId());
            statisticProductDTO.setProductName(productTmp.getProductName());
            statisticProductDTO.setQuantity((long)result[1]);

            Iterator<Image> iterator = productTmp.getImages().iterator();

            if (iterator.hasNext()) {
                Image firstValue = iterator.next();
                statisticProductDTO.setProductImage(firstValue.getLinkImage());
            }
            statistics.add(statisticProductDTO);

        }


        return statistics;
    }


}
