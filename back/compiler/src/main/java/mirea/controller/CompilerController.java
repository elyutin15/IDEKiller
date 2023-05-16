package mirea.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import mirea.Compiler;
import mirea.data.CodeRepository;
import mirea.model.CodeDto;
import mirea.model.CompilationRequest;
import mirea.model.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpServerErrorException;

import java.util.List;

@Tag(name="Контроллер компилятора и смежных функцийз")
@RestController
public class CompilerController {

    @Autowired
    CodeRepository repo;

    @Autowired
    private Compiler compiler;

    Logger log = LoggerFactory.getLogger(CompilerController.class);


    @Operation(
            summary = "Компиляция кода"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Произошла ошибка"),
            @ApiResponse(responseCode = "200", description = "Код успешно скомпилировался")
    })
    @CrossOrigin(origins = {"${frontend.url}"})
    @ResponseBody
    @PostMapping("/")
    public Output compileCode(@RequestBody CompilationRequest compilationRequest) {
        log.info("Requested compilation: {}", compilationRequest);
        try {
            Output out = compiler.compile(compilationRequest);
            log.info("Outputted code: {}", out.getOutput());
            return out;
        } catch (Exception e) {
            log.error(e.toString());
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
    }

    @Operation(
            summary = "Получение кода по id кода"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Ошибка на сервере"),
            @ApiResponse(responseCode = "200", description = "Код успешно получен")
    })
    @CrossOrigin(origins = {"${frontend.url}"})
    @ResponseBody
    @PostMapping("/{id}")
    public CodeDto getCode(@PathVariable Integer codeId) {
        try {
            return repo.findById(codeId);
        } catch (Exception e) {
            log.error(e.toString());
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
    }

    @Operation(
            summary = "Сохранение кода"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Произошла ошибка"),
            @ApiResponse(responseCode = "200", description = "Код успешно сохранен")
    })
    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/save")
    public String saveCode(@RequestBody CodeDto dto) {
        try {
            repo.save(dto);
            log.info("saved code {}", dto);
            return "ok";
        } catch (Exception e) {
            log.error(e.toString());
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
    }

    @Operation(
            summary = "Получение кодов"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Любая ошибка при запросе к бд"),
            @ApiResponse(responseCode = "200", description = "Успешное получение 0+ кодов")
    })
    @CrossOrigin(origins = {"${frontend.url}"})
    @GetMapping("/get")
    public List<CodeDto> getCodes(@RequestHeader Long userid) {
        try {
            return repo.findAllByUserid(userid);
        } catch (Exception e) {
            log.error(e.toString());
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
    }
}
