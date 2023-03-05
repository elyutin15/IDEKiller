package mirea.idekiller.data;

import mirea.idekiller.model.account.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JdbcUserRepository implements UserRepository {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public JdbcUserRepository (JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public void save(User user) {
        jdbcTemplate.update(
                "insert into Users (name, email, password) values (?, ?, ?)",
                user.getName(),
                user.getEmail(),
                user.getHashedPassword()
        );
    }
}
