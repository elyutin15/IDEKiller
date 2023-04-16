package mirea.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
public class UserId {
    @Id
    Long id;

    @JsonCreator
    public UserId(
            @JsonProperty("id") Long id
    ) {
        this.id = id;
    }
}
