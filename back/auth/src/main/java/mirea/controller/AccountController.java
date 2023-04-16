package mirea.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import mirea.data.UsersRepository;
import mirea.model.EntryUser;
import mirea.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


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
    @PostMapping("/register")
    public String register(@RequestBody User user) {
        user.encodePassword(passwordEncoder);
        log.info("requested for registration user - {}", user);
        try {
            usersRepo.save(user);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.toString());
            return "fail";
        }
    }

    @Operation(
            summary = "Фиктивный метод"
    )
    @GetMapping("/login")
    public String loginPage() {
        return "loginpage";
    }

    @Operation(
            summary = "Логин пользователя"
    )
    @PostMapping("/login")
    public String loginUser(@RequestBody EntryUser entryUser) {
        User u = usersRepo.findByName(entryUser.getName());
        if (u == null) {
            return "failed";
        }
        return entryUser.verify(u, passwordEncoder)
                ? "success"
                : "failed";
    }


}