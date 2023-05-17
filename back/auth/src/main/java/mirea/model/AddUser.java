package mirea.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
public class AddUser {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonIgnore
    Long id;

    Long idFrom;
    Long idTo;

    @JsonCreator
    public AddUser(
            @JsonProperty("idFrom") Long idFrom,
            @JsonProperty("idTo") Long idTo
    ) {
        this.idFrom = idFrom;
        this.idTo = idTo;
    }
}
