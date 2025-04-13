package iti.jets.dao.impl;

import iti.jets.entity.ProductCategory;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ProductCategoryRepoImpl extends GenericRepoImpl{

    EntityManager em;

    public ProductCategoryRepoImpl() {
        super(ProductCategory.class);
        this.em = getEntityManager();
    }
    public ProductCategoryRepoImpl(EntityManager entityManager){
        super(ProductCategory.class ,entityManager);
        this.em=entityManager;

    }


    public int countProductsInCategory(int catId) {
        Long count =
                (Long) em.createQuery("SELECT count(pc.id.productId) FROM  ProductCategory pc WHERE pc.id.categoryId = :catId ")
                        .setParameter("catId" , catId)
                        .getSingleResult();
        return count.intValue();
    }



}
