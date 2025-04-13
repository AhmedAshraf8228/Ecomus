package iti.jets.dao.repo;

import java.util.List;

public interface GenericRepo<T , ID> {

    int countRows();
    List<T> findAll();
    T findById(int id);
    T insert(T t);

    T update(T t);
    void deleteById(int id);

    void delete(T t);



}
