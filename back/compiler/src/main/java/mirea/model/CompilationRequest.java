package mirea.model;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.Getter;
import lombok.SneakyThrows;

@Data
@Getter
public class CompilationRequest {
    Code code;
    Input input;

    @JsonIgnore
    ObjectMapper mapper;

    @JsonCreator
    public CompilationRequest(
            @JsonProperty("code") Code code,
            @JsonProperty("input") Input input
    ) {
        this.code = code;
        this.input = input;
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    @SneakyThrows
    @Override
    public String toString() {
        return mapper.writeValueAsString(this);
    }
}
