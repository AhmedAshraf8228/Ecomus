package iti.jets.dao.impl;

import iti.jets.entity.User;
import iti.jets.service.PasswordUtils;
import jakarta.persistence.*;

import java.util.List;

public class UserRepoImpl extends GenericRepoImpl<User, Integer>{

    public UserRepoImpl(EntityManager entityManager ,Class<User> entityClass ){
        super(entityManager , entityClass);
    }

    public Long checkValidEmail ( String email ){
            // Query to check if email exists in the database
            String query = "SELECT COUNT(u) FROM User u WHERE u.email = :email";

            return  (Long) getEntityManager().createQuery(query)
                    .setParameter("email", email)
                    .getSingleResult();
    }

    public User getUserByEmail(String email ){
        String query = "from User u where u.email = :email ";
        Query query1 = getEntityManager().createQuery(query);
        query1.setParameter("email", email);
        List<User> user = query1.getResultList();
        if (!user.isEmpty()){
            return user.get(0);
        }else {
            return null;
        }
    }
}
