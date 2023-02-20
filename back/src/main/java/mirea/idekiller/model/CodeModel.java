package mirea.idekiller.model;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;

public class CodeModel {
    String code;

    @JsonIgnore
    ObjectMapper mapper;

    @JsonCreator
    CodeModel(
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
