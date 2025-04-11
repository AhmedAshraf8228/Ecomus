package iti.jets.dao.impl;

import iti.jets.entity.Product;
import jakarta.persistence.EntityManager;

public class ProductRepoImpl extends GenericRepoImpl<Product , Integer> {

    public ProductRepoImpl() {
        super(Product.class);
    }

}
