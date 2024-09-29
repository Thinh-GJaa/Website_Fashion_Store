package com.example.webthoitrang.helper;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.firebase.cloud.StorageClient;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class FirebaseHelper {

    public static String uploadImageStaff(int staffId, MultipartFile imageStaff) {
        try {
            String fileName = "images/staffs/" + staffId + ".jpg";
            Blob blob = StorageClient.getInstance().bucket().create(fileName, imageStaff.getInputStream(), imageStaff.getContentType());
            return blob.getMediaLink();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String uploadImageCustomer(int customerId, MultipartFile imageCustomer) {
        try {
            String fileName = "images/customers/" + customerId + ".jpg";
            Blob blob = StorageClient.getInstance().bucket().create(fileName, imageCustomer.getInputStream(), imageCustomer.getContentType());
            return blob.getMediaLink();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String uploadImageCategory(int categoryId, MultipartFile imageCategory) {
        try {
            String fileName = "images/categorys/" + categoryId + ".jpg";
            Blob blob = StorageClient.getInstance().bucket().create(fileName, imageCategory.getInputStream(), imageCategory.getContentType());
            return blob.getMediaLink();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String uploadImageProduct(int productId, MultipartFile imageProduct) {
        try {
            String fileName = "images/products/" + productId + ".jpg";
            Blob blob = StorageClient.getInstance().bucket().create(fileName, imageProduct.getInputStream(), imageProduct.getContentType());
            return blob.getMediaLink();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<String> getImageBannerList() {
        String directory = "images/banner";
        List<String> imageUrls = new ArrayList<>();
        Bucket bucket = StorageClient.getInstance().bucket();
        Storage storage = StorageOptions.getDefaultInstance().getService();

        for (Blob blob : bucket.list(Storage.BlobListOption.prefix(directory)).iterateAll()) {
            if (!blob.isDirectory()) {
                String signedUrl = blob.signUrl(1, TimeUnit.HOURS).toString(); // Tạo URL có thể truy cập trong 1 giờ
                imageUrls.add(signedUrl);
            }
        }
        return imageUrls;
    }
}



