package mirea.idekiller.model.compiler;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.SneakyThrows;

@Data
public class Code {
    String code;

    @JsonIgnore
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
