package iti.jets.dao.impl;

import java.util.List;

import iti.jets.entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class OrderRepoImpl extends GenericRepoImpl<Order, Integer> {

    EntityManager entityManager;
    public OrderRepoImpl() {
        super(Order.class);
        this.entityManager=getEntityManager();
    }

    public OrderRepoImpl(EntityManager em ){
        super(Order.class , em);
        this.entityManager=em;

    }
    
    public List<Order> getOrdersByUserId(int userId) {
        TypedQuery<Order> query = getEntityManager().createQuery(
            "SELECT o FROM Order o WHERE o.user.userId = :userId ORDER BY o.date DESC", Order.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
    
    public boolean deleteOrderById(int orderId) {
        try {
            getEntityManager().getTransaction().begin();
            int deletedCount = getEntityManager().createQuery(
                "DELETE FROM Order o WHERE o.orderId = :orderId")
                .setParameter("orderId", orderId)
                .executeUpdate();
            getEntityManager().getTransaction().commit();
            return deletedCount > 0;
        } catch (Exception e) {
            if (getEntityManager().getTransaction().isActive()) {
                getEntityManager().getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }

    
    }
    // @Override
    // public Order insert(Order order){
    //     entityManager.getTransaction().begin();
    // entityManager.persist(order);
    //     entityManager.getTransaction().commit();
    //     return order;
    // }
}