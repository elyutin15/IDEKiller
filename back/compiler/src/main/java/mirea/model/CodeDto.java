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
    @JsonIgnore
    Long id;

    @Embedded
    Code code;

    Long userid;


    @JsonCreator
    public CodeDto(
            @JsonProperty("code") Code code,
            @JsonProperty("id") Long id
    ) {
        this.code = code;
        this.userid = id;
    }
}
