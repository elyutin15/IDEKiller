package mirea.model;


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Embeddable
@NoArgsConstructor
public class Code {
    String code;

    Language language;


    @JsonCreator
    public Code(
            @JsonProperty("code") String code,
            @JsonProperty("language") String language
    ) {
        this.code = code;
        this.language = Language.parse(language);
    }
}
