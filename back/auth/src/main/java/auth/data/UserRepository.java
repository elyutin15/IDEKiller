package auth.data;

import auth.model.User;

import java.util.List;

public interface UserRepository {
    void save(User user);
    List<User> findByEmail(String email);
}
