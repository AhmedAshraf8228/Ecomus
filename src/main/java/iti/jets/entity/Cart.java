package iti.jets.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "cart")
@IdClass(CartPK.class)
public class Cart implements Serializable {

    @Id
    @Column(name = "userId")
    private int userId;

    @Id
    @Column(name = "productId")
    private int productId;

    @Column(name = "quantity")
    private int quantity;

    @ManyToOne
    @JoinColumn(name = "productId", insertable = false, updatable = false)
    private Product product;

    @ManyToOne
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    private User user;

    public Cart() {
    }

    public Cart( int productId, int quantity, Product product, User user) {
        this.productId = productId;
        this.quantity = quantity;
        this.product = product;
        this.user = user;
    }
    // Getters and setters
    public Cart(User user, Product product, int quantity) {
        this.userId = user.getUserId();
        this.productId = product.getProductId();
        this.quantity = quantity;
        this.user = user;
        this.product = product;
    }

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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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


