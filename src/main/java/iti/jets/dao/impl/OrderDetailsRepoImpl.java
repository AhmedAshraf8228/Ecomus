package iti.jets.dao.impl;

import java.util.List;

import iti.jets.entity.Order;
import iti.jets.entity.OrderDetails;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class OrderDetailsRepoImpl extends GenericRepoImpl<OrderDetails, Integer> {

    EntityManager entityManager;
    public OrderDetailsRepoImpl() {
        super(OrderDetails.class);
        this.entityManager=getEntityManager();
    }

    public OrderDetailsRepoImpl(EntityManager em){
        super(OrderDetails.class , em);
        this.entityManager=em;

    }
    
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        TypedQuery<OrderDetails> query = getEntityManager().createQuery(
            "SELECT od FROM OrderDetails od WHERE od.order.orderId = :orderId", OrderDetails.class);
        query.setParameter("orderId", orderId);
        return query.getResultList();
    }
    
    public boolean deleteByOrderId(int orderId) {
        try {
            getEntityManager().getTransaction().begin();
            int deletedCount = getEntityManager().createQuery(
                "DELETE FROM OrderDetails od WHERE od.order.orderId = :orderId")
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
    // public OrderDetails insert(OrderDetails orderdetails){
    //     // entityManager.getTransaction().begin();
    //   entityManager.persist(orderdetails);
    //     // entityManager.getTransaction().commit();
    //     return orderdetails;
    // }
}