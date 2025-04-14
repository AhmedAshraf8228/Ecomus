package iti.jets.dao.impl;

import java.util.List;

import iti.jets.entity.Cart;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class CartRepoImpl extends GenericRepoImpl<Cart, Integer> {
    private EntityManager entityManager;

    public CartRepoImpl() {
        super(Cart.class);
        this.entityManager = getEntityManager();
    }

    public CartRepoImpl(EntityManager em ){
        super(Cart.class , em);
        this.entityManager=em;

    }

    public int getTotalQuantityByUserId(int userId) {
        TypedQuery<Long> query = entityManager.createQuery(
                "SELECT SUM(c.quantity) FROM Cart c WHERE c.user.userId = :userId", Long.class);
        query.setParameter("userId", userId);

        Long result = query.getSingleResult();
        return result != null ? result.intValue() : 0;
    }

    public List<Cart> getCartItemsByUserId(int userId) {
        TypedQuery<Cart> query = entityManager.createQuery(
            "SELECT c FROM Cart c WHERE c.user.userId = :userId", Cart.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
    
    
    public Cart getCartByUserAndProduct(int userId, int productId) {
        TypedQuery<Cart> query = entityManager.createQuery(
            "SELECT c FROM Cart c WHERE c.user.userId = :userId AND c.product.productId = :productId", Cart.class);
        query.setParameter("userId", userId);
        query.setParameter("productId", productId);
        return query.getResultList().stream().findFirst().orElse(null);
    }
    
    public boolean deleteByUserIdAndProductId(int userId, int productId) {
        boolean isActive = false;
        try {
            isActive = entityManager.getTransaction().isActive();
            if (!isActive) {
                entityManager.getTransaction().begin();
            }
            
            int deletedCount = entityManager.createQuery(
                "DELETE FROM Cart c WHERE c.user.userId = :userId AND c.product.productId = :productId")
                .setParameter("userId", userId)
                .setParameter("productId", productId)
                .executeUpdate();
            
            if (!isActive) {
                entityManager.getTransaction().commit();
            }
            
            return deletedCount > 0;
        } catch (Exception e) {
            if (!isActive && entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    
    // Add this method to calculate the total cart value
    public int calculateCartTotal(int userId) {
        int total = 0;
        List<Cart> cartItentityManagers = getCartItemsByUserId(userId);
        
        for (Cart cart : cartItentityManagers) {
            total += cart.getProduct().getPrice() * cart.getQuantity();
        }
        
        return total;
    }

    @Override
    public Cart insert(Cart cart){
        entityManager.getTransaction().begin();
        entityManager.persist(cart);
        //entityManager.flush();
        entityManager.getTransaction().commit();
        return cart;

    }
}
