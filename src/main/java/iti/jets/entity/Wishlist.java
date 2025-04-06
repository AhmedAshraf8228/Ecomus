package iti.jets.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "wishlist")
@IdClass(WishlistPK.class)
public class Wishlist implements Serializable {

    @Id
    @Column(name = "userId")
    private int userId;

    @Id
    @Column(name = "productId")
    private int productId;

    @ManyToOne
    @JoinColumn(name = "productId", insertable = false, updatable = false)
    private Product product;

    @ManyToOne
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    private User user;

    public Wishlist() {
    }

    public Wishlist(int productId, Product product, User user) {
        this.productId = productId;
        this.product = product;
        this.user = user;
    }

    // Getters and setters

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

