package mirea.model;


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.ArrayList;
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

    @Embedded
    @ManyToMany
    private List<UserId> students;

    @Embedded
    @ManyToMany
    private List<UserId> teachers;

    @JsonIgnore
    @NotNull
    @Size(max=20000)
    private String password;

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
        this.students = students == null ? new ArrayList<>() : students;
        this.teachers = teachers == null ? new ArrayList<>() : teachers;
        this.password = password;
    }

    public void encodePassword(PasswordEncoder encoder) {
        this.password = encoder.encode(this.password);
    }

}
