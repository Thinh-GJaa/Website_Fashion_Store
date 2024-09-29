package com.example.webthoitrang.controller.admin;

import com.example.webthoitrang.entity.Category;
import com.example.webthoitrang.entity.Image;
import com.example.webthoitrang.services.CategoryService;
import com.example.webthoitrang.services.ImageService;
import com.google.cloud.storage.Blob;
import com.google.firebase.cloud.StorageClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/admin/category") // Định nghĩa đường dẫn chung
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ImageService imageService;

    @GetMapping
    public ModelAndView categoryHome() {

        ModelAndView mav = new ModelAndView("admin/category");

        List<Category> categoryList = categoryService.getAllCategory();
        mav.addObject("categoryList", categoryList);
        return mav;
    }

    @PostMapping()
    public ResponseEntity<String> categoryAdd(@RequestParam("categoryName") String categoryName,
                                              @RequestParam("categoryImage") MultipartFile categoryImage) {
        try{
            if(categoryService.getCategoryByCategoryName(categoryName) != null){
                return new ResponseEntity<>("Tên Danh mục đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            Category category = new Category();
            category.setCategoryName(categoryName);
            category = categoryService.addOrUpdateCategory(category);

            String fileName = "images/categorys/" + category.getCategoryId() + ".jpg" ;
            Blob blob = StorageClient.getInstance().bucket().create(fileName, categoryImage.getInputStream(), categoryImage.getContentType());
            String linkImage = blob.getMediaLink();

            Image image = new Image();
            image.setLinkImage(linkImage);
            image = imageService.addOrUpdateImage(image);

            category.setImage(image);
            categoryService.addOrUpdateCategory(category);

            return new ResponseEntity<>("Thêm Danh mục mới thành công", HttpStatus.OK);
        }
        catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Thêm Danh muc mới thất bại!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping
    public ResponseEntity<String> editCategory(@RequestParam("editCategoryId") int categoryId,
                                               @RequestParam("editCategoryName") String categoryName,
                                               @RequestParam("editCategoryImage") MultipartFile categoryImage) {
        try{
            Category category = categoryService.getCategoryById(categoryId);

            //Kiểm tra tên danh mục đã tồn tại chưa
            if(categoryService.getCategoryByCategoryName(categoryName) != null
            && categoryService.getCategoryByCategoryName(categoryName).getCategoryId() != categoryId){
                return new ResponseEntity<>("Tên Danh mục đã tồn tại!!!", HttpStatus.CONFLICT);
            }

            //Up ảnh lên firebase
            String fileName = "images/categorys/" + category.getCategoryId() + ".jpg" ;
            Blob blob = StorageClient.getInstance().bucket().create(fileName, categoryImage.getInputStream(), categoryImage.getContentType());
            String linkImage = blob.getMediaLink();

            Image image = category.getImage();
            if(image == null){
                image = new Image();
            }
            image.setLinkImage(linkImage);
            image = imageService.addOrUpdateImage(image);

            category.setImage(image);
            category.setCategoryName(categoryName);

            categoryService.addOrUpdateCategory(category);

            return new ResponseEntity<>("Sửa Danh mục thành công", HttpStatus.OK);
        }
        catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Sửa Danh mục thất bại!!!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
