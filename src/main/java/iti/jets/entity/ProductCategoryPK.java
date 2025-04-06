package iti.jets.entity;

import java.io.Serializable;
import java.util.Objects;

public class ProductCategoryPK implements Serializable {

    private int productId;
    private int categoryId;

    public ProductCategoryPK(int productId, int categoryId) {
        this.productId = productId;
        this.categoryId = categoryId;
    }

    // Getters, setters, equals() and hashCode()

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductCategoryPK that = (ProductCategoryPK) o;
        return productId == that.productId && categoryId == that.categoryId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(productId, categoryId);
    }
}

