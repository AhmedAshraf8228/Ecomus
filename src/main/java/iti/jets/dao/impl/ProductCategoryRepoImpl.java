package iti.jets.dao.impl;

import iti.jets.entity.ProductCategory;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ProductCategoryRepoImpl extends GenericRepoImpl{

    public ProductCategoryRepoImpl() {
        super(ProductCategory.class);
    }
    public ProductCategoryRepoImpl(EntityManager entityManager){
        super(ProductCategory.class ,entityManager);

    }



}
