package mirea.controller;

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


    @GetMapping("/profile/{id}")
    public User getUser(@PathVariable Long id) {
        Optional<User> u = usersRepo.findById(id);
        if (u.isPresent()) {
            return u.get();
        }
        log.error("User with id {} not found", id);
        throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
    }

    @PatchMapping("/profile/{id}")
    public void updateUser(@RequestBody User user, @PathVariable Long id) {
        Optional<User> u = usersRepo.findById(id);
        if (u.isEmpty()) {
            log.error("User with id {} not found", id);
            throw new HttpServerErrorException(HttpStatusCode.valueOf(500));
        }
        user.setId(u.get().getId());
        usersRepo.save(user);
    }

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
