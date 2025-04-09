package iti.jets.util;

import iti.jets.entity.Cart;
import iti.jets.entity.CartPK;
import iti.jets.entity.Product;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class MainSeeder {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa-mysql");
        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Create and persist User first
            User user = em.find(User.class, 1);
            if (user == null) {
                user = new User();
                user.setUserName("John Doe");
                user.setEmail("john@example.com");
                user.setPassword("1234");
                user.setPhone("0100000000");
                em.persist(user);
                em.flush(); // Force the user to be saved and get an ID
                System.out.println("User created successfully with ID: " + user.getUserId());
            } else {
                System.out.println("User already exists: " + user.getUserName() + " with ID: " + user.getUserId());
            }
            
            // Create and persist Products
            Product p1 = null;
            Product p2 = null;
            
            p1 = em.find(Product.class, 1);
            if (p1 == null) {
                p1 = new Product("Puzzle Game", "A brain-teasing puzzle", 50, 100);
                em.persist(p1);
            }
            
            p2 = em.find(Product.class, 2);
            if (p2 == null) {
                p2 = new Product("Math Challenge", "Math-based quiz game", 60, 150);
                em.persist(p2);
            }
            
            em.flush(); // Force products to be saved and get IDs
            System.out.println("Products with IDs: " + p1.getProductId() + ", " + p2.getProductId());
            
            // Check if cart items already exist
            CartPK cartPK1 = new CartPK(user.getUserId(), p1.getProductId());
            CartPK cartPK2 = new CartPK(user.getUserId(), p2.getProductId());
            
            Cart existingCart1 = em.find(Cart.class, cartPK1);
            Cart existingCart2 = em.find(Cart.class, cartPK2);
            
            if (existingCart1 == null) {
                // Create new cart item
                Cart cart1 = new Cart();
                cart1.setUserId(user.getUserId());
                cart1.setProductId(p1.getProductId());
                cart1.setQuantity(2);
                cart1.setUser(user);
                cart1.setProduct(p1);
                
                em.persist(cart1);
                System.out.println("Added cart item 1: User=" + cart1.getUserId() + ", Product=" + cart1.getProductId());
            } else {
                System.out.println("Cart 1 already exists");
            }
            
            if (existingCart2 == null) {
                // Create new cart item
                Cart cart2 = new Cart();
                cart2.setUserId(user.getUserId());
                cart2.setProductId(p2.getProductId());
                cart2.setQuantity(3);
                cart2.setUser(user);
                cart2.setProduct(p2);
                
                em.persist(cart2);
                System.out.println("Added cart item 2: User=" + cart2.getUserId() + ", Product=" + cart2.getProductId());
            } else {
                System.out.println("Cart 2 already exists");
            }
            
            em.flush(); // Force cart items to be saved
            
            System.out.println("Committing transaction...");
            em.getTransaction().commit();
            System.out.println("Transaction committed successfully");
            
        } catch (Exception e) {
            System.out.println("Error occurred: " + e.getMessage());
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
                System.out.println("Transaction rolled back");
            }
        } finally {
            if (em.isOpen()) {
                em.close();
            }
            if (emf.isOpen()) {
                emf.close();
            }
        }
    }
}