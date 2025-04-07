package iti.jets.entity;

import iti.jets.enums.OrderStatus;
import iti.jets.enums.PayType;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "orders")
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderId")
    private int orderId;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "price", nullable = false)
    private int price;

    @Column(name = "date", nullable = false)
    private Date date;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private OrderStatus status;

    @Enumerated(EnumType.STRING)
    @Column(name = "payType", nullable = false)
    private PayType payType;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;

    public Order() {
    }

    public Order(String address, int price, Date date, OrderStatus status, PayType payType, User user) {
        this.address = address;
        this.price = price;
        this.date = date;
        this.status = status;
        this.payType = payType;
        this.user = user;
    }

    // Getters and setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public PayType getPayType() {
        return payType;
    }

    public void setPayType(PayType payType) {
        this.payType = payType;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

