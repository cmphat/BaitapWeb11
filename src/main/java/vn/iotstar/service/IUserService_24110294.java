package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.User_24110294;

public interface IUserService_24110294 {
    List<User_24110294> findAll(int page, int pageSize);
    int count();
    User_24110294 findByUsername(String username);
    User_24110294 findByEmail(String email);
    User_24110294 login(String username, String password);
    boolean insert(User_24110294 user);
    boolean update(User_24110294 user);
    boolean delete(String username);
    boolean activate(String username);
}

