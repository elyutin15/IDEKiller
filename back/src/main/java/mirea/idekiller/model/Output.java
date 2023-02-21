package mirea.idekiller.model;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.SneakyThrows;

@Data
public class Output {
    String output;

    @JsonIgnore
    ObjectMapper mapper;

    @JsonCreator
    public Output(
            @JsonProperty("output") String code
    ) {
        this.output = code;
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    @SneakyThrows
    @Override
    public String toString() {
        return mapper.writeValueAsString(this);
    }
}
