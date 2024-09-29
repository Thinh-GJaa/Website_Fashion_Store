package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Category;
import com.example.webthoitrang.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @Autowired
    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllCategory() {return categoryRepository.findAll();}

    public Category addOrUpdateCategory(Category category) {return categoryRepository.save(category);}

    public Category getCategoryById(int id) {return categoryRepository.findById(id).orElse(null);}

    public Category getCategoryByCategoryName(String categoryName) {return categoryRepository.findByCategoryName(categoryName); }


}
