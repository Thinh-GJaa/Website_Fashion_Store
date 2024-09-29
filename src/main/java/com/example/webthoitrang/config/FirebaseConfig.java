package com.example.webthoitrang.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.io.InputStream;

@Configuration
public class FirebaseConfig {

    private final ResourceLoader resourceLoader;

    public FirebaseConfig(ResourceLoader resourceLoader) {
        this.resourceLoader = resourceLoader;
    }

    @Bean
    public void initializeFirebase() {
        try {
            // Load Firebase credentials from firebase-config.json in resources folder
            Resource resource = resourceLoader.getResource("classpath:firebase-config.json");
            InputStream serviceAccount = resource.getInputStream();

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setStorageBucket("web-ban-hang-thoi-trang.appspot.com") // Set the bucket name
                    .build();

            FirebaseApp.initializeApp(options);
        } catch (IOException e) {
            e.printStackTrace();
            // Handle exception (e.g., log error, throw RuntimeException)
            throw new RuntimeException("Failed to initialize Firebase", e);
        }
    }
}
