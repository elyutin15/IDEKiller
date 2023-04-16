package mirea.model;

import lombok.Data;
import org.springframework.security.crypto.password.PasswordEncoder;

@Data
public class EntryUser {
    String name;
    String pass;

    public boolean verify(User user, PasswordEncoder encoder) {
        return encoder.matches(pass, user.getPassword());
    }
}
