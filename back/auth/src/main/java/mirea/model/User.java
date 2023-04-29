package mirea.model;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;

import static com.fasterxml.jackson.annotation.JsonProperty.Access.WRITE_ONLY;

@Data
@Entity
@Table(name="users")
@NoArgsConstructor
public class User{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Size(max=20000)
    private String profilePic;

    @NotNull
    @Size(max=20000)
    private String name;


    @Size(max=20000)
    @NotNull
    @Column(unique = true)
    private String number;

    @Size(max=20000)
    private String about;

    @ManyToMany
    private List<UserId> students;

    @ManyToMany
    private List<UserId> teachers;

    @Setter(AccessLevel.NONE)
    @JsonIgnore
    @NotNull
    @Size(max=20000)
    private String password;

    @JsonIgnore
    @Transient
    private ObjectMapper mapper;

    @JsonCreator
    public User(
            @JsonProperty("profilePic") String picture,
            @JsonProperty("name") String name,
            @JsonProperty("number") String number,
            @JsonProperty("students") List<UserId> students,
            @JsonProperty("teachers") List<UserId> teachers,
            @JsonProperty(value="password", access=WRITE_ONLY) String password
    ) {
        this.profilePic = picture;
        this.name = name;
        this.number = number;
        this.students = students;
        this.teachers = teachers;
        this.password = password;
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    public void encodePassword(PasswordEncoder encoder) {
        this.password = encoder.encode(this.password);
    }

    @SneakyThrows
    @Override
    public String toString() {
        return mapper.writeValueAsString(this);
    }
}
