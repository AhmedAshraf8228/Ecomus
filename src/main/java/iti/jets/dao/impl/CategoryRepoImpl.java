package iti.jets.dao.impl;

import iti.jets.entity.Category;
import jakarta.persistence.EntityManager;

import java.util.List;


public class CategoryRepoImpl extends GenericRepoImpl<Category,Integer>{
    EntityManager em;
    public CategoryRepoImpl() {
        super(Category.class);
        em = getEntityManager();
    }

    public CategoryRepoImpl(EntityManager entityManager){
        super(Category.class , entityManager);
        this.em=entityManager;
    }

    public List<Integer> getCategoryIdByName(List<String>names){
       return em.createQuery(
                        "SELECT c.categoryId FROM Category c WHERE c.categoryName IN :names", Integer.class)
                .setParameter("names", names)
                .getResultList();

    }

    public Category getCategoryByName(String name) {
        try {
            return em.createQuery(
                            "SELECT c FROM Category c WHERE c.categoryName = :name", Category.class)
                    .setParameter("name", name)
                    .getSingleResult();
        } catch (Exception e) {
            return null; // Or handle it as needed
        }
    }

}
