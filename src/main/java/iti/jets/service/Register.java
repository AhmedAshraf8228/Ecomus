package iti.jets.service;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import iti.jets.dao.impl.UserRepoImpl;
import iti.jets.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/register")
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserRepoImpl userRepo = new UserRepoImpl();
        try {
            Map<String, String[]> parameterMap = req.getParameterMap();
            Map<String, String[]> modifiableParameterMap = new HashMap<>(parameterMap);
            modifiableParameterMap.forEach((key, value) -> {
                if (value[0].isEmpty()) {
                    modifiableParameterMap.put(key, new String[]{null});
                }
            });

            System.out.println(modifiableParameterMap);

            User newUser = new User();

            BeanUtils.populate(newUser, modifiableParameterMap);
            String bd = req.getParameter("birthday");
            if(bd != null && !bd.isEmpty()){
                newUser.setBD(Date.valueOf(bd));
            }
            User user = userRepo.insert(newUser);
             if(user != null){
                 HttpSession session = req.getSession(true);
                 session.setAttribute("login", true);
                 session.setAttribute("id", user.getUserId());
                 session.setAttribute("userName", user.getUserName());
                 resp.sendRedirect("home");
             };

        } catch (InvocationTargetException | IllegalAccessException e) {
            throw new RuntimeException(e);
        } finally {
            if (userRepo.getEntityManager() != null && userRepo.getEntityManager().isOpen()) {
                userRepo.getEntityManager().close();
            }
        }
    }

}