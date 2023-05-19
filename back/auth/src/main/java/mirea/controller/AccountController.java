package mirea.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import mirea.data.UserIdRepository;
import mirea.data.UsersRepository;
import mirea.model.EntryUser;
import mirea.model.User;
import mirea.model.UserId;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;


@Tag(name="Контроллер для регистрации и логина пользователей")
@ConfigurationPropertiesScan()
@RestController
public class AccountController {

    Logger log = LoggerFactory.getLogger(AccountController.class);

    @Autowired
    UserIdRepository userIdRepo;

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
    public ResponseEntity<User> register(@RequestBody User user) {
        user.encodePassword(passwordEncoder);
        log.info("requested for registration user - {}", user);
        try {
            usersRepo.save(user);
            userIdRepo.save(new UserId(user.getId(), user.getName()));
            return new ResponseEntity<>(user, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.toString());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
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
    public ResponseEntity<User> loginUser(@RequestBody EntryUser entryUser) {
        User u;
        try {
            u = usersRepo.findByNumber(entryUser.getNumber());
        } catch (Exception e) {
            log.error(e.toString());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        if (u == null) {
            return new ResponseEntity<>(HttpStatusCode.valueOf(502));
        }
        if (entryUser.verify(u, passwordEncoder)) {
            return new ResponseEntity<>(u, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatusCode.valueOf(501));
    }
}