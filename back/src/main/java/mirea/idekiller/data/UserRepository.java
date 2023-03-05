package mirea.idekiller.data;

import mirea.idekiller.model.account.User;

public interface UserRepository {
    void save(User user);
}
