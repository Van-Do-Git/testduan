package com.case3.service.category;

import com.case3.model.Category;

import java.util.List;

public class CategoryReService implements ICategoryService{
    @Override
    public List<Category> findAll() {
        return null;
    }

    @Override
    public Category findById(int id) {
        return null;
    }

    @Override
    public void save(Category category) {

    }

    @Override
    public void edit(Category category, int id) {

    }

    @Override
    public void delete(int id) {
        System.out.println("namluty");
    }
}
