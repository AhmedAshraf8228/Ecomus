package iti.jets.dao.impl;

import iti.jets.entity.Product;
import jakarta.persistence.EntityManager;

public class ProductRepoImpl extends GenericRepoImpl<Product , Integer> {

    public ProductRepoImpl(EntityManager entityManager, Class<Product> entityClass) {
        super(entityManager, entityClass);
    }

}
