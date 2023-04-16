package mirea.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import mirea.data.UsersRepository;
import mirea.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Tag(name="Контроллер работы с данными пользователей")
@RestController
public class ProfileController {

    Logger log = LoggerFactory.getLogger(ProfileController.class);

    @Autowired
    UsersRepository usersRepo;


    @GetMapping("/profile/{name}")
    public User getUser(@PathVariable String name) {
        User u = usersRepo.findByName(name);
        if (u != null) {
            return u;
        }
        log.error("User with name {} not found", name);
        return null;
    }

    @PatchMapping("/profile/{name}")
    public String updateUser(@RequestBody User user, @PathVariable String name) {
        User u = usersRepo.findByName(name);
        if (u == null) {
            log.error("User with name {} not found", name);
            return "not found";
        }
        user.setId(u.getId());
        usersRepo.save(user);
        return "updated";
    }

    @PostMapping("/profile/{name}")
    public String saveUser(@RequestBody User user, @PathVariable String name) {
        User u = usersRepo.findByName(name);
        if (u == null) {
            usersRepo.save(user);
            return "success";
        }
        else {
            log.error("User is exist now. Cant save user");
            return "fail";
        }
    }
}
