package iti.jets.dao.impl;

import java.util.List;

import iti.jets.dao.repo.GenericRepo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class GenericRepoImpl<T,ID> implements GenericRepo<T,ID> {


    protected final EntityManager entityManager ;
    private final Class<T> entityClass;

    public GenericRepoImpl(EntityManager entityManager, Class<T> entityClass ){
        this.entityManager = entityManager;
        this.entityClass = entityClass;
    }

    @Override
    public List<T> findAll() {
        TypedQuery<T> query = entityManager.createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass);
        return query.getResultList();
    }

    @Override
    public T findById(int id) {
        return entityManager.find(entityClass , id);
    }

    @Override
    public T insert(T t) {
        entityManager.getTransaction().begin();
        entityManager.persist(t);
        entityManager.getTransaction().commit();
        entityManager.refresh(t);
        return t;
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
}
