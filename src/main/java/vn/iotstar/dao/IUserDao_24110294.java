package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.User_24110294;

public interface IUserDao_24110294 {
    List<User_24110294> findAll(int page, int pageSize);
    int count();
    User_24110294 findByUsername(String username);
    User_24110294 findByEmail(String email);
    boolean insert(User_24110294 user);
    boolean update(User_24110294 user);
    boolean delete(String username);
    boolean activate(String username);
}

