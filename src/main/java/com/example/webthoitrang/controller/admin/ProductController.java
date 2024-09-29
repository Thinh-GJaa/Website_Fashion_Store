package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.bean.JwtUtil;
import com.example.webthoitrang.entity.*;
import com.example.webthoitrang.helper.FirebaseHelper;
import com.example.webthoitrang.services.*;
import com.google.cloud.storage.Blob;
import com.google.firebase.cloud.StorageClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.*;

@Transactional
@Controller
@RequestMapping("/admin/product") // Định nghĩa đường dẫn chung
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private BrandService brandService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SizeService sizeService;

    @Autowired
    private  SizeDetailService sizeDetailService;

    @Autowired
    private ImageService imageService;
    @Autowired
    private AccountService accountService;

    @GetMapping
    public ModelAndView productHome() {
        ModelAndView mav = new ModelAndView("admin/product");

        //Thêm danh sách sản phẩm
        mav.addObject("productList", productService.getAllProduct());

        //Thêm danh sách các thuộc tính liên quan
        mav.addObject("categoryList", categoryService.getAllCategory());
        mav.addObject("brandList", brandService.getAllBrand());
        mav.addObject("materialList", materialService.getAllMaterial());
        mav.addObject("sizeList", sizeService.getAllSize());

        //Thêm biến product cho các modal
        mav.addObject("productNew", new Product());
        mav.addObject("productEdit", new Product());
        return mav;
    }

    @PostMapping()
    public ResponseEntity<String> addProduct(@ModelAttribute("productNew") Product product,
                                             @RequestParam("files") MultipartFile[] files) {
        try {
            product = productService.addOrUpdateProduct(product);
            // Xử lý lưu ảnh lên Firebase Storage và lấy các đường dẫn download về
            Set<Image> images = new HashSet<>();
            for (int i = 0; i < files.length; i++) {
                MultipartFile image = files[i];
                String fileName = "images/products/" + product.getProductId() + "_" + i + ".jpg" ;
                Blob blob = StorageClient.getInstance().bucket().create(fileName, image.getInputStream(), image.getContentType());
                String link = blob.getMediaLink();

                Image imageTmp = new Image();
                imageTmp.setLinkImage(link);
                imageTmp.setProduct(product);
                imageTmp = imageService.addOrUpdateImage(imageTmp);

                images.add(imageTmp);
            }
            System.out.println("thinh: " +images);

            // Xử lý lưu thông tin sản phẩm vào database
            product.setImages(images);
            productService.addOrUpdateProduct(product);
            return new ResponseEntity<>("Thêm Sản phẩm mới thành công", HttpStatus.OK);
        } catch (Exception e) {
            // Xử lý lỗi và trả về lỗi 500
            e.printStackTrace();
            return new ResponseEntity<>("Lỗi thêm mới Sản phẩm !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @PutMapping
    public ResponseEntity<String> editProduct(@ModelAttribute("productEdit") Product product,
                                              @RequestParam("imageProduct") MultipartFile imageProduct) {
        try {

            if(!imageProduct.isEmpty()) {
                String linkImage = FirebaseHelper.uploadImageProduct(product.getProductId(), imageProduct);
                Set<Image> imageList = productService.getProductById(product.getProductId()).getImages();
                for(Image image : imageList){
                    image.setLinkImage(linkImage);
                }

                product.setImages(imageList);
            }

            productService.addOrUpdateProduct(product);

            return new ResponseEntity<>("Sản phẩm đã được sửa thành công", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Sửa Sản phẩm thất bại  !!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("/inventory")
    public ModelAndView productInventory() {
        ModelAndView mav = new ModelAndView("admin/product-inventory");
        List <SizeDetail> productList = sizeDetailService.getAllSizeDetailOrderByProduct();
        mav.addObject("productList", productList);
        return mav;

    }

    @PutMapping("/inventory")
    public ResponseEntity<String> productInventoryEdit(@ModelAttribute SizeDetail sizeDetail) {
        try{
            System.out.println("thinh: " +sizeDetail.getQuantity());
            if(sizeDetail.getQuantity() < 0){
                return new ResponseEntity<>("Số lượng không được âm", HttpStatus.BAD_REQUEST);
            }
            SizeDetailId sizeDetailId = new SizeDetailId(sizeDetail.getSize().getSizeId(), sizeDetail.getProduct().getProductId());
            sizeDetail.setSizeDetailId(sizeDetailId);
            sizeDetailService.addOrUpdateSizeDetail(sizeDetail);
            return new ResponseEntity<>("Đã cập nhật số lượng", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Đã xãy ra lỗi!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("update-price")
    public ModelAndView productUpdatePriceView(@ModelAttribute("productEdit") Product product) {
        ModelAndView mav = new ModelAndView("admin/product-update-price");
        List <Product> productList = productService.getAllProduct();
        List <Float> priceList = new ArrayList<>();
        for( Product p : productList){
            float price = productService.getPriceProduct(p);
            priceList.add(price);
        }

        mav.addObject("productList", productList);
        mav.addObject("priceList", priceList);
        return mav;
    }

    @PutMapping("/update-price")
    public ResponseEntity<String> productUpdatePrice(@RequestParam int productId, @RequestParam float priceNew,
                                                     HttpServletRequest request) {
        try{
            if(priceNew < 0){
                return new ResponseEntity<>("Giá cập nhâật không hợp lệ!!!", HttpStatus.BAD_REQUEST);
            }

            String email = JwtUtil.getEmailFromCookie(request);
            Staff staff = accountService.getAccountByEmail(email).getStaff();

            PriceDetailId priceDetailId = new PriceDetailId();
            priceDetailId.setProductId(productId);
            priceDetailId.setCreateDate(LocalDateTime.now());
            priceDetailId.setStaffId(staff.getStaffId());

            PriceDetail priceDetail = new PriceDetail();
            priceDetail.setPriceDetailId(priceDetailId);
            priceDetail.setNewPrice(priceNew);

            productService.addOrUpdatePriceDetail(priceDetail);

            System.out.println("thinh: " +LocalDateTime.now());
            return new ResponseEntity<>("Giá mới đã đuợc cập nhật", HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Đã xảy ra lỗi", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
