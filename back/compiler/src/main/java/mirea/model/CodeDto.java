package mirea.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
public class CodeDto {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    @Embedded
    Code code;

    Long userid;

}
