package iti.jets.entity;

import jakarta.persistence.*;
import java.io.Serializable;

// todo --> add @Getter , @Setter , @NoArgsCon
// todo --> alter FK in DB
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

    @OneToOne(cascade = CascadeType.ALL)
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

