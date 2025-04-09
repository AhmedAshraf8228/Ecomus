package iti.jets.dao.impl;

import iti.jets.entity.Product;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;

public class UserRepoImpl extends GenericRepoImpl<User, Integer>{

    public UserRepoImpl(EntityManager entityManager ,Class<User> entityClass ){
        super(entityManager , entityClass);
    }
    public static Long checkValidEmail (EntityManager entityManager , String email ){
            // Query to check if email exists in the database
            String query = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            return  (Long) entityManager.createQuery(query)
                    .setParameter("email", email)
                    .getSingleResult();
    }

}
