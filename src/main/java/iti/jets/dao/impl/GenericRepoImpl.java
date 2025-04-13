package iti.jets.dao.impl;

import iti.jets.dao.repo.GenericRepo;
import jakarta.persistence.*;
import lombok.Getter;

import java.util.List;

public class GenericRepoImpl<T,ID> implements GenericRepo<T,ID> {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa-mysql");
    @Getter
    private final EntityManager entityManager ;
    private final Class<T> entityClass;

    public GenericRepoImpl( Class<T> entityClass ){
//        this.entityManager = emf.createEntityManager();
//        this.entityClass = entityClass;
        this(entityClass ,emf.createEntityManager());
    }

    public GenericRepoImpl(Class<T> entityClass, EntityManager entityManager) {
        this.entityClass = entityClass;
        this.entityManager = entityManager;
    }


    @Override
    public int countRows() {
        Long count = (Long) entityManager.createQuery("SELECT count(e) FROM " + entityClass.getSimpleName() + " e")
                .getSingleResult();
        return count.intValue();
    }

    @Override
    public List<T> findAll() {

        return entityManager.
                createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass)
                .getResultList();

//        List<T> resultList = null;
//        try {
//            entityManager.getTransaction().begin();
//            TypedQuery<T> query = entityManager.createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass);
//            resultList = query.getResultList();
//            entityManager.getTransaction().commit();
//
//        } catch (RuntimeException e) {
//            if (entityManager.getTransaction().isActive()) {
//                entityManager.getTransaction().rollback();
//            }
//            System.out.println(e.getMessage());
//        }
//        return resultList != null ? resultList : new ArrayList<T>();

    }

    @Override
    public T findById(int id) {
        return entityManager.find(entityClass , id);
    }

    @Override
    public T insert(T t) {

        entityManager.persist(t);
        entityManager.flush();
        return t;


//        try {
//            entityManager.getTransaction().begin();
//            entityManager.persist(t);
//             entityManager.getTransaction().commit();
//            entityManager.refresh(t);
//            return t;
//        }catch (Exception e){
//             entityManager.getTransaction().rollback();
//             System.out.println("************** Error inserting: " + e);
//             return null;
//        }
    }

    @Override
    public T update(T t) {

        return entityManager.merge(t);

//        try {
//            entityManager.getTransaction().begin();
//            t = entityManager.merge(t);
//            entityManager.getTransaction().commit();
//            return t;
//        } catch (Exception e) {
//            entityManager.getTransaction().rollback();
//            System.out.println("************** Error inserting: " + e);
//            throw e;
//        }
    }

    @Override
    public void deleteById(int id) {


        T t = entityManager.find(entityClass , id);
        if(t != null){
            entityManager.remove(t);
        }

//        entityManager.getTransaction().begin();
//        T t = entityManager.find(entityClass , id);
//        if(t != null){
//            entityManager.remove(t);
//        }
//        entityManager.getTransaction().commit();
    }

    @Override
    public void delete(T t) {

        entityManager.remove(t);

//        entityManager.getTransaction().begin();
//        entityManager.remove(t);
//        entityManager.getTransaction().commit();

    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

}
