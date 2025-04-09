package iti.jets.dao.impl;

import iti.jets.dao.repo.GenericRepo;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

public class GenericRepoImpl<T,ID> implements GenericRepo<T,ID> {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa-mysql");
    private final EntityManager entityManager ;
    private final Class<T> entityClass;

    public GenericRepoImpl(EntityManager entityManager, Class<T> entityClass ){
        this.entityManager = entityManager;
        this.entityClass = entityClass;
    }

    @Override
    public List<T> findAll() {

        List<T> resultList = null;
        try {
            entityManager.getTransaction().begin();
            TypedQuery<T> query = entityManager.createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass);
            resultList = query.getResultList();
            entityManager.getTransaction().commit();

        } catch (RuntimeException e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            System.out.println(e.getMessage());
        }
        return resultList != null ? resultList : new ArrayList<T>();

    }

    @Override
    public T findById(int id) {
        return entityManager.find(entityClass , id);
    }

    @Override
    public T insert(T t) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(t);
             entityManager.getTransaction().commit();
            entityManager.refresh(t);
            return t;
        }catch (Exception e){
             entityManager.getTransaction().rollback();
             System.out.println("************** Error inserting: " + e);
             return null;
        }
    }

    @Override
    public T update(T t) {
        entityManager.getTransaction().begin();
        t = entityManager.merge(t);
        entityManager.getTransaction().commit();
        return t;
    }

    @Override
    public void deleteById(int id) {

        entityManager.getTransaction().begin();
        T t = entityManager.find(entityClass , id);
        if(t != null){
            entityManager.remove(t);
        }
        entityManager.getTransaction().commit();
    }

    @Override
    public void delete(T t) {
        entityManager.getTransaction().begin();
        entityManager.remove(t);
        entityManager.getTransaction().commit();

    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }


}
