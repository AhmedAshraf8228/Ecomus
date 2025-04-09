package iti.jets.service;

import iti.jets.dao.impl.*;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.*;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.util.*;


@WebServlet("/register")
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager entityManager = UserRepoImpl.getEntityManagerFactory().createEntityManager();
        try {
            UserRepoImpl userRepo = new UserRepoImpl(entityManager, User.class);
            Map<String, String[]> parameterMap = req.getParameterMap();
            Map<String, String[]> modifiableParameterMap = new HashMap<>(parameterMap);
            modifiableParameterMap.forEach((key, value) -> {
                if (value[0].isEmpty()) {
                    modifiableParameterMap.put(key, new String[]{null});
                }
            });

            System.out.println(modifiableParameterMap);

            User newUser = new User();

            System.out.println(parameterMap);
            BeanUtils.populate(newUser, modifiableParameterMap);
            String bd = req.getParameter("birthday");
            if(bd != null && !bd.isEmpty()){
                newUser.setBD(Date.valueOf(bd));
            }
             if(userRepo.insert(newUser) != null){
                resp.sendRedirect("register.html");
             };

        } catch (InvocationTargetException | IllegalAccessException e) {
            throw new RuntimeException(e);
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

}