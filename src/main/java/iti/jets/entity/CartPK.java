package iti.jets.entity;

import java.io.Serializable;
import java.util.Objects;
// @Embeddable
public class CartPK implements Serializable {

    private int userId;
    private int productId;

    public CartPK() {
    }

    public CartPK(int userId, int productId) {
        this.userId = userId;
        this.productId = productId;
    }

    // Getters, setters, equals() and hashCode()

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CartPK cartPK = (CartPK) o;
        return userId == cartPK.userId && productId == cartPK.productId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, productId);
    }
}

