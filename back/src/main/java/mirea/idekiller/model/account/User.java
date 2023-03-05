package mirea.idekiller.model.account;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.*;
import mirea.idekiller.Hasher;

@Data
public class User {
    String name;
    String email;

    @Getter(AccessLevel.NONE)
    @Setter(AccessLevel.NONE)
    private char[] password;

    @JsonIgnore
    private Integer hashedPassword;
    @JsonIgnore
    ObjectMapper mapper;

    @JsonCreator
    public User(
            @JsonProperty("name") String name,
            @JsonProperty("email") String email,
            @JsonProperty("password") char[] password
    ) {
        this.name = name;
        this.email = email;
        this.password = password;
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);




    }

    public String getHashedPassword() {
        return Hasher.hash(password);
    }

    @SneakyThrows
    @Override
    public String toString() {
        return mapper.writeValueAsString(this);
    }
}
