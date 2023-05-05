package mirea.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import mirea.data.UsersRepository;
import mirea.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpServerErrorException;

import java.util.Optional;

@Tag(name="Контроллер работы с данными пользователей")
@RestController
public class ProfileController {

    Logger log = LoggerFactory.getLogger(ProfileController.class);

    @Autowired
    UsersRepository usersRepo;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Профиль не найден"),
            @ApiResponse(responseCode = "200", description = "Успешное получение профиля")
    })
    @Operation(
            summary = "Получение профиля"
    )
    @CrossOrigin(origins = {"${frontend.url}"})
    @GetMapping("/profile/{id}")
    public User getUser(@PathVariable Long id) {
        Optional<User> u = usersRepo.findById(id);
        if (u.isPresent()) {
            return u.get();
        }
        log.error("User with id {} not found", id);
        throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Профиль не найден"),
            @ApiResponse(responseCode = "200", description = "Успешное обновление профиля")
    })
    @Operation(
            summary = "Обновление существующего профиля"
    )
    @CrossOrigin(origins = {"${frontend.url}"})
    @PatchMapping("/profile/{id}")
    public void updateUser(@RequestBody User user, @PathVariable Long id) {
        Optional<User> u = usersRepo.findById(id);
        if (u.isEmpty()) {
            log.error("User with id {} not found", id);
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
        User extractedUser = u.get();
        extractedUser.setAbout(user.getAbout());
        extractedUser.setName(user.getName());
        extractedUser.setNumber(user.getNumber());
        extractedUser.setProfilePic(user.getProfilePic());
        extractedUser.setStudents(user.getStudents());
        extractedUser.setTeachers(user.getTeachers());
        if (user.getPassword() != null) {
            extractedUser.setPassword(user.getPassword());
        }
        usersRepo.save(extractedUser);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "500", description = "Профиль уже существует"),
            @ApiResponse(responseCode = "200", description = "Успешное сохранение нового профиля")
    })
    @Operation(
            summary = "Сохранение нового профиля"
    )
    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/profile/{id}")
    public void saveUser(@RequestBody User user, @PathVariable Long id) {
        Optional<User> u = usersRepo.findById(id);
        if (u.isEmpty()) {
            usersRepo.save(user);
        }
        else {
            log.error("User is exist now. Cant save user");
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
    }
}
