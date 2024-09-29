package com.example.webthoitrang.services;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.dto.ProductDto;
import com.example.webthoitrang.entity.*;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class AprioriService {

    private final OrderService orderService;
    private final AccountService accountService;
    private final ProductService productService;

    public AprioriService(OrderService orderService, AccountService accountService, ProductService productService) {
        this.orderService = orderService;
        this.accountService = accountService;
        this.productService = productService;
    }

    //Ngưỡng min_support
    private final int  minSupport = 2;

    // Phương thức để tính support cho một tập hợp item
    private Map<Set<Integer>, Integer> calculateSupport(List<Set<Integer>> transactions, Set<Set<Integer>> candidateSets) {
        Map<Set<Integer>, Integer> supportCountMap = new HashMap<>();

        for (Set<Integer> candidate : candidateSets) {
            for (Set<Integer> transaction : transactions) {
                if (transaction.containsAll(candidate)) {
                    supportCountMap.put(candidate, supportCountMap.getOrDefault(candidate, 0) + 1);
                }
            }
        }

        return supportCountMap;
    }

    // Phương thức để sinh các tập hợp item từ các tập hợp phổ biến hiện tại
    private Set<Set<Integer>> generateCandidates(Set<Set<Integer>> frequentItemSets, int k) {
        Set<Set<Integer>> candidateSets = new HashSet<>();

        for (Set<Integer> itemSet1 : frequentItemSets) {
            for (Set<Integer> itemSet2 : frequentItemSets) {
                Set<Integer> union = new HashSet<>(itemSet1);
                union.addAll(itemSet2);
                if (union.size() == k) {
                    candidateSets.add(union);
                }
            }
        }

        return candidateSets;
    }

    // Phương thức chính của thuật toán Apriori với ngưỡng minSupport có thể thay đổi
    private Map<Set<Integer>, Integer> apriori(List<Set<Integer>> transactions) {
        Map<Set<Integer>, Integer> allFrequentItemSets = new HashMap<>();
        Set<Set<Integer>> candidateSets = new HashSet<>();

        // Bước 1: Tìm các tập hợp item đơn lẻ phổ biến
        for (Set<Integer> transaction : transactions) {
            for (Integer item : transaction) {
                Set<Integer> itemSet = new HashSet<>();
                itemSet.add(item);
                candidateSets.add(itemSet);
            }
        }

        int k = 1;
        while (!candidateSets.isEmpty()) {
            // Tính support cho các tập hợp item
            Map<Set<Integer>, Integer> supportCountMap = calculateSupport(transactions, candidateSets);
            candidateSets.clear();

            // Giữ lại các tập hợp item phổ biến dựa trên minSupport
            for (Map.Entry<Set<Integer>, Integer> entry : supportCountMap.entrySet()) {
                if (entry.getValue() >= minSupport) {
                    allFrequentItemSets.put(entry.getKey(), entry.getValue());
                    candidateSets.add(entry.getKey());
                }
            }

            // Sinh tập hợp item mới cho vòng tiếp theo
            candidateSets = generateCandidates(candidateSets, ++k);
        }

        return allFrequentItemSets;
    }

    // Phương thức để gợi ý sản phẩm cho người dùng
    private Set<Integer> suggestProducts(Set<Integer> userItems, Map<Set<Integer>, Integer> frequentItemSets) {
        Set<Integer> suggestions = new HashSet<>();

        for (Set<Integer> itemSet : frequentItemSets.keySet()) {
            if (itemSet.containsAll(userItems)) {
                for (Integer item : itemSet) {
                    if (!userItems.contains(item)) {
                        suggestions.add(item);
                    }
                }
            }
        }

        return suggestions;
    }

    private List<Set<Integer>> getTransactions() {
        List<Set<Integer>> transactions = new ArrayList<>();
        List<Order> orders = orderService.getAllOrder();

        for (Order order : orders) {
            Set<Integer> tmp = new HashSet<>();
            for (OrderDetail orderDetail : order.getOrderDetails()) {
                tmp.add(orderDetail.getSizeDetail().getProduct().getProductId());
                transactions.add(tmp);
            }
        }

        return transactions;
    }


    //Lấy ds gợi ý
    public Set<ProductDto> getRecommentProduct(HttpServletRequest request){

        String email = JwtUtil.getEmailFromCookie(request);
        if(email == null){
            return null;
        }
        Customer customer = accountService.getAccountByEmail(email).getCustomer();

        //Lưu kết quả gợi ý trả về
        Set<Integer> results  = new HashSet<>();

        //Danh sách đơn của KH
        List<Order> ordersCustomer = orderService.getOrdersByCustomer(customer);

        //Danh sách sản phẩm của từng hóa đơn
        Set<Set<Integer>> productOrderList = new HashSet<>();

        //Lấy danh sách sản phẩm của từng hoá đơn
        for (Order order : ordersCustomer) {
            Set<Integer> product = new HashSet<>();

            //Lấy danh sách sản phẩm trong 1 hóa đơn
            for (OrderDetail orderDetail : order.getOrderDetails()) {
                product.add(orderDetail.getSizeDetail().getProduct().getProductId());
            }
            productOrderList.add(product);
        }

        Map<Set<Integer>, Integer> frequentItemSets = apriori(getTransactions());

        for (Set<Integer> userItems : productOrderList) {
            Set<Integer> suggestions = suggestProducts(userItems, frequentItemSets);
            results.addAll(suggestions);
        }

        return convertDto(results);

    }



    private Set<ProductDto> convertDto (Set<Integer> productIdList) {
        Set<ProductDto> results= new HashSet<>();

        for (Integer productId : productIdList) {
            ProductDto p = new ProductDto();
            Product product = productService.getProductById(productId);
            p.setProductId(product.getProductId());
            p.setProductName(product.getProductName());
            p.setPrice(productService.getPriceProduct(product));

            Double discountPrice = productService.getDiscountPriceProduct(product.getProductId());
            if (discountPrice != null) {
                p.setDiscountPrice(discountPrice);

            }

            Iterator<Image> iterator = product.getImages().iterator();
            if (iterator.hasNext()) {
                Image image = iterator.next();
                if(image != null){
                    System.out.println("thinh: "+ image.getLinkImage());
                    p.setProductImage(image.getLinkImage());

                }
            }

            results.add(p);
        }

        return results;

    }
}
