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

    }

    @Override
    public T update(T t) {
        entityManager.getTransaction().begin();
        t = entityManager.merge(t);
        entityManager.getTransaction().commit();
        return t ;
    }

    @Override
    public void deleteById(int id) {

        T t = entityManager.find(entityClass , id);
        if(t != null){
            entityManager.remove(t);
        }

    }

    @Override
    public void delete(T t) {
        entityManager.remove(t);
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

}
