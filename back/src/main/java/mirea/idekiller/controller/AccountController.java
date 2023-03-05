package mirea.idekiller.controller;

import mirea.idekiller.data.JdbcUserRepository;
import mirea.idekiller.model.account.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AccountController {

    Logger log = LoggerFactory.getLogger(AccountController.class);

    @Autowired
    JdbcUserRepository userRepository;

    @PostMapping("/registration")
    public User register(@RequestBody User user) {
        log.info(String.valueOf(user));
        userRepository.save(user);
        return user;
    }
}