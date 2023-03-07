package mirea.idekiller.controller;

import mirea.idekiller.Hasher;
import mirea.idekiller.data.JdbcUserRepository;
import mirea.idekiller.model.account.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class AccountController {

    Logger log = LoggerFactory.getLogger(AccountController.class);

    @Autowired
    JdbcUserRepository userRepository;

    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/registration")
    public User register(@RequestBody User user) {
        log.info("Registered {}", user);
        userRepository.save(user);
        return user;
    }

    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/login")
    public String login(@RequestBody User user) {
        var users = userRepository.findByEmail(user.getEmail());
        if (users == null) {
            log.info("not founded user {}", user);
            return "fail";
        }
        else {
            for (User u : users) {
                if (Hasher.verify(user.getPassword(), u.getHashedPassword())) {
                    log.info("{} is {}", u, user);
                }
            }
        }
        return "success";
    }

}