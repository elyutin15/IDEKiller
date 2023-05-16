package mirea.model;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.SneakyThrows;

@Data
public class Code {
    String code;

    Language language;

    @JsonIgnore
    ObjectMapper mapper;

    @JsonCreator
    public Code(
            @JsonProperty("code") String code,
            @JsonProperty("language") String language
    ) {
        this.code = code;
        this.language = Language.parse(language);
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    @SneakyThrows
    @Override
    public String toString() {
        return mapper.writeValueAsString(this);
    }
}
