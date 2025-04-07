package iti.jets.dao.impl;

import iti.jets.entity.Product;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;

public class UserRepoImpl extends GenericRepoImpl<User, Integer>{

    public UserRepoImpl(EntityManager entityManager ,Class<User> entityClass ){
        super(entityManager , entityClass);
    }
}
