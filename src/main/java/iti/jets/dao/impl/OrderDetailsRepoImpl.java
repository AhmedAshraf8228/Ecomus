package iti.jets.dao.impl;

import java.util.List;

import iti.jets.entity.OrderDetails;
import jakarta.persistence.TypedQuery;

public class OrderDetailsRepoImpl extends GenericRepoImpl<OrderDetails, Integer> {
    
    public OrderDetailsRepoImpl() {
        super(OrderDetails.class);
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
}