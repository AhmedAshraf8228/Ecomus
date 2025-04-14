package iti.jets.dao.impl;

import iti.jets.entity.*;
import jakarta.persistence.*;

import java.util.*;

public class ProductRepoImpl extends GenericRepoImpl<Product , Integer> {
    EntityManager em;
    public ProductRepoImpl() {
        super(Product.class);
        em = getEntityManager();
    }

    public List<Product> getInStock(){
        List<Product> resultList = null;
        try {
            em.getTransaction().begin();
            TypedQuery<Product> query = em.createQuery("FROM Product p where quantity > 0", Product.class);
            resultList = query.getResultList();
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.out.println(e.getMessage());
        }
        return resultList ;
    }

    public ProductRepoImpl(EntityManager em) {
        super(Product.class, em);
    }

}
