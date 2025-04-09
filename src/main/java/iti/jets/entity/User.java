package iti.jets.entity;

import iti.jets.service.PasswordUtils;
import jakarta.persistence.*;
import java.io.Serializable;
import java.sql.Date;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "user")
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userId")
    private int userId;

    @Column(name = "userName", nullable = false)
    private String userName;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "BD")
    private Date BD;

    @Column(name = "job")
    private String job;

    @Column(name = "city")
    private String city;

    @Column(name = "area")
    private String area;

    @Column(name = "street")
    private String street;

    @Column(name = "buildingNo")
    private String buildingNo;

    @Column(name = "creditNo")
    private String creditNo;

    @Column(name = "creditLimit")
    private Integer creditLimit;

    @Column(name = "phone")
    private String phone;

    public User() {
    }

    public User( String userName, String email, String password, Date BD, String job, String city, String area, String street, String buildingNo, String creditNo, Integer creditLimit, String phone) {
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.BD = BD;
        this.job = job;
        this.city = city;
        this.area = area;
        this.street = street;
        this.buildingNo = buildingNo;
        this.creditNo = creditNo;
        this.creditLimit = creditLimit;
        this.phone = phone;
    }

    // Getters and setters

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = PasswordUtils.hashPassword(password);
    }

    public Date getBD() {
        return BD;
    }

    public void setBD(Date BD) {
        this.BD = BD;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getBuildingNo() {
        return buildingNo;
    }

    public void setBuildingNo(String buildingNo) {
        this.buildingNo = buildingNo;
    }

    public String getCreditNo() {
        return creditNo;
    }

    public void setCreditNo(String creditNo) {
        this.creditNo = creditNo;
    }

    public Integer getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(Integer creditLimit) {
        this.creditLimit = creditLimit;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", BD=" + BD +
                ", job='" + job + '\'' +
                ", city='" + city + '\'' +
                ", area='" + area + '\'' +
                ", street='" + street + '\'' +
                ", buildingNo='" + buildingNo + '\'' +
                ", creditNo='" + creditNo + '\'' +
                ", creditLimit=" + creditLimit +
                ", phone='" + phone + '\'' +
                '}';
    }
}