package iti.jets.dao.impl;

import iti.jets.entity.User;
import iti.jets.service.PasswordUtils;
import jakarta.persistence.*;

import java.util.List;

public class UserRepoImpl extends GenericRepoImpl<User, Integer>{
    EntityManager em;
    public UserRepoImpl( ){
        super(User.class);
        em = getEntityManager();

    }

    public UserRepoImpl(EntityManager em ){
        super(User.class , em);
        this.em=em;

    }

    public Long checkValidEmail ( String email ){
            // Query to check if email exists in the database
            String query = "SELECT COUNT(u) FROM User u WHERE u.email = :email";

            return  (Long) em.createQuery(query)
                    .setParameter("email", email)
                    .getSingleResult();
    }

    public User getUserByEmail(String email ){
        String query = "from User u where u.email = :email ";
        Query query1 = em.createQuery(query);
        query1.setParameter("email", email);
        List<User> user = query1.getResultList();
        if (!user.isEmpty()){
            return user.get(0);
        }else {
            return null;
        }
    }

    @Override
    public User insert(User user){
        em.getTransaction().begin();
        em.persist(user);
        //em.flush();
        em.getTransaction().commit();
        return user;

    }

    @Override
    public User update(User user) {

        em.getTransaction().begin();
        user = em.merge(user);
        em.getTransaction().commit();
        return user;
    }
}
