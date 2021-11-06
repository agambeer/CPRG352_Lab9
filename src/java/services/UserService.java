package services;

import dataaccess.UserDB;
import java.util.List;
import models.User;
import models.Role;

public class UserService {

    public List<User> getAll() throws Exception {
        UserDB userDB = new UserDB();
        List<User> users = userDB.getAll();
        return users;
    }

    public User get(String email) throws Exception {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        return user;
    }

    public void insert(String email, boolean active, String first_name, String last_name, String password, int role_id) throws Exception {
        UserDB userDB = new UserDB();
        User user = new User(email, active, first_name, last_name, password);
        user.setRole(new Role(role_id));
        userDB.insert(user);
    }

    public void update(String email, boolean active, String first_name, String last_name, String password, int role_id) throws Exception {
        UserDB userDB = new UserDB();
        User user = new User(email, active, first_name, last_name, password);
        user.setRole(new Role(role_id));
        userDB.update(user);
    }

    public void delete(String email) throws Exception {
        UserDB userDB = new UserDB();
        userDB.delete(email);
    }
}
