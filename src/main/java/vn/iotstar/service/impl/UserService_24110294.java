package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.IUserDao_24110294;
import vn.iotstar.dao.impl.UserDao_24110294;
import vn.iotstar.model.User_24110294;
import vn.iotstar.service.IUserService_24110294;

public class UserService_24110294 implements IUserService_24110294 {
    private final IUserDao_24110294 dao = new UserDao_24110294();
    public List<User_24110294> findAll(int page, int pageSize) { return dao.findAll(page, pageSize); }
    public int count() { return dao.count(); }
    public User_24110294 findByUsername(String username) { return dao.findByUsername(username); }
    public User_24110294 findByEmail(String email) { return dao.findByEmail(email); }
    public User_24110294 login(String username, String password) {
        User_24110294 u = dao.findByUsername(username);
        return u != null && u.isActive() && u.getPassword().equals(password) ? u : null;
    }
    public boolean insert(User_24110294 user) { return dao.insert(user); }
    public boolean update(User_24110294 user) { return dao.update(user); }
    public boolean delete(String username) { return dao.delete(username); }
    public boolean activate(String username) { return dao.activate(username); }
}

