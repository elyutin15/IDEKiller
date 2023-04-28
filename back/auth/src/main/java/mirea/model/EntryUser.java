package mirea.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.springframework.security.crypto.password.PasswordEncoder;

@Data
public class EntryUser {
    String number;
    String password;

    @JsonCreator
    public EntryUser(
            @JsonProperty("number") String number,
            @JsonProperty("password") String password
    ) {
        this.number = number;
        this.password = password;
    }

    public boolean verify(User user, PasswordEncoder encoder) {
        return encoder.matches(password, user.getPassword());
    }
}
