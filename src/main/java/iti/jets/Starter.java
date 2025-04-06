package iti.jets;

import iti.jets.entity.Product;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Starter
{

    public static void main(String[] args) {
        EntityManagerFactory emf = null;
        EntityManager em = null;

        try {
            emf = Persistence.createEntityManagerFactory("jpa-mysql");
        }catch (Exception e) {
            throw new RuntimeException("Failed to initialize EntityManagerFactory", e);
        }


        try {
            em =emf.createEntityManager();
            em.getTransaction().begin();


//            User emp = new User("menna yasswe" ,"menna@gmail.com" , "1234" , null , null ,
//                    "sadat city" , "cairo" , "abu bakr" , "160" ,
//                    null , null , "01020342684" );

            Product emp = new Product("puzzle 1" , "puzzle 1 desc" , 100 , 600);
            em.persist(emp);

            em.getTransaction().commit();
            System.out.println("Saved Product with ID: " + emp.getProductId());

        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (em != null) em.close();
            if (emf != null && emf.isOpen()) {
                emf.close();
            }
        }

    }

}
