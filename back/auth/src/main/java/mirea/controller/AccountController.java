package mirea.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import mirea.data.UsersRepository;
import mirea.model.EntryUser;
import mirea.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.http.HttpStatusCode;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpServerErrorException;


@Tag(name="Контроллер для регистрации и логина пользователей")
@ConfigurationPropertiesScan()
@RestController
public class AccountController {

    Logger log = LoggerFactory.getLogger(AccountController.class);

    @Autowired
    UsersRepository usersRepo;

    @Autowired
    PasswordEncoder passwordEncoder;


    @Operation(
            summary = "Регистрация пользователя"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Любая ошибка при запросе к бд"),
            @ApiResponse(responseCode = "200", description = "Успешная регистрация")
    })
    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/register")
    public User register(@RequestBody User user) {
        user.encodePassword(passwordEncoder);
        log.info("requested for registration user - {}", user);
        try {
            return usersRepo.save(user);
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.toString());
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500), "Ошибка на сервере");
        }
    }

    @Operation(
            summary = "Фиктивный метод"
    )
    @GetMapping("/login")
    public String loginPage() {
        return "loginpage";
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Успех"),
            @ApiResponse(responseCode = "500", description = "Ошибка в базе данных"),
            @ApiResponse(responseCode = "501", description = "Ошибка. Пароль неверный"),
            @ApiResponse(responseCode = "502", description = "Ошибка. Пользователь не найден")
    })
    @Operation(
            summary = "Логин пользователя"
    )
    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/login")
    public User loginUser(@RequestBody EntryUser entryUser) {
        User u;
        try {
            u = usersRepo.findByNumber(entryUser.getNumber());
        } catch (Exception e) {
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
        if (u == null) {
            throw new HttpServerErrorException(HttpStatusCode.valueOf(502), "Ошибка. Пользователь не найден");
        }
        if (entryUser.verify(u, passwordEncoder)) {
            return u;
        }
        throw new HttpServerErrorException(HttpStatusCode.valueOf(501), "Ошибка. Пароль неверный");
    }


}