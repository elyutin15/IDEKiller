package mirea.model;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Transient;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;

@Data
@Embeddable
@NoArgsConstructor
public class Code {
    String code;

    @JsonIgnore
    @Transient
    ObjectMapper mapper;

    @JsonCreator
    public Code(
            @JsonProperty("code") String code
    ) {
        this.code = code;
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    @SneakyThrows
    @Override
    public String toString() {
        return mapper.writeValueAsString(this);
    }
}
