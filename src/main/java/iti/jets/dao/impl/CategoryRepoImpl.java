package iti.jets.dao.impl;

import iti.jets.entity.Category;
import jakarta.persistence.EntityManager;

import java.util.List;


public class CategoryRepoImpl extends GenericRepoImpl{

    public CategoryRepoImpl() {
        super(Category.class);
    }

    public CategoryRepoImpl(EntityManager entityManager){
        super(Category.class , entityManager);
    }

    public List<Integer> getCategoryIdByName(List<String>names){
       return getEntityManager().createQuery(
                        "SELECT c.categoryId FROM Category c WHERE c.categoryName IN :names", Integer.class)
                .setParameter("names", names)
                .getResultList();

    }
}
