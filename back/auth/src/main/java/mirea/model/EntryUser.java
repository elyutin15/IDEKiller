package mirea.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.springframework.security.crypto.password.PasswordEncoder;

import static com.fasterxml.jackson.annotation.JsonProperty.Access.WRITE_ONLY;

@Data
public class EntryUser {
    String number;
    String password;

    @JsonCreator
    public EntryUser(
            @JsonProperty("number") String number,
            @JsonProperty(value="password", access = WRITE_ONLY) String password
    ) {
        this.number = number;
        this.password = password;
    }

    public boolean verify(User user, PasswordEncoder encoder) {
        return encoder.matches(password, user.getPassword());
    }
}
