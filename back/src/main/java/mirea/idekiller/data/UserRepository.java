package mirea.idekiller.data;

import mirea.idekiller.model.account.User;

import java.util.List;

public interface UserRepository {
    void save(User user);
    List<User> findByEmail(String email);
}
