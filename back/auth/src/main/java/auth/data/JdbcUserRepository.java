package auth.data;

import auth.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class JdbcUserRepository implements UserRepository {

    Logger log = LoggerFactory.getLogger(JdbcUserRepository.class);

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public JdbcUserRepository (JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void save(User user) {
        try {
            jdbcTemplate.update(
                    "insert into Users (name, email, password) values (?, ?, ?)",
                    user.getName(),
                    user.getEmail(),
                    user.getHashedPassword()
            );
        } catch (Exception e) {
            log.error("Error while saving user into Users {}", e.toString());
        }
    }

    @Override
    public List<User> findByEmail(String email) {
        try {
            var t = jdbcTemplate.query(
                    "select name, email, password from Users where email=?",
                    this::mapRowToUser,
                    email
            );
            return t.size() == 0
                    ? null
                    : t;
        } catch (Exception e) {
            log.error("Error while finding user from Users for user-email: {} {}", email, e.toString());
            return null;
        }

    }

    private User mapRowToUser(ResultSet row, int rowNum) throws SQLException {
        var u = new User(
                row.getString("name"),
                row.getString("email"),
                null
        );
        u.setHashedPassword(row.getString("password"));
        return u;
    }
}
