package mirea.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
public class CodeDto {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    @Embedded
    Code code;

    @JsonIgnore
    Long userid;

    String name;


    @JsonCreator
    public CodeDto(
            @JsonProperty("code") Code code,
            @JsonProperty("userid") Long id,
            @JsonProperty("codeName") String name
    ) {
        this.code = code;
        this.userid = id;
        this.name = name;
    }
}
